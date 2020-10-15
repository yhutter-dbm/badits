import 'package:badits/models/habit.dart';
import 'package:badits/routes.dart';
import 'package:flutter/material.dart';
import 'helpers/string_helper.dart';

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
  final _habitTextNameController = TextEditingController();
  final _habitTextDescriptionController = TextEditingController();

  Habit _habit = Habit(name: '', description: '', dueDate: DateTime.now());

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
                        'Due Date ${StringHelper.getFormattedDate(_habit.dueDate)}',
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

                      _habit.name = _habitTextNameController.text;
                      _habit.description = _habitTextNameController.text;

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
                      _habit.dueDate = result;
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