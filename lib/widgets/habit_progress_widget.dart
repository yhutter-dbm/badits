import 'dart:math';

import 'package:badits/helpers/date_time_helper.dart';
import 'package:badits/models/colors.dart';
import 'package:badits/models/constants.dart';
import 'package:badits/models/habit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class HabitProgressWidget extends StatefulWidget {
  final Habit habit;

  const HabitProgressWidget({Key key, this.habit}) : super(key: key);

  @override
  _HabitProgressWidgetState createState() => _HabitProgressWidgetState();
}

class _HabitProgressWidgetState extends State<HabitProgressWidget> {
  final DateTime _now = DateTime.now();

  bool _habitInProgress = false;
  double _habitProgress = 50;
  String _nextDateString = '';

  @override
  void initState() {
    _habitInProgress = new Random().nextBool();
    _habitProgress =
        _habitInProgress ? new Random().nextDouble() * 50 + 100 : 0.0;

    final nextDate = this.widget.habit.getNextDate(_now);
    if (nextDate != null) {
      _nextDateString =
          'Next: ${DateTimeHelper.getBaditsDateTimeString(nextDate)}';
    } else {
      _nextDateString = 'Pass Due';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        margin: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(color: BADITS_DARKER_GRAY),
        child: Stack(
          children: [
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
                            color:
                                _habitInProgress ? Colors.white : Colors.black),
                      ),
                      Text('${this.widget.habit.name}',
                          style: TextStyle(
                              fontFamily: 'ObibokRegular',
                              fontSize: 20,
                              color: _habitInProgress
                                  ? Colors.white
                                  : Colors.black)),
                      Spacer(),
                      Container(
                        height: 45,
                        child: SvgPicture.asset(this.widget.habit.assetIcon,
                            color:
                                _habitInProgress ? Colors.white : Colors.black),
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
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: SvgPicture.asset('assets/icons/check.svg',
                              color: Colors.black)),
                      Spacer(),
                      Text('4/10',
                          style: TextStyle(
                              fontFamily: 'ObibokRegular',
                              fontSize: 15,
                              color: Colors.black))
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }
}
