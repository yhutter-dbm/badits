import 'package:badits/routes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/*
Implemented with reference to: 
- https://flutter.dev/docs/cookbook/forms/validation
- https://medium.com/flutter-community/a-deep-dive-into-datepicker-in-flutter-37e84f7d8d6c
*/
class CreateHabitDialogWidget extends StatefulWidget {
  @override
  _CreateHabitDialogWidgetState createState() =>
      _CreateHabitDialogWidgetState();
}

class _CreateHabitDialogWidgetState extends State<CreateHabitDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  final _dateFormat = 'dd.MM.yyyy';

  DateTime _selectedDueDateTime = DateTime.now();

  String _getFormattedDate(DateTime date) {
    return DateFormat(_dateFormat).format(date);
  }

  Future<DateTime> _showDatePicker(BuildContext context) {
    return showDatePicker(
        context: context,
        initialDate: _selectedDueDateTime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2025));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create a new Habit'),
      content: Form(
          key: _formKey,
          child: Stack(
            children: [
              Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Habit Name'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a name...';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Habit Description'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a description...';
                      }
                      return null;
                    },
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        'Due Date ${_getFormattedDate(_selectedDueDateTime)}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                ],
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: FlatButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      // Add into some kind of storage, investigate orm mapper...
                      // TODO: Check why we still have a back button on the dashboard even though we did a pushReplacementNamed...
                      Navigator.of(context)
                          .pushReplacementNamed(DASHBOARD_SCREEN_ROUTE);
                    }
                  },
                  child: Text('Save'),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: FlatButton(
                  onPressed: () async {
                    final result = await _showDatePicker(context);
                    setState(() {
                      _selectedDueDateTime = result;
                    });
                  },
                  child: Text('Pick a Date'),
                ),
              )
            ],
          )),
    );
  }
}
