class Converter {
  static bool toBool(int value) {
    // Consider '1' as true and everything else as false
    return value == 1;
  }

  static toInt(bool value) {
    // Consider '1' as true and everything else as false.
    return value ? 1 : 0;
  }
}
