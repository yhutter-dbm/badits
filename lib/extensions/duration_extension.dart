extension DurationExtension on Duration {
  int inWeeks() {
    return this.inDays ~/ 7;
  }
}
