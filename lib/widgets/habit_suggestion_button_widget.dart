import 'package:badits/models/habit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HabitSuggestionButtonWidget extends StatefulWidget {
  final Habit habit;
  @override
  _HabitSuggestionButtonWidgetState createState() =>
      _HabitSuggestionButtonWidgetState();

  const HabitSuggestionButtonWidget({this.habit});
}

class _HabitSuggestionButtonWidgetState
    extends State<HabitSuggestionButtonWidget> {
  bool _isSelected = false;

  get isSelected => _isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            _isSelected = !_isSelected;
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
            color: _isSelected
                ? Color.fromARGB(255, 255, 86, 120)
                : Color.fromARGB(255, 225, 225, 225),
          ),
        ));
  }
}
