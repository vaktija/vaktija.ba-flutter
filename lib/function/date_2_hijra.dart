import 'package:hijri/hijri_calendar.dart';
import 'package:vaktijaba_fl/data/data.dart';

String dateToHijraDate(DateTime date) {
  String dateSource = HijriCalendar.fromDate(date).toString();
  var hijraDateSource = dateSource.split('/');
  int day = int.parse(hijraDateSource[0]);
  int month = int.parse(hijraDateSource[1]) - 1;
  String year = hijraDateSource[2].toString();
  String finalHijraDate =
      '${day}. ${mjeseciHidz[month]} ${year}.';
  return finalHijraDate;
}
