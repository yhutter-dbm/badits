import 'package:badits/models/habit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/*
Implemented with reference to: 
- https://flutter.dev/docs/cookbook/forms/validation
- https://medium.com/flutter-community/a-deep-dive-into-datepicker-in-flutter-37e84f7d8d6c
*/
class CreateHabitDialogWidget extends StatefulWidget {
  final void Function(Habit habit) _onCreateHabitFinishedCallback;

  @override
  _CreateHabitDialogWidgetState createState() =>
      _CreateHabitDialogWidgetState();

  CreateHabitDialogWidget(this._onCreateHabitFinishedCallback);
}

class _CreateHabitDialogWidgetState extends State<CreateHabitDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  final _habitTextNameController = TextEditingController();
  final _habitTextDescriptionController = TextEditingController();
  final _dateFormat = 'dd.MM.yyyy';

  Habit _habit = Habit(name: '', description: '', dueDate: DateTime.now());

  String _getFormattedDate(DateTime date) {
    return DateFormat(_dateFormat).format(date);
  }

  Future<DateTime> _showDatePicker(BuildContext context) {
    return showDatePicker(
        context: context,
        initialDate: _habit.dueDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2025));
  }

  @override
  void dispose() {
    _habitTextNameController.dispose();
    _habitTextDescriptionController.dispose();
    super.dispose();
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
                    controller: _habitTextNameController,
                    decoration: InputDecoration(labelText: 'Habit Name'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a name...';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _habitTextDescriptionController,
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
                        'Due Date ${_getFormattedDate(_habit.dueDate)}',
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
                      _habit.name = _habitTextNameController.text;
                      _habit.description = _habitTextNameController.text;
                      this.widget._onCreateHabitFinishedCallback(_habit);
                      Navigator.of(context).pop();
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

                    // The result can be null if the user has cancelled the date picker.
                    if (result != null) {
                      setState(() {
                        _habit.dueDate = result;
                      });
                    }
                  },
                  child: Text('Pick a Date'),
                ),
              )
            ],
          )),
    );
  }
}
