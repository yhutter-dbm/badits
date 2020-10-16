import 'package:badits/models/habit.dart';
import 'package:flutter/material.dart';

/*
Implemented with reference to:
- https://api.flutter.dev/flutter/material/SimpleDialog-class.html
*/
class DeleteHabitDialogWidget extends StatelessWidget {
  final Habit habit;
  final void Function(Habit habit) onDeleteHabitConfirmedCallback;

  DeleteHabitDialogWidget(this.habit, this.onDeleteHabitConfirmedCallback);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text('Delete ${this.habit.name}?'),
        content: Stack(
          children: [
            SizedBox(
                height: 150,
                child: Text('Are you sure that you want to delete this?')),
            Positioned(
              bottom: 0,
              right: 0,
              child: FlatButton(
                onPressed: () {
                  this.onDeleteHabitConfirmedCallback(this.habit);
                  Navigator.of(context).pop();
                },
                child: Text('Delete'),
              ),
            ),
          ],
        ));
  }
}
