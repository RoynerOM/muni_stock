import 'package:intl/intl.dart';

String getFormattedDate(String date) {
  DateTime now = DateTime.parse(date);
  return DateFormat("EEEE d MMM", 'es_ES').format(now);
}
