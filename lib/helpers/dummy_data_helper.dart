import 'package:badits/models/habit.dart';
import 'package:badits/models/habitDuration.dart';

class DummyDataHelper {
  static List<Habit> getHabits() {
    final now = DateTime.now();
    return [
      Habit(
          id: 0,
          name: 'Do Sport',
          creationDate: now,
          nextCompletionDate: now.add(Duration(days: 1)),
          dueDate: DateTime.now().add(Duration(days: 5)),
          assetIcon: 'assets/icons/fitness_icon.svg',
          duration: HabitDuration.daily,
          completedForToday: false,
          currentCompletionCount: 0,
          countUntilCompletion: 5),
      Habit(
          id: 1,
          name: 'Save Energy',
          creationDate: now,
          nextCompletionDate: now.add(Duration(days: 1)),
          dueDate: now.add(Duration(days: 10)),
          assetIcon: 'assets/icons/energy.svg',
          duration: HabitDuration.daily,
          completedForToday: false,
          currentCompletionCount: 0,
          countUntilCompletion: 10),
      Habit(
          id: 2,
          name: 'Be healthy',
          creationDate: now,
          nextCompletionDate: now.add(Duration(days: 1)),
          dueDate: now.add(Duration(days: 15)),
          assetIcon: 'assets/icons/healthy.svg',
          duration: HabitDuration.daily,
          completedForToday: false,
          currentCompletionCount: 0,
          countUntilCompletion: 15),
      Habit(
          id: 3,
          name: 'Save Money',
          creationDate: now,
          nextCompletionDate: now.add(Duration(days: 1)),
          dueDate: now.add(Duration(days: 20)),
          assetIcon: 'assets/icons/money.svg',
          duration: HabitDuration.daily,
          completedForToday: false,
          currentCompletionCount: 0,
          countUntilCompletion: 20),
      Habit(
          id: 4,
          name: 'Draw',
          creationDate: now,
          nextCompletionDate: now.add(Duration(days: 1)),
          dueDate: now.add(Duration(days: 25)),
          assetIcon: 'assets/icons/draw.svg',
          duration: HabitDuration.daily,
          completedForToday: false,
          currentCompletionCount: 0,
          countUntilCompletion: 25),
      Habit(
          id: 4,
          name: 'Planet',
          creationDate: now,
          nextCompletionDate: now.add(Duration(days: 1)),
          dueDate: DateTime.now().add(Duration(days: 30)),
          assetIcon: 'assets/icons/planet.svg',
          duration: HabitDuration.daily,
          completedForToday: false,
          currentCompletionCount: 0,
          countUntilCompletion: 30),
    ];
  }
}
