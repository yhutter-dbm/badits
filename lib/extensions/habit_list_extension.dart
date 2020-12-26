import 'package:badits/models/habit.dart';

extension HabitList on List<Habit> {
  void sortHabits() {
    // Sort according to habit id, this ensures that the newest added habit will always be first
    this.sort(
        (Habit habitOne, Habit habitTwo) => habitTwo.id.compareTo(habitOne.id));
  }
}
