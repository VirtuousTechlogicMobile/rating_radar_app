import 'package:RatingRadar_app/constant/strings.dart';
import 'package:intl/intl.dart';

const String dateFormatter = 'dd MMM';
const String timeFormatter = 'hh:mm a';
const String longDateFormatter = 'dd MMM yyyy';

extension DateHelper on DateTime {
  String toTimeAgo({bool? showSuffix = true, String? suffix, String? separator}) {
    var currentClock = DateTime.now();
    var elapsed = (currentClock.millisecondsSinceEpoch - millisecondsSinceEpoch).abs();
    var currentSuffix = suffix ?? 'ago';
    var currentSeparator = separator ?? ' ';
    var messageSuffix = currentSeparator + currentSuffix;

    var seconds = (elapsed / 1000).floor();

    var interval = (seconds / 31536000).floor();
    if (interval >= 1) {
      return '${interval}y${showSuffix! ? messageSuffix : ''}';
    }

    interval = (seconds / 2592000).floor();
    if (interval >= 1) {
      return '${interval}mo${showSuffix! ? messageSuffix : ''}';
    }

    interval = (seconds / 86400).floor();
    if (interval >= 1) {
      return '${interval}d${showSuffix! ? messageSuffix : ''}';
    }

    interval = (seconds / 3600).floor();
    if (interval >= 1) {
      return '${interval}h${showSuffix! ? messageSuffix : ''}';
    }

    interval = (seconds / 60).floor();
    if (interval >= 1) {
      return '${interval}m${showSuffix! ? messageSuffix : ''}';
    }

    if (seconds > 29 && seconds < 59) {
      return '${seconds}s${showSuffix! ? messageSuffix : ''}';
    }

    return 'just now';
  }

  String formatDate() {
    var diff = DateTime.now().toLocal().difference(toLocal());

    if (diff > const Duration(days: 365)) {
      return DateFormat(longDateFormatter).format(toLocal());
    } else if (isSameDate(DateTime.now()) && diff <= const Duration(days: 1)) {
      return 'Today';
    } else {
      return DateFormat(dateFormatter).format(toLocal());
    }
  }

  String getTime({bool is24Hour = false, bool showSeconds = false}) {
    var toLocal = this.toLocal();
    var hr = toLocal.hour;
    var min = toLocal.minute;
    var sec = toLocal.second;

    var hrStr = hr < 10 ? '0$hr' : '$hr';
    var minStr = min < 10 ? '0$min' : '$min';
    var secStr = sec < 10 ? '0$sec' : '$sec';

    var time = '$hrStr:$minStr';

    if (!is24Hour) {
      if (hr > 12) {
        hrStr = (hr - 12).toString();
        hrStr = hrStr.length == 1 ? '0$hrStr' : hrStr;
      } else if (hr == 0) {
        hrStr = '12';
      }
      time = '$hrStr:$minStr';
    }

    if (showSeconds) {
      time += ':$secStr';
    }

    if (!is24Hour) {
      time += ' ${hr >= 12 ? 'PM' : 'AM'}';
    }

    return time;
  }

  bool isSameDate(DateTime other) {
    return toLocal().year == other.toLocal().year && toLocal().month == other.toLocal().month && toLocal().day == other.toLocal().day;
  }

  int getDifferenceInDaysWithNow() {
    final now = DateTime.now().toLocal();
    return now.difference(toLocal()).inDays;
  }

  String getDateTime() {
    return DateFormat('dd MMM yyyy hh:mm a').format(toLocal());
  }
}
