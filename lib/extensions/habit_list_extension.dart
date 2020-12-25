import 'package:badits/models/habit.dart';

extension HabitList on List<Habit> {
  void sortHabits() {
    final now = DateTime.now();
    // Sort according to dueDate
    this.sort((Habit habitOne, Habit habitTwo) =>
        habitOne.dueDate.compareTo(habitTwo.dueDate));
    // Filter out all completed habits
    final completedForToday =
        this.where((Habit habit) => habit.completedForToday).toList();

    final passDue =
        this.where((Habit habit) => habit.isPassDueDate(now)).toList();

    final others = this
        .where((Habit habit) =>
            !completedForToday.contains(habit) && !passDue.contains(habit))
        .toList();

    this.clear();
    this.addAll(others);
    this.addAll(completedForToday);
    this.addAll(passDue);
  }
}
