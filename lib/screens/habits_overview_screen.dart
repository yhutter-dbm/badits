import 'package:badits/models/habit.dart';
import 'package:badits/services/service_locator.dart';
import 'package:badits/services/storage_service.dart';
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
                      FlatButton(onPressed: null, child: Icon(Icons.edit)),
                      FlatButton(onPressed: null, child: Icon(Icons.delete))
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
    // Careful here we do not consider the time for the date.
    // This is important because at the moment we change the state we would only get the habits which the due date is bigger then now... therefore we always set the time to 00:00
    return storageService.getHabits();
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
