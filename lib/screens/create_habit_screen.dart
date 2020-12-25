import 'package:badits/helpers/date_time_helper.dart';
import 'package:badits/helpers/habit_duration_helper.dart';
import 'package:badits/helpers/random_helper.dart';
import 'package:badits/models/colors.dart';
import 'package:badits/models/habit.dart';
import 'package:badits/models/habitDuration.dart';
import 'package:badits/screen_arguments/create_habit_screen_arguments.dart';
import 'package:badits/widgets/cancel_button_widget.dart';
import 'package:badits/widgets/confirm_button_widget.dart';
import 'package:badits/widgets/habit_duration_selection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;

/*
Implemented with reference to:
- https://github.com/MariaMelnik/flutter_date_pickers/blob/master/example/lib/date_pickers_widgets/day_picker_page.dart
*/
class CreateHabitScreen extends StatefulWidget {
  @override
  _CreateHabitScreenState createState() => _CreateHabitScreenState();
}

class _CreateHabitScreenState extends State<CreateHabitScreen> {
  final _formKey = GlobalKey<FormState>();
  final _habitTextNameController = TextEditingController();
  final DateTime _now = DateTime.now();
  final dp.DatePickerStyles _datePickerStyles = dp.DatePickerRangeStyles(
      disabledDateStyle:
          TextStyle(fontFamily: 'ObibokRegular', color: BADITS_DARKER_GRAY),
      displayedPeriodTitle: TextStyle(fontFamily: 'ObibokRegular'),
      defaultDateTextStyle: TextStyle(fontFamily: 'ObibokRegular'),
      currentDateStyle:
          TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      selectedSingleDateDecoration:
          BoxDecoration(color: BADITS_PINK, shape: BoxShape.circle));

  DateTime _firstDate;
  DateTime _lastDate;
  DateTime _dueDate;
  HabitDuration _habitDuration = HabitDuration.daily;

  void _onSelectedDueDateChanged(DateTime newDate) {
    setState(() {
      _dueDate = newDate;
    });
  }

  @override
  void initState() {
    _firstDate = _now.add(Duration(days: 1));
    _dueDate = _firstDate;
    _lastDate = _firstDate.add(Duration(days: 365));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CreateHabitScreenArguments arguments =
        ModalRoute.of(context).settings.arguments;
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
                  'New Habit',
                  style: TextStyle(
                      fontFamily: 'ObibokRegular',
                      fontSize: 20,
                      color: BADITS_PINK),
                  textAlign: TextAlign.left,
                ),
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _habitTextNameController,
                        decoration: InputDecoration(
                            labelText: 'Name',
                            labelStyle: TextStyle(
                                fontFamily: 'ObibokRegular',
                                fontSize: 10,
                                color: Colors.black)),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a name...';
                          }
                          return null;
                        },
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(width: 1, color: Colors.black))),
                        child: Row(
                          children: [
                            Text(
                              'Deadline',
                              style: TextStyle(
                                  fontFamily: 'ObibokRegular', fontSize: 10),
                            ),
                            Spacer(),
                            Text(
                              DateTimeHelper.getBaditsDateTimeString(_dueDate),
                              style: TextStyle(
                                  fontFamily: 'ObibokRegular',
                                  fontSize: 10,
                                  color: BADITS_DARKER_GRAY),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 30),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1)),
                        child: dp.DayPicker.single(
                            datePickerStyles: _datePickerStyles,
                            selectedDate: _dueDate,
                            onChanged: _onSelectedDueDateChanged,
                            firstDate: _firstDate,
                            lastDate: _lastDate),
                      )
                    ],
                  )),
              HabitDurationSelectionWidget(
                initialDuration: HabitDuration.daily,
                onDurationChanged: (HabitDuration duration) {
                  _habitDuration = duration;
                },
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CancelButtonWidget(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  ConfirmButtonWidget(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        final randomAssetIcon =
                            RandomHelper.getRandomElementFromList([
                          'assets/icons/fitness_icon.svg',
                          'assets/icons/energy.svg',
                          'assets/icons/healthy.svg',
                          'assets/icons/money.svg',
                          'assets/icons/draw.svg',
                          'assets/icons/planet.svg'
                        ]);

                        final now = DateTime.now();
                        final habit = Habit(
                            name: _habitTextNameController.value.text,
                            creationDate: now,
                            nextCompletionDate:
                                HabitDurationHelper.getNextCompletionDate(
                                    now, _habitDuration),
                            dueDate: _dueDate,
                            assetIcon: randomAssetIcon,
                            duration: _habitDuration,
                            completedForToday: false,
                            currentCompletionCount: 0,
                            countUntilCompletion:
                                HabitDurationHelper.getCountUntilCompletion(
                                    now, _dueDate, _habitDuration));

                        // Call done callback passed via arguments of route...
                        Navigator.pop(context);
                        arguments.onDone(habit);
                      }
                    },
                  )
                ],
              )
            ],
          )),
    );
  }

  @override
  void dispose() {
    _habitTextNameController.dispose();
    super.dispose();
  }
}
