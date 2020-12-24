import 'package:badits/models/habit.dart';
import 'package:badits/models/habitDuration.dart';

class DummyDataHelper {
  static List<Habit> getHabits() {
    return [
      Habit(
          id: 0,
          name: 'Do Sport',
          dueDate: DateTime.now().add(Duration(days: 5)),
          creationDate: DateTime.now(),
          assetIcon: 'assets/icons/fitness_icon.svg',
          duration: HabitDuration.daily),
      Habit(
          id: 1,
          name: 'Save Energy',
          dueDate: DateTime.now().add(Duration(days: 10)),
          creationDate: DateTime.now(),
          assetIcon: 'assets/icons/energy.svg',
          duration: HabitDuration.daily),
      Habit(
          id: 2,
          name: 'Be healthy',
          dueDate: DateTime.now().add(Duration(days: 15)),
          creationDate: DateTime.now(),
          assetIcon: 'assets/icons/healthy.svg',
          duration: HabitDuration.daily),
      Habit(
          id: 3,
          name: 'Save Money',
          dueDate: DateTime.now().add(Duration(days: 20)),
          creationDate: DateTime.now(),
          assetIcon: 'assets/icons/money.svg',
          duration: HabitDuration.daily),
      Habit(
          id: 4,
          name: 'Draw',
          dueDate: DateTime.now().add(Duration(days: 25)),
          creationDate: DateTime.now(),
          assetIcon: 'assets/icons/draw.svg',
          duration: HabitDuration.daily),
      Habit(
          id: 4,
          name: 'Planet',
          dueDate: DateTime.now().add(Duration(days: 30)),
          creationDate: DateTime.now(),
          assetIcon: 'assets/icons/planet.svg',
          duration: HabitDuration.daily),
    ];
  }
}
