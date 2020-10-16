import 'package:badits/models/habit.dart';
import 'package:badits/services/service_locator.dart';
import 'package:badits/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:intl/intl.dart';

import '../widgets/create_habit_dialog_widget.dart';

class HabitsToComplete extends StatefulWidget {
  @override
  _HabitsToCompleteState createState() => _HabitsToCompleteState();
}

class _HabitsToCompleteState extends State<HabitsToComplete> {
  final _dateFormat = 'dd.MM.yyyy';
  final _emojiParser = EmojiParser();

  String _getFormattedDate(DateTime date) {
    return DateFormat(_dateFormat).format(date);
  }

  DateTime _getDateTimeNowFromMidnight() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  Future<List<Habit>> _getHabitsForToday() async {
    StorageService storageService = locator<StorageService>();
    // Careful here we do not consider the time for the date.
    // This is important because at the moment we change the state we would only get the habits which the due date is bigger then now... therefore we always set the time to 00:00
    return storageService.getActiveHabitsForDate(_getDateTimeNowFromMidnight());
  }

  void _showCreateHabitDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) =>
            CreateHabitDialogWidget(this._onCreateHabitFinishedCallback),
        barrierDismissible: true);
  }

  void _onCreateHabitFinishedCallback(Habit habit) async {
    StorageService storageService = locator<StorageService>();
    await storageService.insertHabit(habit);
    // Needed for updating the widget because the habits have changed...
    setState(() {});
  }

  List<Widget> _generateHabitList(List<Habit> habits) {
    return List.generate(habits.length, (index) {
      final habit = habits[index];
      return Card(
        child: Container(
          padding: EdgeInsets.all(5),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    habit.name,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    '${_getFormattedDate(habit.dueDate)}',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                  Text(habit.description),
                ],
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: Row(
                    children: [
                      FlatButton(onPressed: null, child: Text('Not Completed')),
                      FlatButton(onPressed: null, child: Text('Completed'))
                    ],
                  ))
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateHabitDialog(context);
        },
        backgroundColor: Colors.yellow,
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      body: FutureBuilder(
        future: _getHabitsForToday(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final List<Habit> habits = snapshot.data;
            return Container(
                padding: EdgeInsets.all(5),
                child: GridView.count(
                    mainAxisSpacing: 5,
                    crossAxisCount: 1,
                    children: [
                      Card(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Rock it today!',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '10/10 completed',
                                style: Theme.of(context).textTheme.headline3,
                              ),
                              Text(
                                _emojiParser.emojify(':muscle:'),
                                style: Theme.of(context).textTheme.headline1,
                              )
                            ],
                          ),
                        ),
                      ),
                      ..._generateHabitList(habits)
                    ]));
          }
          return Container();
        },
      ),
    );
  }
}
