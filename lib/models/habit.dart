import 'package:intl/intl.dart';

class Habit {
  static final _dateFormat = 'dd.MM.yyyy';

  int id;
  String name;
  String description;
  DateTime dueDate;

  Habit({this.id, this.name, this.description, this.dueDate});

  static Habit fromMap(Map<String, dynamic> map) {
    return Habit(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        dueDate: DateFormat(_dateFormat).parse(map['dueDate']));
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'dueDate': DateFormat(_dateFormat).format(dueDate)
    };
  }
}
