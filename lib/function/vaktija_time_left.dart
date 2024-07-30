import 'package:vaktijaba_fl/function/sec_2_hhmm.dart';

String vaktijaTimeLeft(int currentTime, int vakatTime, bool nextVakat) {
  DateTime now = DateTime.now();
  String hhMM = secondsToHHMM(vakatTime);
  DateTime vakatDateTime = DateTime.parse(
      '${now.year}-${twoDigits(now.month)}-${twoDigits(now.day)} $hhMM');
  if (vakatDateTime.isBefore(now) && nextVakat) {
    vakatDateTime = vakatDateTime.add(
      const Duration(days: 1),
    );
  }
  if (nextVakat) {
    int timeLeftData = vakatDateTime.difference(now).inSeconds;
    int h = timeLeftData ~/ 3600;
    int m = (timeLeftData - (h * 3600)) ~/ 60;
    int s = (timeLeftData - (h * 3600) - (m * 60));
    String preostalo = 'za ${twoDigits(h)}:${twoDigits(m)}:${twoDigits(s)}';
    return preostalo;
  }

  if (vakatDateTime.isAfter(now)) {
    int timeLeftData = vakatDateTime.difference(now).inSeconds;
    if (timeLeftData > 3600) {
      int hours = timeLeftData ~/ 3600;
      return 'za $hours ${hours > 4 ? 'sati' : 'sata'}';
    } else if (timeLeftData > 60) {
      return 'za ${timeLeftData ~/ 60} minuta';
    } else {
      return 'za $timeLeftData sekundi';
    }
  }

  if (vakatDateTime.isBefore(now)) {
    int timeLeftData = now.difference(vakatDateTime).inSeconds;
    if (timeLeftData > 3600) {
      int hours = timeLeftData ~/ 3600;
      return 'prije $hours ${hours > 4 ? 'sati' : 'sata'}';
    } else if (timeLeftData > 60) {
      return 'prije ${timeLeftData ~/ 60} minuta';
    } else {
      return 'prije $timeLeftData sekundi';
    }
  }
  return '00:00:00';
}
