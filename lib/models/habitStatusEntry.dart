import 'package:badits/helpers/date_time_helper.dart';

class HabitStatusEntry {
  int id;
  int habitId;
  DateTime date;

  HabitStatusEntry({this.id, this.habitId, this.date});

  // Deserialize a habit entry from database into an actual object
  static HabitStatusEntry fromMap(Map<String, dynamic> map) {
    return HabitStatusEntry(
        id: map['id'],
        habitId: map['habitId'],
        date: DateTimeHelper.getBaditsDateTimeFromString((map['date'])));
  }

  // Serialize a habit entry to put into the database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'habitId': habitId,
      'date': DateTimeHelper.getBaditsDateTimeString(date),
    };
  }
}
