import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';

const String dateTimeFormatPattern = 'dd/MM/yyyy';
const String D_M_Y = 'yyyy-MM-dd HH:mm';

extension DateTimeUtils on DateTime {
  String format({
    String pattern = dateTimeFormatPattern,
    String? locale,
  }) {
    if (locale != null && locale.isNotEmpty) {
      initializeDateFormatting(locale, null.toString());
    }
    return DateFormat(pattern, locale).format(this);
  }

  String hasBeen({required String date}) {
    final dateTime = DateTime.parse(date);
    final now = DateTime.now().toUtc();
    final duration = now.difference(dateTime);

    if (duration.inDays > 0) {
      return '${duration.inDays} ngày';
    } else if (duration.inHours > 0) {
      return '${duration.inHours.remainder(24)} giờ trước';
    } else if (duration.inMinutes.remainder(60) > 0) {
      return '${duration.inMinutes.remainder(60)} phút trước';
    }
    return '${duration.inSeconds.remainder(60)} giây trước';
  }
}
