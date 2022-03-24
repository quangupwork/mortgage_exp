extension DateTimeExtension on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool isNotSameDate(DateTime other) {
    return year != other.year || month != other.month || day != other.day;
  }

  bool operator >=(DateTime other) {
    final now = toUtc().millisecondsSinceEpoch;
    final otherUtc = other.toUtc().millisecondsSinceEpoch;
    return now >= otherUtc;
  }

  bool operator >(DateTime other) {
    final now = toUtc().millisecondsSinceEpoch;
    final otherUtc = other.toUtc().millisecondsSinceEpoch;
    return now > otherUtc;
  }

  bool operator <=(DateTime other) {
    final now = toUtc().millisecondsSinceEpoch;
    final otherUtc = other.toUtc().millisecondsSinceEpoch;
    return now <= otherUtc;
  }

  bool operator <(DateTime other) {
    final now = toUtc().millisecondsSinceEpoch;
    final otherUtc = other.toUtc().millisecondsSinceEpoch;
    return now < otherUtc;
  }
}
