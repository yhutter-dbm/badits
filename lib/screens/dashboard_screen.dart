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

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  final _animatedListKey = GlobalKey<AnimatedListState>();

  List<Habit> _habits = [];
  Tween<Offset> _slideInAnimation;

  Future<void> _loadHabits() async {
    StorageService storageService = locator<StorageService>();
    _habits = await storageService.getHabits();
    setState(() {
      _habits.sortHabits();
    });
  }

  Future<void> _loadHabitsAndSlideIn() async {
    StorageService storageService = locator<StorageService>();
    _habits = await storageService.getHabits();
    setState(() {
      _habits.sortHabits();
      _slideInAllHabits();
    });
  }

  void _slideInAllHabits() {
    for (int i = 0; i < _habits.length; i++) {
      _animatedListKey.currentState.insertItem(i);
    }
  }

  void _slideInFirstHabit() {
    _animatedListKey.currentState.insertItem(0);
  }

  @override
  void initState() {
    // Implemented with reference to: https://api.flutter.dev/flutter/widgets/SlideTransition-class.html
    _slideInAnimation = Tween<Offset>(
      begin: const Offset(1.5, 0.0),
      end: Offset.zero,
    );
    _loadHabitsAndSlideIn();
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
                // Implemented with reference to: https://www.youtube.com/watch?v=ZtfItHwFlZ8&ab_channel=Flutter
                child: AnimatedList(
                  key: _animatedListKey,
                  initialItemCount: _habits.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index, animation) {
                    final habit = _habits[index];
                    return SlideTransition(
                      position: _slideInAnimation.animate(animation),
                      child: HabitProgressWidget(
                          // Create a unique key per element
                          key: Key(habit.id.toString()),
                          habit: habit,
                          onHabitCompleteTaped: () async {
                            await _loadHabits();
                          }),
                    );
                  },
                ),
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
                        // Because we sort the habits depending on the id the first habit will always be the created one
                        _slideInFirstHabit();
                      }));
                    },
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed(ABOUT_ROUTE);
                    },
                    child: Text(
                      'About',
                      style: TextStyle(
                          fontFamily: 'ObibokBold',
                          color: Colors.black,
                          fontSize: 15),
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}
