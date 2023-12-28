import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension StringExtension on String {
  /// First capitalize
  String toCapitalize() => this[0].toUpperCase() + this.substring(1);

  /// First capitalize
  String toAllCapitalize() {
    String result = '';
    this.split(' ').forEach((element) {
      result = '$result${element.toCapitalize()} ';
    });
    return result.trim();
  }

  /// Timestamp for name of image
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  /// Convert string to date
  DateTime toDateTimeObj() {
    return DateTime.parse(this);
  }

  /// Convert string to date
  DateTime toDateTimeServerToLocal() {
    return DateTime.parse(this).toLocal();
  }

  /// Convert string to date
  double toDouble() {
    try {
      return double.parse(this);
    } on FormatException {
      return 0.0;
    }
  }

  /// Check is number
  bool isNumeric() {
    return double.tryParse(this) != null;
  }

  /// Parse to int
  int toInt() {
    int val = int.tryParse(this) ?? 0;
    return val;
  }

  /// Convert string to time of day
  TimeOfDay? toTimeOfDayObj() {
    List<String> split = this.split(':');
    if (split.length < 2) {
      return null;
    }
    int hour = int.parse(split[0]);
    int min = int.parse(split[1]);

    return TimeOfDay(hour: hour, minute: min);
  }

  /// Convert string to color. #123456
  Color toColorObj({Color defaultColor = const Color(0xffDB0000)}) {
    if (this == null || this == '') {
      return defaultColor;
    }
    if (this == 'transparent') {
      return Colors.transparent;
    }
    if (this.length != 7) {
      return defaultColor;
    }
    if (!this.startsWith('#')) {
      return defaultColor;
    }
    try {
      return Color(int.parse(this.replaceFirst('#', '0xFF')));
    } catch (e) {
      return defaultColor;
    }
  }

  /// Current format
  String toCurrency() {
    final currency = new NumberFormat("#,###", "en_US");
    double value = this.toDouble();
    return currency.format(value);
  }

  /// Create time
  // String toTimeline() {
  //   DateTime currentTime = DateTime.now();
  //   DateTime dateTime = this.toDateTimeObj();
  //   int curMill = currentTime.millisecondsSinceEpoch;
  //   int milli = dateTime.millisecondsSinceEpoch;
  //   int remain = curMill - milli;
  //
  //   ///If the current time> = 24h (midnight) => Datetime = Date Approved and displays in the format dd/mm/yyyy
  //   if (remain >= 24 * 60 * 60 * 1000) {
  //     return dateTime.toStringObj(StringUtils.DD_MM_YYYY)!;
  //   }
  //
  //   /// If 1 hour <= Datetime < 24 hours => show “[XX] hours ago“
  //   if (remain > 60 * 60 * 1000) {
  //     return '${remain ~/ (60 * 60 * 1000)} giờ trước';
  //   }
  //
  //   /// f DateTime = 1 hour => Show “ 1 hour ago”
  //   if (remain == 60 * 60 * 1000) {
  //     return '1 giờ trước';
  //   }
  //
  //   /// If 1 min < Datetime <1 hour => show “[XX] minutes ago“.
  //   if (remain > 60 * 1000) {
  //     return '${remain ~/ (60 * 1000)} phút trước';
  //   }
  //
  //   /// If DateTime = 1 min => Show “ 1 minute ago”
  //   if (remain == 60 * 1000) {
  //     return '1 phút trước';
  //   }
  //
  //   /// If DateTime < 1min => show “Just now“.
  //   return 'Now';
  // }

  /// Get extension value
  String toExtension() {
    List<String> array = this.split('.');
    if (array.isEmpty) {
      return '';
    }
    return array[array.length - 1];
  }

  /// Format num value
  String formatNumValue() {
    return NumberFormat("#,###", "en_US")
        .format(this.toInt())
        .replaceAll(',', '.');
  }

  /// Get file size
  static String getFileSize({int? bytes, int decimals = 0}) {
    if (bytes! <= 0) return "0 Bytes";
    const suffixes = [" Bytes", "KB", "MB", "GB", "TB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
  }
}
