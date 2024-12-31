import 'package:sprintf/sprintf.dart';

class VochatFormatUtil {
  VochatFormatUtil._internal();

  static String millisecondsToTime(int milliseconds) {
    if (milliseconds <= 0) {
      return "";
    }
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    DateTime now = DateTime.now();
    if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day) {
      return sprintf(
          "%02d:%02d:%02d", [dateTime.hour, dateTime.minute, dateTime.second]);
    }

    if (dateTime.year == now.year) {
      return sprintf("%02d-%02d %02d:%02d",
          [dateTime.month, dateTime.day, dateTime.hour, dateTime.minute]);
    }

    return sprintf("%d-%02d-%02d %02d:%02d", [
      dateTime.year,
      dateTime.month,
      dateTime.day,
      dateTime.hour,
      dateTime.minute
    ]);
  }

  static String millisecondsToDate(int milliseconds) {
    if (milliseconds <= 0) {
      return "";
    }
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    return sprintf(
        "%d-%02d-%02d", [dateTime.year, dateTime.month, dateTime.day]);
  }

  static String durationToTime(int seconds, {bool isShowHour = true}) {
    if (seconds < 0) return '';
    final second = seconds % 60;
    final minute = seconds ~/ 60 % 60;
    final hour = seconds ~/ 60 ~/ 60;
    StringBuffer buffer = StringBuffer();
    if (hour > 0 || isShowHour) {
      buffer.write(sprintf('%02d', [hour]));
      buffer.write(':');
    }
    buffer.write(sprintf('%02d', [minute]));
    buffer.write(':');
    buffer.write(sprintf('%02d', [second]));
    return buffer.toString();
  }
}
