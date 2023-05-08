import 'package:intl/intl.dart';

class DateTimeHelper {
  static String toFriendlyString(DateTime? dateTime) {
    return DateFormat("MMMM dd, yyyy").format(dateTime ?? defaultDateTime);
  }

  static String toVietnameseStandardDate(DateTime? dateTime) {
    return DateFormat("dd/MM/yyyy").format(dateTime ?? defaultDateTime);
  }

  static String toFullClockTime(DateTime? dateTime) {
    return DateFormat("HH:mm:ss").format(dateTime ?? defaultDateTime);
  }

  static String toMessageTime(DateTime? dateTime) {
    return DateFormat("HH:mm").format(dateTime ?? defaultDateTime);
  }

  static DateTime get defaultDateTime => DateTime(2000);
}

extension DateOnLyCompare on DateTime {
  bool isSameDay(DateTime otherDate) {
    return year == otherDate.year &&
        month == otherDate.month &&
        day == otherDate.day;
  }
}
