import 'package:intl/intl.dart';

class DateTimeHelper {
  static String toFriendlyString(DateTime? dateTime) {
    return DateFormat("MMMM dd, yyyy").format(dateTime ?? defaultDateTime);
  }

  static String toVietnameseStandardDate(DateTime? dateTime) {
    return DateFormat("dd/MM/yyyy").format(dateTime ?? defaultDateTime);
  }

  static String toFullClockTime(DateTime? dateTime) {
    return DateFormat("hh:mm:ss").format(dateTime ?? defaultDateTime);
  }

  static DateTime get defaultDateTime => DateTime(2000);
}
