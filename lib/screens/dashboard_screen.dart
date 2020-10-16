import 'package:badits/models/habit.dart';
import 'package:badits/services/service_locator.dart';
import 'package:badits/services/storage_service.dart';
import 'package:flutter/material.dart';

import 'create_habit_dialog.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Future<List<Habit>> _getHabitsFromStorage() async {
    StorageService storageService = locator<StorageService>();
    return storageService.getHabits();
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
        title: Text('Dashboard'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _getHabitsFromStorage(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  final habit = snapshot.data[index];
                  return ListTile(
                      title: Text(habit.name),
                      subtitle: Text(habit.description));
                },
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
