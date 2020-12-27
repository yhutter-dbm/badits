extension StringExtension on String {
  String truncateWithEllipsis(int maxLength) {
    if (this.length > maxLength) {
      return '${this.substring(0, maxLength)}...';
    }
    return this;
  }
}
