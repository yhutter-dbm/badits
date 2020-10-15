import 'package:badits/screens/habit_suggestion_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  Future<void> _simulateDataLoading() {
    // TODO: Add any data loading which needs to happen before starting the app here...
    return Future.delayed(Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _simulateDataLoading(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // We are finished fetching any startup data here...
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
