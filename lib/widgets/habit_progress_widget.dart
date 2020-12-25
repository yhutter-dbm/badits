import 'dart:math';
import 'package:badits/helpers/date_time_helper.dart';
import 'package:badits/models/colors.dart';
import 'package:badits/models/habit.dart';
import 'package:badits/models/habitStatusEntry.dart';
import 'package:badits/services/service_locator.dart';
import 'package:badits/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HabitProgressWidget extends StatefulWidget {
  final Habit habit;

  const HabitProgressWidget({Key key, this.habit}) : super(key: key);

  @override
  _HabitProgressWidgetState createState() => _HabitProgressWidgetState();
}

class _HabitProgressWidgetState extends State<HabitProgressWidget> {
  final DateTime _now = DateTime.now();

  bool _habitCompletedForToday = false;
  bool _habitInProgress = false;
  double _habitProgress = 0;
  String _nextDateString = '';
  int _currentCompletionCount = 0;
  int _completionCount = 0;

  void _update() async {
    // Update the completion count
    StorageService storageService = locator<StorageService>();
    final habitStatusEntries =
        await storageService.getHabitStatusEntriesForHabit(this.widget.habit);
    _currentCompletionCount = habitStatusEntries.length;
    _completionCount = this.widget.habit.getCountUntilCompletion();

    final habitStatusEntriesForToday =
        await storageService.getHabitStatusEntriesForDateTime(
            this.widget.habit, DateTimeHelper.getBaditsDateTimeString(_now));

    // TODO: Update progress correctly.
    _habitInProgress = new Random().nextBool();
    _habitProgress =
        _habitInProgress ? new Random().nextDouble() * 50 + 100 : 0.0;

    // Update the next date
    final nextDate = this.widget.habit.getNextDate(_now);
    if (nextDate != null) {
      _nextDateString =
          'Next: ${DateTimeHelper.getBaditsDateTimeString(nextDate)}';
    } else {
      _nextDateString = 'Pass Due';
    }

    // Update the completed flag. If completed the habit can no longer be completed for today
    _habitCompletedForToday = habitStatusEntriesForToday.length > 0;
    setState(() {});
  }

  List<Widget> _getStackElements() {
    List<Widget> stackElements = [
      Container(
        color: BADITS_PINK,
        width: _habitProgress,
      ),
      Container(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Deadline ${DateTimeHelper.getBaditsDateTimeString(this.widget.habit.dueDate)}',
                  style: TextStyle(
                      fontFamily: 'ObibokRegular',
                      fontSize: 10,
                      color: _habitInProgress ? Colors.white : Colors.black),
                ),
                Text('${this.widget.habit.name}',
                    style: TextStyle(
                        fontFamily: 'ObibokRegular',
                        fontSize: 20,
                        color: _habitInProgress ? Colors.white : Colors.black)),
                Spacer(),
                Container(
                  height: 45,
                  child: SvgPicture.asset(this.widget.habit.assetIcon,
                      color: _habitInProgress ? Colors.white : Colors.black),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(_nextDateString,
                    style: TextStyle(
                        fontFamily: 'ObibokRegular',
                        fontSize: 10,
                        color: BADITS_PINK)),
                GestureDetector(
                    onTap: () async {
                      // if the habit has already been completed for today do nothing
                      if (_habitCompletedForToday) {
                        return;
                      }
                      StorageService storageService = locator<StorageService>();
                      final HabitStatusEntry entry = HabitStatusEntry(
                          habitId: this.widget.habit.id, date: DateTime.now());
                      await storageService.insertHabitStatusEntry(entry);
                      _update();
                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: SvgPicture.asset('assets/icons/check.svg',
                            color: Colors.black))),
                Spacer(),
                Text('$_currentCompletionCount/$_completionCount',
                    style: TextStyle(
                        fontFamily: 'ObibokRegular',
                        fontSize: 15,
                        color: Colors.black))
              ],
            )
          ],
        ),
      )
    ];

    // In case the habit is already completed add a white overlay with an mid level opacity to create the disabled effect.
    if (_habitCompletedForToday) {
      stackElements.add(Container(
        decoration: BoxDecoration(color: BADITS_DISABLED),
      ));
    }

    return stackElements;
  }

  @override
  void initState() {
    _update();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        margin: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(color: BADITS_DARKER_GRAY),
        child: Stack(
          children: _getStackElements(),
        ));
  }
}
