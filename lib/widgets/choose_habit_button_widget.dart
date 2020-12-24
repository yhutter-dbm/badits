import 'package:badits/models/colors.dart';
import 'package:badits/models/habit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChooseHabitButtonWidget extends StatefulWidget {
  final Habit habit;
  final Function onSelectionChanged;
  @override
  _ChooseHabitButtonWidgetState createState() =>
      _ChooseHabitButtonWidgetState();

  ChooseHabitButtonWidget({this.habit, this.onSelectionChanged});
}

class _ChooseHabitButtonWidgetState extends State<ChooseHabitButtonWidget> {
  bool _isSelected = false;

  get isSelected => _isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            _isSelected = !_isSelected;
            this.widget.onSelectionChanged(this.widget.habit, _isSelected);
          });
        },
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SvgPicture.asset(
              widget.habit.assetIcon,
              color: _isSelected ? Colors.white : Colors.black,
            ),
          ),
          decoration: new BoxDecoration(
            color: _isSelected ? BADITS_PINK : BADITS_GRAY,
          ),
        ));
  }
}
