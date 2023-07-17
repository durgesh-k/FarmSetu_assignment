import 'package:intl/intl.dart';

String formatDate(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  return DateFormat('EEE dd MMMM').format(dateTime);
}

String formatTime(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  return DateFormat('hh:mm a').format(dateTime);
}

double kelvinToCelsius(double kelvin) {
  return (kelvin - 273.15).toDouble();
}
