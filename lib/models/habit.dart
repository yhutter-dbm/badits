import 'package:badits/helpers/date_time_helper.dart';
import 'package:badits/models/habitDuration.dart';
import 'package:date_util/date_util.dart';

enum HabitDifficulty { none, easy, medium, hard }

class Habit {
  int id;
  String name;
  DateTime creationDate;
  DateTime nextCompletionDate;
  DateTime dueDate;
  String assetIcon;
  HabitDuration duration;
  bool completedForToday;
  int currentCompletionCount;
  int countUntilCompletion;

  Habit(
      {this.id,
      this.name,
      this.creationDate,
      this.nextCompletionDate,
      this.dueDate,
      this.assetIcon,
      this.duration,
      this.completedForToday,
      this.currentCompletionCount,
      this.countUntilCompletion});

  // Deserialize a habit from database into an actual object
  static Habit fromMap(Map<String, dynamic> map) {
    return Habit(
        id: map['id'],
        name: map['name'],
        creationDate:
            DateTimeHelper.getBaditsDateTimeFromString(map['creationDate']),
        nextCompletionDate: DateTimeHelper.getBaditsDateTimeFromString(
            map['nextCompletionDate']),
        dueDate: DateTimeHelper.getBaditsDateTimeFromString(map['dueDate']),
        assetIcon: map['assetIcon'],
        duration: HabitDuration.values[map['duration']],
        completedForToday: map['completedForToday'] == 0 ? false : true,
        currentCompletionCount: map['completedForToday'],
        countUntilCompletion: map['countUntilCompletion']);
  }

  // Serialize a habit to put into the database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'creationDate': DateTimeHelper.getBaditsDateTimeString(creationDate),
      'nextCompletionDate':
          DateTimeHelper.getBaditsDateTimeString(nextCompletionDate),
      'dueDate': DateTimeHelper.getBaditsDateTimeString(dueDate),
      'assetIcon': assetIcon,
      'duration': duration.index,
      'completedForToday': completedForToday ? 1 : 0,
      'currentCompletionCount': currentCompletionCount,
      'countUntilCompletion': countUntilCompletion,
    };
  }

  bool isPassDueDate(DateTime dateTime) {
    return dateTime.isAfter(this.dueDate) ||
        dateTime.isAtSameMomentAs(this.dueDate);
  }
}
