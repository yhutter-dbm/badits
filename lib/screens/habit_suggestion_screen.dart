import 'package:badits/helpers/dummy_data_helper.dart';
import 'package:badits/screens/create_habit_dialog.dart';
import 'package:badits/models/habit.dart';
import 'package:badits/models/routes.dart';
import 'package:badits/services/service_locator.dart';
import 'package:badits/services/storage_service.dart';
import 'package:flutter/material.dart';

class HabitSuggestionScreen extends StatelessWidget {
  final List<Habit> _dummyHabits = DummyDataHelper.getHabits();

  List<Widget> _generateSuggestions(BuildContext context) {
    return _dummyHabits
        .map((habit) => GestureDetector(
              onTap: () async {
                StorageService storageService = locator<StorageService>();
                await storageService.insertHabit(habit);
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
        builder: (_) => CreateHabitDialogWidget((habit) async {
              StorageService storageService = locator<StorageService>();
              await storageService.insertHabit(habit);
              Navigator.of(context)
                  .pushReplacementNamed(DASHBOARD_SCREEN_ROUTE);
            }),
        barrierDismissible: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
