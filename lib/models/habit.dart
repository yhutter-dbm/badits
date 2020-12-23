import 'package:badits/models/habitDuration.dart';
import 'package:intl/intl.dart';

enum HabitDifficulty { none, easy, medium, hard }

class Habit {
  static final _dateFormat = 'dd.MM.yyyy';

  int id;
  String name;
  DateTime dueDate;
  String assetIcon;
  HabitDuration duration;

  Habit({this.id, this.name, this.dueDate, this.duration, this.assetIcon = ''});

  // Deserialize a habit from database into an actual object
  static Habit fromMap(Map<String, dynamic> map) {
    return Habit(
        id: map['id'],
        name: map['name'],
        dueDate: DateFormat(_dateFormat).parse(map['dueDate']),
        duration: HabitDuration.values[map['duration']]);
  }

  // Serialize a habit to put into the database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'dueDate': DateFormat(_dateFormat).format(dueDate),
      'duration': duration.index
    };
  }
}
