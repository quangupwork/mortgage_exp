import 'dart:convert';
import 'dart:io';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConvertUtility {
  static final DateFormat _displayDateFormat = DateFormat('dd/MM/yyyy');
  static final DateFormat _displayMMYYYYFormat = DateFormat('MM/yyyy');
  static final DateFormat _displayMonthYearFormat = DateFormat('MM-yyyy');
  static final DateFormat _displayddMMMMYYYY =
      DateFormat('dd MMMM yyyy', 'vi_VN');
  static final DateFormat _dayDateFormat =
      DateFormat('EEEE, dd MMM yyyy', 'vi_VN');
  static final DateFormat _esisDateFormat = DateFormat('yyyy-MM-dd');
  static final DateFormat _valueDateFormat = DateFormat('yyyyMMdd');
  static final DateFormat _dateFormatUTC = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
  static final DateFormat _preferenceDateFormat =
      DateFormat('dd/MM/yyyy HH:mm:ss');
  static final NumberFormat _currencyFormat =
      NumberFormat.currency(locale: 'vi_VN', symbol: ''); // ('#,###');
  static final RegExp _base64 = RegExp(
      r'^(?:[A-Za-z0-9+\/]{4})*(?:[A-Za-z0-9+\/]{2}==|[A-Za-z0-9+\/]{3}=|[A-Za-z0-9+\/]{4})$');
  static int tickNumber = 10000;
  static int unixEpochTicks = 621355968000000000;
  static int milisecondsFrom2020 = 1577836800000;

  static String formatDisplayDate(DateTime? date) {
    if (date == null) return '';
    return _displayDateFormat.format(date);
  }

  static String formatDisplayMMYYYY(DateTime? date) {
    if (date == null) return '';
    return _displayMMYYYYFormat.format(date);
  }

  static String formatDisplayMonthYear(DateTime? date) {
    if (date == null) return '';
    return _displayMonthYearFormat.format(date);
  }

  static String formatDisplayddMMMMYYYY(DateTime? date) {
    if (date == null) return '';
    return _displayddMMMMYYYY.format(date);
  }

  static String formatDayDate(DateTime? date) {
    if (date == null) return '';
    return _dayDateFormat.format(date);
  }

  static String formatEsisDate(DateTime? date) {
    if (date == null) return '';
    return _esisDateFormat.format(date);
  }

  static String formatPreferenceDate(DateTime? date) {
    if (date == null) return '';
    return _preferenceDateFormat.format(date);
  }

  static String formatValueDate(DateTime? date) {
    if (date == null) return '';
    return _valueDateFormat.format(date);
  }

  static DateTime? convertPreferenceDate(String text) {
    if (StringUtils.isNullOrEmpty(text)) return null;
    try {
      return _preferenceDateFormat.parse(text);
      // ignore: empty_catches
    } catch (ex) {}
    return null;
  }

  static DateTime? convertDisplayDate(String text) {
    if (StringUtils.isNullOrEmpty(text)) return null;
    try {
      return _displayDateFormat.parse(text);
      // ignore: empty_catches
    } catch (ex) {}
    return null;
  }

  static String? dateTimeToString(DateTime? date) {
    if (date == null) {
      return null;
    } else {
      return _displayDateFormat.format(date);
    }
  }

  static List<String>? dateTimeToListString(DateTime? date) {
    if (date == null) {
      return null;
    } else {
      return _displayDateFormat.format(date).split('/');
    }
  }

  static String formatCurrency(double amount) {
    return _currencyFormat.format(amount).trim();
  }

  static String formatInt(int number) {
    return _currencyFormat.format(number).trim();
  }

  static double getNumber(String? currencyValue) {
    if (currencyValue == null || currencyValue == '') return 0;
    return _currencyFormat.parse(currencyValue).toDouble();
  }

  static int convertPercent(double value) {
    return ((value) * 100).toInt();
  }

  static bool? convertIntToBool(int? val) {
    if (val == 1) {
      return true;
    } else if (val == 0) {
      return false;
    } else {
      return null;
    }
  }

  static int? convertBoolToInt(bool val) {
    if (val == true) {
      return 1;
    } else if (val == false) {
      return 0;
    } else {
      return null;
    }
  }

  static String? convertImageToBase64(String imagePath) {
    try {
      var file = File(imagePath);
      if (file.existsSync()) {
        return base64Encode(file.readAsBytesSync());
      }
      // ignore: empty_catches
    } catch (ex) {}
    return null;
  }

  static Image? convertBase64ToImage(String? base64) {
    if (base64 != null && base64.isNotEmpty) {
      try {
        return Image.memory(
          base64Decode(base64),
          fit: BoxFit.cover,
        );
        // ignore: empty_catches
      } catch (ex) {}
    }
    return null;
  }

  static bool isBase64(String str) {
    return _base64.hasMatch(str);
  }

  static double? stringToDouble(String text) {
    if (StringUtils.isNullOrEmpty(text)) return null;
    return double.tryParse(text);
  }

  static int? stringToInt(String text) {
    if (StringUtils.isNullOrEmpty(text)) return null;
    return int.tryParse(text);
  }

  static List<String> split(String text) {
    if (StringUtils.isNullOrEmpty(text)) return [];
    var result = text.split(',');
    result.removeWhere((i) => StringUtils.isNullOrEmpty(i));
    return result;
  }

  static String join(Iterable<String>? items) {
    if (items == null || items.isEmpty) return '';
    return items.join(',');
  }

  static List<String> subString(String text) {
    if (StringUtils.isNullOrEmpty(text)) return [];
    var result = text.split(' ');
    var firstStringBuffer = StringBuffer();
    var lastStringBuffer = StringBuffer();
    int middle = (result.length / 2).round();
    for (int i = 0; i < middle; i++) {
      firstStringBuffer.write(result[i]);
    }
    for (int i = middle; i < result.length; i++) {
      lastStringBuffer.write(result[i]);
    }
    return <String>[firstStringBuffer.toString(), lastStringBuffer.toString()];
  }

  static int? toTicks(DateTime? date) {
    if (date == null) return null;
    return ((date.millisecondsSinceEpoch * tickNumber) + unixEpochTicks);
  }

  static int? toMilisecondTicksFrom2020(DateTime? date) {
    if (date == null) return null;
    return (date.millisecondsSinceEpoch - milisecondsFrom2020);
  }

  static DateTime currentDate() {
    var now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  static double convertIntToDouble(int? number) {
    return double.tryParse(number.toString()) ?? 0.0;
  }

  static String convertNumberOnly(String? numberString) {
    return numberString?.replaceAll(RegExp(r'[^0-9]'), '') ?? '';
  }

  static DateTime? convertStringUtcToDateTime(String time) {
    try {
      return _dateFormatUTC.parse(time);
    } catch (e) {
      return null;
    }
  }
}
