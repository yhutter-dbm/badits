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
              description TEXT,
              dueDate TEXT,
              difficulty INTEGER
            );
          """);

      return db.execute("""
          CREATE TABLE habitStatusEntries
            (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              habitId INTEGER REFERENCES habits(id),
              dueDate TEXT,
              completed INTEGER
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

  Future<List<HabitStatusEntry>> getHabitStatusEntries() async {
    final database = await _open();
    final List<Map<String, dynamic>> maps =
        await database.query('habitStatusEntries');
    return List.generate(maps.length, (index) {
      return HabitStatusEntry.fromMap(maps[index]);
    });
  }

  Future<void> updateHabit(Habit habit) async {
    final database = await _open();
    await database.update('habits', habit.toMap(),
        where: 'id = ?', whereArgs: [habit.id]);
  }

  Future<void> deleteHabit(Habit habit) async {
    final database = await _open();
    await database.delete('habits', where: 'id = ?', whereArgs: [habit.id]);
  }

  Future<List<Habit>> getActiveHabitsForDate(DateTime date) async {
    final allHabits = await getHabits();
    final allHabitStatusEntries = await getHabitStatusEntries();
    // We want all habits where the dueDate is bigger then the date
    final activeHabits = allHabits.where((habit) {
      final isHabitForToday = habit.dueDate.isAtSameMomentAs(date);

      // Check if a habit status entry does already exist, if so this habit has already been marked as 'completed' or 'not completed'
      final doesHabitStatusEntryAlreadyExist = allHabitStatusEntries
              .where((habitStatus) =>
                  habitStatus.habitId == habit.id &&
                  habitStatus.dueDate.isAtSameMomentAs(habit.dueDate))
              .length >
          0;
      return isHabitForToday && !doesHabitStatusEntryAlreadyExist;
    }).toList();
    return activeHabits;
  }
}
