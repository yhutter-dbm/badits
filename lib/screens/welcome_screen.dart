import 'package:badits/models/habit.dart';
import 'package:badits/screens/dashboard_screen.dart';
import 'package:badits/screens/habit_suggestion_screen.dart';
import 'package:badits/services/service_locator.dart';
import 'package:badits/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            // if (habits.length > 0) {
            //   return DashboardScreen();
            // }
            // return HabitSuggestionScreen();
          }
          return Scaffold(
            backgroundColor: Colors.white,
            body: Container(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Badits',
                      style: TextStyle(
                          fontFamily: 'ObibokBold',
                          fontSize: 30,
                          color: Colors.black),
                      textAlign: TextAlign.left,
                    ),
                    Spacer(),
                    Image.asset('assets/images/chilling.png'),
                    Spacer(),
                    Text(
                      "Hi!\r\nWe are here to improve your habits",
                      style: TextStyle(
                          fontFamily: 'ObibokRegular',
                          fontSize: 30,
                          color: Colors.black),
                      textAlign: TextAlign.left,
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Spacer(),
                        FlatButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                Text('Continue',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'ObibokRegular',
                                        fontSize: 20)),
                                Container(
                                    margin: EdgeInsets.only(left: 15.0),
                                    child: SvgPicture.asset(
                                        'assets/icons/arrow.svg'))
                              ],
                            ))
                      ],
                    )
                  ],
                )),
          );
        });
  }
}
