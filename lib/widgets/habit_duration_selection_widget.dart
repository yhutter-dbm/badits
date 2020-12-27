import 'package:badits/models/colors.dart';
import 'package:flutter/material.dart';
import 'package:badits/models/habitDuration.dart';

class HabitDurationSelectionWidget extends StatefulWidget {
  final HabitDuration initialDuration;
  final Function onDurationChanged;

  const HabitDurationSelectionWidget(
      {Key key, this.initialDuration, this.onDurationChanged})
      : super(key: key);

  @override
  _HabitDurationSelectionWidgetState createState() =>
      _HabitDurationSelectionWidgetState();
}

class _HabitDurationSelectionWidgetState
    extends State<HabitDurationSelectionWidget> {
  HabitDuration _duration;
  bool _isDailySelected = false;
  bool _isWeeklySelected = false;
  bool _isMonthlySelected = false;

  HabitDuration get selectedDuration => _duration;

  @override
  void initState() {
    this._duration = this.widget.initialDuration;
    switch (this._duration) {
      case HabitDuration.daily:
        {
          this._isDailySelected = true;
          this._isWeeklySelected = false;
          this._isMonthlySelected = false;
        }
        break;
      case HabitDuration.weekly:
        {
          this._isDailySelected = false;
          this._isWeeklySelected = true;
          this._isMonthlySelected = false;
        }
        break;
      case HabitDuration.monthly:
        {
          this._isDailySelected = false;
          this._isWeeklySelected = false;
          this._isMonthlySelected = true;
        }
        break;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.black))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Duration',
              style: TextStyle(fontFamily: 'ObibokRegular', fontSize: 10)),
          Spacer(),
          GestureDetector(
              onTap: () {
                setState(() {
                  _isDailySelected = true;
                  _isWeeklySelected = false;
                  _isMonthlySelected = false;
                  _duration = HabitDuration.daily;
                  this.widget.onDurationChanged(_duration);
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Text('Daily',
                    style: TextStyle(
                        fontFamily: 'ObibokRegular',
                        fontSize: 10,
                        color: _isDailySelected
                            ? BADITS_PINK
                            : BADITS_DARKER_GRAY)),
              )),
          GestureDetector(
              onTap: () {
                setState(() {
                  _isWeeklySelected = true;
                  _isDailySelected = false;
                  _isMonthlySelected = false;
                  _duration = HabitDuration.weekly;
                  this.widget.onDurationChanged(_duration);
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Text('Weekly',
                    style: TextStyle(
                        fontFamily: 'ObibokRegular',
                        fontSize: 10,
                        color: _isWeeklySelected
                            ? BADITS_PINK
                            : BADITS_DARKER_GRAY)),
              )),
          GestureDetector(
              onTap: () {
                setState(() {
                  _isMonthlySelected = true;
                  _isDailySelected = false;
                  _isWeeklySelected = false;
                  _duration = HabitDuration.monthly;
                  this.widget.onDurationChanged(_duration);
                });
              },
              child: Container(
                margin: EdgeInsets.only(left: 5),
                child: Text('Monthly',
                    style: TextStyle(
                        fontFamily: 'ObibokRegular',
                        fontSize: 10,
                        color: _isMonthlySelected
                            ? BADITS_PINK
                            : BADITS_DARKER_GRAY)),
              ))
        ],
      ),
    );
  }
}
