import 'package:badits/helpers/date_time_helper.dart';
import 'package:badits/models/habitDuration.dart';
import 'package:date_util/date_util.dart';

enum HabitDifficulty { none, easy, medium, hard }

class Habit {
  int id;
  String name;
  DateTime dueDate;
  DateTime creationDate;
  String assetIcon;
  HabitDuration duration;
  bool completedForToday;

  final _dateUtility = DateUtil();

  Habit(
      {this.id,
      this.name,
      this.dueDate,
      this.creationDate,
      this.duration,
      this.assetIcon = '',
      this.completedForToday = false});

  // Deserialize a habit from database into an actual object
  static Habit fromMap(Map<String, dynamic> map) {
    return Habit(
        id: map['id'],
        name: map['name'],
        dueDate: DateTimeHelper.getBaditsDateTimeFromString(map['dueDate']),
        creationDate:
            DateTimeHelper.getBaditsDateTimeFromString(map['creationDate']),
        assetIcon: map['assetIcon'],
        duration: HabitDuration.values[map['duration']]);
  }

  // ignore: missing_return
  Duration _getDuration(DateTime dateTime) {
    switch (duration) {
      case HabitDuration.daily:
        {
          return new Duration(days: 1);
        }
      case HabitDuration.weekly:
        {
          return new Duration(days: 7);
        }
      case HabitDuration.monthly:
        {
          // Depending on the month we have a different amount of days
          final daysForCurrentMonth =
              _dateUtility.daysInMonth(dateTime.month, dateTime.year);
          return new Duration(days: daysForCurrentMonth);
        }
    }
  }

  // Serialize a habit to put into the database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'dueDate': DateTimeHelper.getBaditsDateTimeString(dueDate),
      'creationDate': DateTimeHelper.getBaditsDateTimeString(creationDate),
      'assetIcon': assetIcon,
      'duration': duration.index
    };
  }

  bool isPassDueDate(DateTime dateTime) {
    return dateTime.isAfter(this.dueDate) ||
        dateTime.isAtSameMomentAs(this.dueDate);
  }

  // ignore: missing_return
  int getCountUntilCompletion() {
    final difference = this.dueDate.difference(this.creationDate);
    switch (duration) {
      case HabitDuration.daily:
        {
          return difference.inDays;
        }
      case HabitDuration.weekly:
        {
          return difference.inDays ~/ 7;
        }
      case HabitDuration.monthly:
        {
          return this.dueDate.month - this.creationDate.month;
        }
    }
  }

  DateTime getNextDate(DateTime dateTime) {
    dateTime = DateTimeHelper.getBaditsDateTime(DateTime.now());
    // Get the next date starting from the given date in consideration with the duration and the actual due date
    final duration = _getDuration(dateTime);
    final nextDate = dateTime.add(duration);
    // In case we are pass the due date return null.
    if (this.isPassDueDate(dateTime)) {
      return null;
    }
    return nextDate;
  }
}
