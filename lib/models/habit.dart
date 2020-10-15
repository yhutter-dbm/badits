class Habit {
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
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}
