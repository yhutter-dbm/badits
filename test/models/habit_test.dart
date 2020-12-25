import 'package:badits/models/habit.dart';
import 'package:badits/models/habitDuration.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:badits/extensions/habit_list_extension.dart';

void main() {
  test('Should sort habits descending according to due date', () {
    final now = DateTime.now();
    final Habit habitOne = Habit(
        id: 0,
        name: 'habitOne',
        assetIcon: '',
        creationDate: now,
        dueDate: now.add(Duration(days: 5)),
        duration: HabitDuration.daily);

    final Habit habitTwo = Habit(
        id: 1,
        name: 'habitTwo',
        assetIcon: '',
        creationDate: now,
        dueDate: now.add(Duration(days: 2)),
        duration: HabitDuration.daily);

    final Habit habitThree = Habit(
        id: 2,
        name: 'habitThree',
        assetIcon: '',
        creationDate: now,
        dueDate: now.add(Duration(days: 3)),
        duration: HabitDuration.daily);

    final List<Habit> testData = [habitOne, habitTwo, habitThree];

    testData.sortHabits();

    final List<Habit> expectedSorting = [habitTwo, habitThree, habitOne];
    expect(testData, expectedSorting);
  });

  test('Should sort pass due habits always last', () {
    // Pass due is when the dueDate is older then the current date
    final now = DateTime.now();
    final Habit habitPassDue = Habit(
        id: 0,
        name: 'habitPassDue',
        assetIcon: '',
        creationDate: now,
        dueDate: now.subtract(Duration(days: 3)),
        duration: HabitDuration.daily);

    final Habit habitOne = Habit(
        id: 1,
        name: 'habitOne',
        assetIcon: '',
        creationDate: now,
        dueDate: now.add(Duration(days: 2)),
        duration: HabitDuration.daily);

    final Habit habitTwo = Habit(
        id: 2,
        name: 'habitTwo',
        assetIcon: '',
        creationDate: now,
        dueDate: now.add(Duration(days: 3)),
        duration: HabitDuration.daily);

    final List<Habit> testData = [habitPassDue, habitOne, habitTwo];

    testData.sortHabits();

    // Now the habits should be sorting descending from the duedate (the earliest one is the first element etc.)
    final List<Habit> expectedSorting = [habitOne, habitTwo, habitPassDue];
    expect(testData, expectedSorting);
  });

  test(
      'Should sort habits which are completed for today after incomplete but before pass due ones',
      () {
    // Pass due is when the dueDate is older then the current date
    final now = DateTime.now();
    final Habit habitPassDue = Habit(
        id: 0,
        name: 'habitPassDue',
        assetIcon: '',
        creationDate: now,
        dueDate: now.subtract(Duration(days: 3)),
        duration: HabitDuration.daily);

    final Habit habitOne = Habit(
        id: 1,
        name: 'habitOne',
        assetIcon: '',
        creationDate: now,
        dueDate: now.add(Duration(days: 5)),
        duration: HabitDuration.daily);

    final Habit habitCompletedForToday = Habit(
        id: 2,
        name: 'habitCompletedForToday',
        assetIcon: '',
        creationDate: now,
        dueDate: now.add(Duration(days: 3)),
        completedForToday: true,
        duration: HabitDuration.daily);

    final List<Habit> testData = [
      habitPassDue,
      habitOne,
      habitCompletedForToday
    ];

    testData.sortHabits();

    final List<Habit> expectedSorting = [
      habitOne,
      habitCompletedForToday,
      habitPassDue
    ];
    expect(testData, expectedSorting);
  });
}
