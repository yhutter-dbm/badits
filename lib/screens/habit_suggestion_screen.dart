import 'dart:developer';

import 'package:badits/helpers/dummy_data_helper.dart';
import 'package:badits/dialogues/create_habit_dialog_widget.dart';
import 'package:badits/models/habit.dart';
import 'package:badits/models/routes.dart';
import 'package:badits/services/service_locator.dart';
import 'package:badits/services/storage_service.dart';
import 'package:badits/widgets/add_habit_button_widget.dart';
import 'package:badits/widgets/habit_suggestion_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HabitSuggestionScreen extends StatelessWidget {
  final List<HabitSuggestionButtonWidget> _habitSuggestions =
      DummyDataHelper.getHabits()
          .map((habit) => HabitSuggestionButtonWidget(habit: habit))
          .toList();

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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Choose your\nhabit',
                    style: TextStyle(
                        fontFamily: 'ObibokRegular',
                        fontSize: 20,
                        color: Colors.black),
                    textAlign: TextAlign.left,
                  ),
                ),
                Spacer(),
                Image.asset('assets/images/chilling.png'),
                GridView.count(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    children: _habitSuggestions),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AddHabitButtonWidget(
                      onPressed: () {
                        // TODO: Show create habit dialog / screen once it is redesigned...
                      },
                    ),
                    FlatButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Text("Let's start",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'ObibokRegular',
                                    fontSize: 20)),
                            Container(
                                margin: EdgeInsets.only(left: 15.0),
                                child:
                                    SvgPicture.asset('assets/icons/arrow.svg'))
                          ],
                        ))
                  ],
                )
              ],
            )));
  }
}
