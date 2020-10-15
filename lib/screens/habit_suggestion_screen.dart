import 'package:badits/screens/create_habig_dialog.dart';
import 'package:badits/models/habit.dart';
import 'package:badits/models/routes.dart';
import 'package:flutter/material.dart';
import 'package:lipsum/lipsum.dart' as lipsum;

class HabitSuggestionScreen extends StatelessWidget {
  final List<Habit> _dummyHabits = [
    Habit(
        name: 'Habit One',
        description: lipsum.createWord(numWords: 10),
        dueDate: DateTime.now()),
    Habit(
        name: 'Habit Two',
        description: lipsum.createWord(numWords: 10),
        dueDate: DateTime.now()),
    Habit(
        name: 'Habit Three',
        description: lipsum.createWord(numWords: 10),
        dueDate: DateTime.now()),
  ];

  List<Widget> _generateSuggestions(BuildContext context) {
    return _dummyHabits
        .map((habit) => GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(DASHBOARD_SCREEN_ROUTE);
              },
              child: Card(
                  child: ListTile(
                leading: Icon(Icons.favorite),
                title: Text(habit.name),
                subtitle: Text(habit.description),
              )),
            ))
        .toList();
  }

  void _showCreateHabitDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => CreateHabitDialogWidget(),
        barrierDismissible: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showCreateHabitDialog(context);
          },
          backgroundColor: Colors.blue,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          title: Text('Choose a habit'),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(5),
          child: GridView.count(
              crossAxisSpacing: 2,
              crossAxisCount: 2,
              children: _generateSuggestions(context)),
        ));
  }
}
