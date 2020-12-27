import 'package:badits/helpers/habit_duration_helper.dart';
import 'package:badits/models/habitDuration.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Should calculate completion count correctly', () {
    final now = DateTime.now();
    final dueDate = now.add(Duration(days: 25));
    final duration = HabitDuration.daily;
    final result =
        HabitDurationHelper.getCountUntilCompletion(now, dueDate, duration);
    expect(result, 25);
  });

  test(
      'Should calculate month difference from 27.12.2020 to 01.01.2021 correctly',
      () {
    final now = DateTime(2020, 12, 27);
    final dueDate = DateTime(2021, 1, 1);
    final duration = HabitDuration.monthly;
    final result =
        HabitDurationHelper.getCountUntilCompletion(now, dueDate, duration);
    expect(result, 0);
  });

  test(
      'Should calculate month difference from 27.12.2020 to 27.01.2021 correctly',
      () {
    final now = DateTime(2020, 12, 27);
    final dueDate = DateTime(2021, 1, 27);
    final duration = HabitDuration.monthly;
    final result =
        HabitDurationHelper.getCountUntilCompletion(now, dueDate, duration);
    expect(result, 1);
  });
}
