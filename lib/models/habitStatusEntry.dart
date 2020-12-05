import 'package:badits/helpers/converter.dart';
import 'package:intl/intl.dart';

class HabitStatusEntry {
  static final _dateFormat = 'dd.MM.yyyy';

  int id;
  int habitId;
  DateTime dueDate;
  bool completed;

  HabitStatusEntry({this.id, this.habitId, this.dueDate, this.completed});

  // Deserialize a habit entry from database into an actual object
  static HabitStatusEntry fromMap(Map<String, dynamic> map) {
    return HabitStatusEntry(
        id: map['id'],
        habitId: map['habitId'],
        dueDate: DateFormat(_dateFormat).parse(map['dueDate']),
        completed: Converter.toBool(map['completed'] as int));
  }

  // Serialize a habit entry to put into the database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'habitId': habitId,
      'dueDate': DateFormat(_dateFormat).format(dueDate),
      'completed': Converter.toInt(completed)
    };
  }
}
