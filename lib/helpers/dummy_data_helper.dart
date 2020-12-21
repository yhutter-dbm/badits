import 'package:badits/models/habit.dart';
import 'package:lipsum/lipsum.dart' as lipsum;

class DummyDataHelper {
  static List<Habit> getHabits() {
    return [
      Habit(
          id: 0,
          name: 'Do Sport',
          description: '',
          dueDate: DateTime.now(),
          assetIcon: 'assets/icons/fitness_icon.svg'),
      Habit(
          id: 1,
          name: 'Save Energy',
          description: '',
          dueDate: DateTime.now(),
          difficulty: HabitDifficulty.medium,
          assetIcon: 'assets/icons/energy.svg'),
      Habit(
          id: 2,
          name: 'Be healthy',
          description: '',
          dueDate: DateTime.now(),
          difficulty: HabitDifficulty.hard,
          assetIcon: 'assets/icons/healthy.svg'),
      Habit(
          id: 3,
          name: 'Save Money',
          description: '',
          dueDate: DateTime.now(),
          difficulty: HabitDifficulty.hard,
          assetIcon: 'assets/icons/money.svg'),
      Habit(
          id: 4,
          name: 'Draw',
          description: '',
          dueDate: DateTime.now(),
          difficulty: HabitDifficulty.hard,
          assetIcon: 'assets/icons/draw.svg'),
      Habit(
          id: 4,
          name: 'Planet',
          description: 'Love your Planet',
          dueDate: DateTime.now(),
          difficulty: HabitDifficulty.hard,
          assetIcon: 'assets/icons/planet.svg'),
    ];
  }
}
