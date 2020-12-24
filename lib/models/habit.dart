import 'package:badits/helpers/date_time_helper.dart';
import 'package:badits/models/constants.dart';
import 'package:badits/models/habitDuration.dart';
import 'package:intl/intl.dart';
import 'package:date_util/date_util.dart';

enum HabitDifficulty { none, easy, medium, hard }

class Habit {
  int id;
  String name;
  DateTime dueDate;
  String assetIcon;
  HabitDuration duration;

  final _dateUtility = DateUtil();

  Habit({this.id, this.name, this.dueDate, this.duration, this.assetIcon = ''});

  // Deserialize a habit from database into an actual object
  static Habit fromMap(Map<String, dynamic> map) {
    return Habit(
        id: map['id'],
        name: map['name'],
        dueDate: DateTimeHelper.getBaditsDateTimeFromString(map['dueDate']),
        assetIcon: map['assetIcon'],
        duration: HabitDuration.values[map['duration']]);
  }

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
      'assetIcon': assetIcon,
      'duration': duration.index
    };
  }

  bool isPassDueDate(DateTime dateTime) {
    return dateTime.isAfter(this.dueDate) ||
        dateTime.isAtSameMomentAs(this.dueDate);
  }

  int compareTo(Habit otherHabit) {
    final now = DateTimeHelper.getBaditsDateTime(DateTime.now());
    final dueDateSortResult = this.dueDate.compareTo(otherHabit.dueDate);
    if (this.isPassDueDate(now) && !otherHabit.isPassDueDate(now)) {
      return 1;
    } else if (!this.isPassDueDate(now) && otherHabit.isPassDueDate(now)) {
      return -1;
    } else if (this.isPassDueDate(now) && otherHabit.isPassDueDate(now)) {
      return 0;
    }
    return dueDateSortResult;
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
