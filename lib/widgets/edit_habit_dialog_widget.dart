import 'package:badits/models/habit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/*
Implemented with reference to: 
- https://flutter.dev/docs/cookbook/forms/validation
- https://medium.com/flutter-community/a-deep-dive-into-datepicker-in-flutter-37e84f7d8d6c
*/
class EditHabitDialogWidget extends StatefulWidget {
  final void Function(Habit habit) onEditHabitFinishedCallback;
  final Habit habit;
  @override
  _EditHabitDialogWidgetState createState() => _EditHabitDialogWidgetState();

  EditHabitDialogWidget(this.habit, this.onEditHabitFinishedCallback);
}

class _EditHabitDialogWidgetState extends State<EditHabitDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  final _habitTextNameController = TextEditingController();
  final _habitTextDescriptionController = TextEditingController();
  final _dateFormat = 'dd.MM.yyyy';

  String _getFormattedDate(DateTime date) {
    return DateFormat(_dateFormat).format(date);
  }

  @override
  void initState() {
    // Provide initial text value for controllers...
    _habitTextNameController.text = this.widget.habit.name;
    _habitTextDescriptionController.text = this.widget.habit.description;
    super.initState();
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
      title: Text('Edit ${this.widget.habit.name}'),
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
                        'Due Date ${_getFormattedDate(this.widget.habit.dueDate)}',
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
                      this.widget.habit.name = _habitTextNameController.text;
                      this.widget.habit.description =
                          _habitTextDescriptionController.text;
                      this
                          .widget
                          .onEditHabitFinishedCallback(this.widget.habit);
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Save'),
                ),
              ),
            ],
          )),
    );
  }
}
