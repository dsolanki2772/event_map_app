import 'package:intl/intl.dart';

class DateUtil {
  static String formatDateTime(String rawDate) {
    try {
      final dateTime = DateTime.parse(rawDate).toLocal();
      final formatted = DateFormat('dd MMM yyyy hh:mm a').format(dateTime);
      return formatted;
    } catch (_) {
      return rawDate;
    }
  }
}
