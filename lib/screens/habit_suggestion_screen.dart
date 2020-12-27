import 'package:badits/helpers/dummy_data_helper.dart';
import 'package:badits/models/routes.dart';
import 'package:badits/screen_arguments/create_habit_screen_arguments.dart';
import 'package:badits/models/habit.dart';
import 'package:badits/services/service_locator.dart';
import 'package:badits/services/storage_service.dart';
import 'package:badits/widgets/add_habit_button_widget.dart';
import 'package:badits/widgets/choose_habit_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HabitSuggestionScreen extends StatefulWidget {
  @override
  _HabitSuggestionScreenState createState() => _HabitSuggestionScreenState();
}

class _HabitSuggestionScreenState extends State<HabitSuggestionScreen> {
  List<ChooseHabitButtonWidget> _habitSuggestions = [];

  List<Habit> _choosenHabits = [];

  _updateChoosenHabits(Habit habit, bool selected) {
    if (_choosenHabits.contains(habit) && !selected) {
      _choosenHabits.remove(habit);
    } else {
      _choosenHabits.add(habit);
    }
  }

  @override
  void initState() {
    _habitSuggestions = DummyDataHelper.getHabits()
        .map((habit) => ChooseHabitButtonWidget(
            habit: habit, onSelectionChanged: _updateChoosenHabits))
        .toList();
    super.initState();
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
                        Navigator.pushNamed(context, CREATE_HABIT_ROUTE,
                            arguments: CreateHabitScreenArguments(
                                onDone: (Habit habit) async {
                          // Save habit to storage and navigate to dashboard
                          StorageService storageService =
                              locator<StorageService>();
                          await storageService.insertHabit(habit);
                          Navigator.pushReplacementNamed(
                              context, DASHBOARD_SCREEN_ROUTE);
                        }));
                      },
                    ),
                    FlatButton(
                        onPressed: () async {
                          // Add all habits the user has choosen to the storage and navigate to dashboard
                          StorageService storageService =
                              locator<StorageService>();
                          _choosenHabits.forEach((habit) async {
                            await storageService.insertHabit(habit);
                          });
                          Navigator.pushReplacementNamed(
                              context, DASHBOARD_SCREEN_ROUTE);
                        },
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
