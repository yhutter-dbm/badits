import 'package:intl/intl.dart';

// TODO: Add tests for these methods...
class DateTimeHelper {
  static const BADITS_DATEFORMAT = 'dd.MM.yyyy';

  static DateTime getBaditsDateTime(DateTime dateTime) {
    final dateTimeString = DateFormat(BADITS_DATEFORMAT).format(dateTime);
    return DateFormat(BADITS_DATEFORMAT).parse(dateTimeString);
  }

  static DateTime getBaditsDateTimeFromString(String dateTimeString) {
    return DateFormat(BADITS_DATEFORMAT).parse(dateTimeString);
  }

  static String getBaditsDateTimeString(DateTime dateTime) {
    return DateFormat(BADITS_DATEFORMAT).format(dateTime);
  }
}
