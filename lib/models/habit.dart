import 'package:intl/intl.dart';

enum HabitDifficulty { none, easy, medium, hard }

class Habit {
  static final _dateFormat = 'dd.MM.yyyy';

  int id;
  String name;
  String description;
  DateTime dueDate;
  HabitDifficulty difficulty;
  String assetIcon;

  Habit(
      {this.id,
      this.name,
      this.description,
      this.dueDate,
      this.difficulty = HabitDifficulty.easy,
      this.assetIcon = ''});

  // Deserialize a habit from database into an actual object
  static Habit fromMap(Map<String, dynamic> map) {
    return Habit(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        dueDate: DateFormat(_dateFormat).parse(map['dueDate']),
        difficulty: HabitDifficulty.values[map['difficulty']]);
  }

  // Serialize a habit to put into the database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'dueDate': DateFormat(_dateFormat).format(dueDate),
      'difficulty': difficulty.index
    };
  }
}
