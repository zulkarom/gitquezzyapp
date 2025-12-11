import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class IntlService {
  static final IntlService _service = IntlService._internal();
  DateTimeFormat? _format;
  final detroit = tz.getLocation('Asia/Singapore'); //format UTC +8

  factory IntlService() {
    return _service;
  }

  IntlService._internal();

  void setFormat(DateTimeFormat format) {
    _format = format;
  }

  String convertDate(DateTime dateTime) {
    switch (_format) {
      case DateTimeFormat.twelveHourLongDate:
      case DateTimeFormat.twentyFourHourLongDate:
        return DateFormat('dd/MM/yyyy').format(dateTime);
      case DateTimeFormat.twelveHourShortDate:
      case DateTimeFormat.twentyFourHourShortDate:
        return DateFormat('d/M/yy').format(dateTime);
      default:
        return DateFormat().format(dateTime);
    }
  }

  String convertTime(DateTime dateTime) {
    switch (_format) {
      case DateTimeFormat.twelveHourLongDate:
      case DateTimeFormat.twelveHourShortDate:
        return DateFormat('h:mm:ss aa').format(dateTime);
      case DateTimeFormat.twentyFourHourShortDate:
      case DateTimeFormat.twentyFourHourLongDate:
        return DateFormat('HH:mm:ss').format(dateTime);
      default:
        return DateFormat().format(dateTime);
    }
  }

  String convertDateTime(DateTime dateTime) {
    switch (_format) {
      case DateTimeFormat.twelveHourLongDate:
        return DateFormat('dd/MM/yyyy h:mm:ss aa').format(dateTime);
      case DateTimeFormat.twelveHourShortDate:
        return DateFormat('d/M/yy h:mm:ss aa').format(dateTime);
      case DateTimeFormat.twentyFourHourShortDate:
        return DateFormat('d/M/yy HH:mm:ss').format(dateTime);
      case DateTimeFormat.twentyFourHourLongDate:
        return DateFormat('dd/MM/yyyy HH:mm:ss').format(dateTime);
      default:
        return DateFormat().format(dateTime);
    }
  }

  String convertDateTimeWithDay(DateTime dateTime) {
    return DateFormat('E, d MMM y hh:mm:ss a').format(dateTime);
  }

  String convertTimeWithHourAndMinutes(DateTime dateTime) {
    final localizedDt = tz.TZDateTime.from(dateTime, detroit);
    final timeFormat = DateFormat('HH:mm');
    return timeFormat.format(localizedDt);
  }

  String convertTimeForChat(DateTime dateTime) {
    final localizedDt = tz.TZDateTime.from(dateTime, detroit);
    final timeFormat = DateFormat('HH:mm, d MMM y');
    return timeFormat.format(localizedDt);
  }
}

enum DateTimeFormat {
  twelveHourShortDate(
      'Short date with time format of 12 hours', '1/1/00 12:00:00 AM'),
  twelveHourLongDate(
      'long date with time format of 12 hours', '01/01/2000 12:00:00 AM'),
  twentyFourHourShortDate(
      'Short date with time format of 24 hours', '1/1/00 00:00:00'),
  twentyFourHourLongDate(
      'long date with time format of 24 hours', '01/01/2000 00:00:00');

  final String displayName;
  final String example;
  const DateTimeFormat(this.displayName, this.example);
}
