import 'package:badits/models/habit.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/*
Implemented with reference to:
- https://flutter.dev/docs/cookbook/persistence/sqlite
*/

class StorageService {
  Future<Database> _open() async {
    return await openDatabase(join(await getDatabasesPath(), 'badits.db'),
        version: 1, onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE habits(id INTEGER PRIMARY KEY, name TEXT, description TEXT, dueDate TEXT)");
    });
  }

  Future<void> insertHabit(Habit habit) async {
    final database = await _open();
    database.insert('habits', habit.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Habit>> getHabits() async {
    final database = await _open();
    final List<Map<String, dynamic>> maps = await database.query('habits');
    return List.generate(maps.length, (index) {
      return Habit.fromMap(maps[index]);
    });
  }

  Future<List<Habit>> getActiveHabitsForDate(DateTime date) async {
    final allHabits = await getHabits();
    // We want all habits where the dueDate is bigger then the date
    final activeHabits = allHabits
        .where((habit) =>
            habit.dueDate.isAtSameMomentAs(date) || habit.dueDate.isAfter(date))
        .toList();
    return activeHabits;
  }
}
