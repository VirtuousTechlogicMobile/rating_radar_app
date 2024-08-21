import 'package:intl/intl.dart';

abstract class DateTimeFormatter {
  static String formatTimeStampToDashedDate(DateTime timeStamp) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(timeStamp);
    return formattedDate;
  }
}
