import 'package:badits/models/habit.dart';
import 'package:badits/services/service_locator.dart';
import 'package:badits/services/storage_service.dart';
import 'package:badits/widgets/delete_habit_dialog_widget.dart';
import 'package:badits/widgets/edit_habit_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:intl/intl.dart';

class HabitsOverViewScreen extends StatefulWidget {
  @override
  _HabitsOverviewScreenState createState() => _HabitsOverviewScreenState();
}

// TODO: Currently this class and the HabitsToComplete screen are very similiar... refactor after finalization
class _HabitsOverviewScreenState extends State<HabitsOverViewScreen> {
  final _dateFormat = 'dd.MM.yyyy';
  final _emojiParser = EmojiParser();

  String _getFormattedDate(DateTime date) {
    return DateFormat(_dateFormat).format(date);
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
                      FlatButton(
                          onPressed: () {
                            this._showEditHabitDialog(context, habit);
                          },
                          child: Icon(Icons.edit)),
                      FlatButton(
                          onPressed: () {
                            this._showDeleteHabitDialog(context, habit);
                          },
                          child: Icon(Icons.delete))
                    ],
                  ))
            ],
          ),
        ),
      );
    });
  }

  Future<List<Habit>> _getAllHabits() async {
    StorageService storageService = locator<StorageService>();
    return storageService.getHabits();
  }

  void _showEditHabitDialog(BuildContext context, Habit habit) {
    showDialog(
        context: context,
        builder: (_) =>
            EditHabitDialogWidget(habit, this._onEditHabitFinishedCallback),
        barrierDismissible: true);
  }

  void _showDeleteHabitDialog(BuildContext context, Habit habit) {
    showDialog(
        context: context,
        builder: (_) => DeleteHabitDialogWidget(
            habit, this._onHabitDeleteConfirmedCallback),
        barrierDismissible: true);
  }

  void _onEditHabitFinishedCallback(Habit habit) async {
    StorageService storageService = locator<StorageService>();
    await storageService.updateHabit(habit);
    // Needed for updating the widget because the habits have changed...
    setState(() {});
  }

  void _onHabitDeleteConfirmedCallback(Habit habit) async {
    StorageService storageService = locator<StorageService>();
    await storageService.deleteHabit(habit);
    // Needed for updating the widget because the habits have changed...
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _getAllHabits(),
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
                                'Look at all those habits!',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                _emojiParser.emojify(':heart_eyes:'),
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
