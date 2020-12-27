extension DateTimeExtension on DateTime {
  int differenceInMonths(DateTime until) {
    int monthDifference = until.month - this.month;
    // Guard against negative numbers. This can happen if the creationDate is bigger then the dueDate. For example if the habit was created in December and the dueDate is in January.
    if (monthDifference.isNegative) {
      // If the number is negative simply we need to add either 11 or 12 months to it.
      // In case the difference in days is less then 0 (eg. difference from 12.27.2020 - 01.01.2021) we need to add eleven months (as the difference in days does is not a full monnth, otherwise it would be bigger then 0)
      // https://leechy.dev/calculate-dates-diff-in-dart
      final dayDifference = until.day - this.day;
      monthDifference += dayDifference.isNegative ? 11 : 12;
    }
    return monthDifference;
  }
}
