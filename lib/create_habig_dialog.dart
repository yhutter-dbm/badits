import 'package:badits/routes.dart';
import 'package:flutter/material.dart';

// Implemented with reference to: https://flutter.dev/docs/cookbook/forms/validation
class CreateHabitDialogWidget extends StatefulWidget {
  @override
  _CreateHabitDialogWidgetState createState() =>
      _CreateHabitDialogWidgetState();
}

class _CreateHabitDialogWidgetState extends State<CreateHabitDialogWidget> {
  final _formKey = GlobalKey<FormState>();

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
                  )
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
              )
            ],
          )),
    );
  }
}
