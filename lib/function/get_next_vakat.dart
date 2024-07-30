import 'package:vaktijaba_fl/data/data.dart';

int getNextVakat(int currentTime, int grad, int mjesec, int dan, int dst) {
  int index = 0;
  if (mjesec < 0 ||
      mjesec >= 12 ||
      dan < 0 ||
      dan >= 31 ||
      grad < 0 ||
      grad >= differences.length) {
    return index;
  }

  for (int i = 0; i < 6; i++) {
    int vakatTime = vaktijaData['months'][mjesec]['days'][dan]['vakat'][i] +
        differences[grad]['months'][mjesec]['vakat'][i] +
        dst;
    //print('trenutno(s) -> $currentTime || vakatTime(s) -> $vakatTime');
    if (currentTime < vakatTime) {
      return i;
    }
  }
  return index;
}
