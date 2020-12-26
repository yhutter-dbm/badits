import 'package:badits/models/habit.dart';
import 'package:badits/models/habitDuration.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:badits/extensions/habit_list_extension.dart';

void main() {
  test('Should sort habits descending according to habit id', () {
    final now = DateTime.now();
    final Habit habitOne = Habit(
        id: 0,
        name: 'habitOne',
        creationDate: now,
        nextCompletionDate: now.add(Duration(days: 1)),
        dueDate: now.add(Duration(days: 5)),
        assetIcon: '',
        duration: HabitDuration.daily,
        completedForToday: false,
        currentCompletionCount: 0,
        countUntilCompletion: 5);

    final Habit habitTwo = Habit(
        id: 1,
        name: 'habitTwo',
        creationDate: now,
        nextCompletionDate: now.add(Duration(days: 1)),
        dueDate: now.add(Duration(days: 2)),
        assetIcon: '',
        duration: HabitDuration.daily,
        completedForToday: false,
        currentCompletionCount: 0,
        countUntilCompletion: 2);

    final Habit habitThree = Habit(
        id: 2,
        name: 'habitThree',
        assetIcon: '',
        creationDate: now,
        nextCompletionDate: now.add(Duration(days: 1)),
        dueDate: now.add(Duration(days: 3)),
        duration: HabitDuration.daily,
        completedForToday: false,
        currentCompletionCount: 0,
        countUntilCompletion: 3);

    final List<Habit> testData = [habitThree, habitOne, habitTwo];

    testData.sortHabits();

    final List<Habit> expectedSorting = [habitThree, habitTwo, habitOne];
    expect(testData, expectedSorting);
  });
}
