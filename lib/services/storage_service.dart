import 'package:badits/models/habit.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/*
Implemented with reference to:
- https://flutter.dev/docs/cookbook/persistence/sqlite
*/

class StorageService {
  Database _database;

  Future<void> open() async {
    _database = await openDatabase(join(await getDatabasesPath(), 'badits.db'),
        version: 1, onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE habits(id INTEGER PRIMARY KEY, name TEXT, description TEXT)");
    });
  }

  Future<void> insertHabit(Habit habit) async {
    // TODO: Add save checking if database is open etc.
    await _database.insert('habits', habit.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Habit>> getHabits() async {
    // TODO: Add save checking if database is open etc.
    final List<Map<String, dynamic>> maps = await _database.query('habits');
    return List.generate(maps.length, (index) {
      return Habit.fromMap(maps[index]);
    });
  }

  close() async {
    if (_database != null) {
      await _database.close();
    }
  }
}
