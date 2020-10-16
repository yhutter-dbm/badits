import 'package:badits/models/habit.dart';
import 'package:badits/screens/dashboard_screen.dart';
import 'package:badits/screens/habit_suggestion_screen.dart';
import 'package:badits/services/service_locator.dart';
import 'package:badits/services/storage_service.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  Future<List<Habit>> _getHabitsFromStorage() async {
    StorageService storageService = locator<StorageService>();
    return storageService.getHabits();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getHabitsFromStorage(),
        builder: (context, snapshot) {
          final List<Habit> habits = snapshot.data;
          if (snapshot.connectionState == ConnectionState.done) {
            if (habits.length > 0) {
              return DashboardScreen();
            }
            return HabitSuggestionScreen();
          }
          return Scaffold(
            body: Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Habit Reminder',
                  style: TextStyle(fontFamily: 'TitleFont', fontSize: 35),
                  textAlign: TextAlign.center,
                ),
                Image(image: AssetImage('images/welcome_screen.png'))
              ],
            )),
          );
        });
  }
}
