import 'package:badits/models/habit.dart';
import 'package:badits/screens/dashboard_screen.dart';
import 'package:badits/screens/habit_suggestion_screen.dart';
import 'package:badits/services/service_locator.dart';
import 'package:badits/services/storage_service.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  List<Habit> _habitsInStorage = [];

  Future<void> _openStorage() async {
    StorageService storageService = locator<StorageService>();
    await storageService.open();
    _habitsInStorage = await storageService.getHabits();
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _openStorage(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (_habitsInStorage.length > 0) {
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
