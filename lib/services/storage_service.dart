import 'package:badits/models/habit.dart';
import 'package:badits/models/habitStatusEntry.dart';
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
      // Note in order to create multiple tables we have to call db.execute multiple times...
      // https://stackoverflow.com/questions/54316131/how-to-create-multiple-tables-in-a-database-in-sqflite
      db.execute("""
          CREATE TABLE habits
            (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT, 
              dueDate TEXT,
              creationDate TEXT,
              assetIcon TEXT,
              duration INTEGER
            );
          """);

      return db.execute("""
          CREATE TABLE habitStatusEntries
            (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              habitId INTEGER REFERENCES habits(id),
              date TEXT
            );
          """);
    });
  }

  Future<void> insertHabit(Habit habit) async {
    final database = await _open();
    database.insert('habits', habit.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertHabitStatusEntry(HabitStatusEntry habitStatusEntry) async {
    final database = await _open();
    database.insert('habitStatusEntries', habitStatusEntry.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Habit>> getHabits() async {
    final database = await _open();
    final List<Map<String, dynamic>> maps = await database.query('habits');
    return List.generate(maps.length, (index) {
      return Habit.fromMap(maps[index]);
    });
  }

  Future<List<HabitStatusEntry>> getHabitStatusEntriesForHabit(
      Habit habit) async {
    final database = await _open();
    final List<Map<String, dynamic>> maps = await database.query(
        'habitStatusEntries',
        where: 'habitId = ?',
        whereArgs: [habit.id]);
    return List.generate(maps.length, (index) {
      return HabitStatusEntry.fromMap(maps[index]);
    });
  }
}
