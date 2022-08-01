import 'dart:core';

import 'package:intl/intl.dart';

class DataCustomFormat {
  static final DateFormat customDateFormat = DateFormat.Hm();
  static final DateFormat dailyDateFormat = DateFormat.MEd();
  static final DateTime dateTime = DateTime.now();

  static String getCustomDateFormat(itemTime) {
    return customDateFormat.format(DateTime.fromMillisecondsSinceEpoch(
        (itemTime - dateTime.timeZoneOffset.inSeconds)* 1000) );
  }

  static String getDailyDateFormat(itemTime) {
    return dailyDateFormat
        .format(DateTime.fromMillisecondsSinceEpoch((itemTime- dateTime.timeZoneOffset.inSeconds) * 1000));
  }
}
