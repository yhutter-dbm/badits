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
}
