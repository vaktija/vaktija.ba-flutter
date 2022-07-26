import 'package:vaktijaba_fl/data/data.dart';

getNextVakat(currentTime, grad, mjesec, dan, dst) {
  int index;
  for (int i = 0; i < 6; i++) {
    int vakatTime = vaktijaData['months'][mjesec]['days'][dan]
    ['vakat'][i] +
        differences[grad]['months'][mjesec]['vakat'][i] + dst;
    if (currentTime < vakatTime) {
      index = 0;
      return index;
    } else {
      if (i == 5) {
        index = i;
        return index;
      } else {
        int nextVakat = vaktijaData['months'][mjesec]['days'][dan]
        ['vakat'][i + 1] +
            differences[grad]['months'][mjesec]['vakat'][i + 1] + dst;
        if (currentTime < nextVakat) {
          index = i + 1;
          return index;
        } else {
          // return 0;
        }
      }
    }
  }
}