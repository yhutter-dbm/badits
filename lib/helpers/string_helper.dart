import 'package:intl/intl.dart';

class StringHelper {
  static final _dateFormat = 'dd.MM.yyyy';

  static String getFormattedDate(DateTime date) {
    return DateFormat(_dateFormat).format(date);
  }
}
