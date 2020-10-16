import 'package:badits/models/habit.dart';
import 'package:badits/screens/dashboard_screen.dart';
import 'package:badits/screens/habit_suggestion_screen.dart';
import 'package:badits/services/service_locator.dart';
import 'package:badits/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

class WelcomeScreen extends StatelessWidget {
  final _emojiParser = EmojiParser();

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
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center,
                ),
                Text(
                  _emojiParser.emojify(':heart_eyes:'),
                  style: Theme.of(context).textTheme.headline1,
                  textAlign: TextAlign.center,
                ),
              ],
            )),
          );
        });
  }
}
