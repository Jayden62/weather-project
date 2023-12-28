import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  /// Convert date to string
  String? toStringObj(String pattern, {String? local}) {
    if (local == null || local == '') {
      return DateFormat(pattern).format(this);
    }
    return DateFormat(pattern, local).format(this);
  }

  /// Time send server
  /// Change Utc 0
  String? toDateTimeLocalToSever() {
    DateTime dateTime = this.toUtc();
    return dateTime.toStringObj("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
  }
}
