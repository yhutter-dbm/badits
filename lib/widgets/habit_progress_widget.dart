import 'dart:math';
import 'package:badits/helpers/date_time_helper.dart';
import 'package:badits/helpers/habit_duration_helper.dart';
import 'package:badits/models/colors.dart';
import 'package:badits/models/habit.dart';
import 'package:badits/models/habitStatusEntry.dart';
import 'package:badits/services/service_locator.dart';
import 'package:badits/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HabitProgressWidget extends StatefulWidget {
  final Habit habit;
  final Function onHabitCompleteTaped;

  const HabitProgressWidget({Key key, this.habit, this.onHabitCompleteTaped})
      : super(key: key);

  @override
  _HabitProgressWidgetState createState() => _HabitProgressWidgetState();
}

class _HabitProgressWidgetState extends State<HabitProgressWidget> {
  final DateTime _now = DateTime.now();
  bool _habitInProgress = false;
  double _habitProgress = 0;
  String _nextDateString = '';

  Future<void> _update() async {
    // Update the completion count
    StorageService storageService = locator<StorageService>();
    final habitStatusEntries =
        await storageService.getHabitStatusEntriesForHabit(this.widget.habit);

    final habitStatusEntriesForToday =
        await storageService.getHabitStatusEntriesForDateTime(
            this.widget.habit, DateTimeHelper.getBaditsDateTimeString(_now));

    // Calculate the next completion date
    final nextCompletionDate = HabitDurationHelper.getNextCompletionDate(
        _now, this.widget.habit.duration);
    this.widget.habit.nextCompletionDate = nextCompletionDate;

    // Update the completion count
    this.widget.habit.currentCompletionCount = habitStatusEntries.length;

    // Determine if the habit is completed for today
    this.widget.habit.completedForToday = habitStatusEntriesForToday.length > 0;

    await storageService.updateHabit(this.widget.habit);

    setState(() {
      // TODO: Update progress correctly.
      _habitInProgress = new Random().nextBool();
      _habitProgress =
          _habitInProgress ? new Random().nextDouble() * 50 + 100 : 0.0;

      final nextDate = this.widget.habit.nextCompletionDate;
      if (!this.widget.habit.isPassDueDate(_now)) {
        _nextDateString =
            'Next: ${DateTimeHelper.getBaditsDateTimeString(nextDate)}';
      } else {
        _nextDateString = 'Pass Due';
      }
    });
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
                      if (this.widget.habit.completedForToday) {
                        return;
                      }
                      StorageService storageService = locator<StorageService>();
                      final HabitStatusEntry entry = HabitStatusEntry(
                          habitId: this.widget.habit.id, date: DateTime.now());
                      await storageService.insertHabitStatusEntry(entry);

                      // Awaiting here is important because if we do not the state is not reflected properly...
                      await _update();
                      this.widget.onHabitCompleteTaped();
                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: SvgPicture.asset('assets/icons/check.svg',
                            color: Colors.black))),
                Spacer(),
                Text(
                    '${this.widget.habit.currentCompletionCount}/${this.widget.habit.countUntilCompletion}',
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
    if (this.widget.habit.completedForToday) {
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
