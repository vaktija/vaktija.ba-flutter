import 'package:hijri/hijri_calendar.dart';

String dateDMY(String date) {
  DateTime dateSource = DateTime.parse(date);
  String newDate =
      '${dateSource.day.toString().padLeft(2, '0')}.${dateSource.month.toString().padLeft(2, '0')}.${dateSource.year}.';
  return newDate;
}

String dateToStringHijri(HijriCalendar dateHijri) {
  final monthNames = [
    'muharrem',
    'safer',
    'rebi\'ul-evvel',
    'rebi\'ul-ahir',
    'džumadel-ula',
    'džumadel-uhra',
    'redžeb',
    'ša\'ban',
    'ramazan',
    'ševval',
    'zul-ka\'ade',
    'zul-hidždže'
  ];

  String newDate =
      '${dateHijri.hDay}. ${monthNames[dateHijri.hMonth - 1]} ${dateHijri.hYear}';

  return newDate;
}
