import 'package:badits/models/habit.dart';
import 'package:badits/models/routes.dart';
import 'package:badits/screen_arguments/create_habit_screen_arguments.dart';
import 'package:badits/services/service_locator.dart';
import 'package:badits/services/storage_service.dart';
import 'package:badits/widgets/add_habit_button_widget.dart';
import 'package:badits/widgets/habit_progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:badits/extensions/habit_list_extension.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Habit> _habits = [];

  Future<void> _loadHabits() async {
    StorageService storageService = locator<StorageService>();
    _habits = await storageService.getHabits();
    setState(() {
      _habits.sortHabits();
    });
  }

  @override
  void initState() {
    _loadHabits();
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
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  "You can\r\ndo it\r\ntoday!",
                  style: TextStyle(
                      fontFamily: 'ObibokRegular',
                      fontSize: 20,
                      color: Colors.black),
                  textAlign: TextAlign.left,
                ),
              ),
              Image.asset('assets/images/laying.png'),
              Container(
                height: 250,
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: _habits.length,
                    itemBuilder: (BuildContext context, int index) {
                      final habit = _habits[index];
                      return HabitProgressWidget(
                          // Create a unique key per element
                          key: Key(habit.id.toString()),
                          habit: habit,
                          onHabitCompleteTaped: () async {
                            await _loadHabits();
                          });
                    }),
              ),
              Spacer(),
              Row(
                children: [
                  AddHabitButtonWidget(
                    onPressed: () {
                      Navigator.pushNamed(context, CREATE_HABIT_ROUTE,
                          arguments: CreateHabitScreenArguments(
                              onDone: (Habit habit) async {
                        StorageService storageService =
                            locator<StorageService>();
                        await storageService.insertHabit(habit);
                        await _loadHabits();
                      }));
                    },
                  )
                ],
              )
            ],
          )),
    );
  }
}
