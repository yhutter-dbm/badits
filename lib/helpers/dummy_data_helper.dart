import 'package:badits/models/habit.dart';
import 'package:lipsum/lipsum.dart' as lipsum;

class DummyDataHelper {
  static List<Habit> getHabits() {
    return [
      Habit(
          id: 0,
          name: 'Habit One',
          description: lipsum.createWord(numWords: 10),
          dueDate: DateTime.now()),
      Habit(
          id: 1,
          name: 'Habit Two',
          description: lipsum.createWord(numWords: 10),
          dueDate: DateTime.now(),
          difficulty: HabitDifficulty.medium),
      Habit(
          id: 2,
          name: 'Habit Three',
          description: lipsum.createWord(numWords: 10),
          dueDate: DateTime.now(),
          difficulty: HabitDifficulty.hard),
    ];
  }
}
