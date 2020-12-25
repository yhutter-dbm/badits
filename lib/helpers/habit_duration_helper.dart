import 'package:badits/models/habitDuration.dart';
import 'package:date_util/date_util.dart';

import 'date_time_helper.dart';

class HabitDurationHelper {
  static final _dateUtility = DateUtil();

  // ignore: missing_return
  static int getCountUntilCompletion(
      DateTime creationDate, DateTime dueDate, HabitDuration duration) {
    final difference = dueDate.difference(creationDate);
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
          return dueDate.month - creationDate.month;
        }
    }
  }

  // ignore: missing_return
  static Duration _convertHabitDurationToActualDuration(
      DateTime dateTime, HabitDuration duration) {
    // Convert the habit duration into an actual duration depending on the datetime.
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

  static DateTime getNextCompletionDate(
      DateTime dateTime, HabitDuration duration) {
    dateTime = DateTimeHelper.getBaditsDateTime(DateTime.now());
    final actualDuration =
        _convertHabitDurationToActualDuration(dateTime, duration);
    final nextDate = dateTime.add(actualDuration);
    return nextDate;
  }
}
