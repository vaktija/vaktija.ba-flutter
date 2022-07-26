String vaktijaTimeLeft(int currentTime, int vakatTime, bool nextVakat) {
  if (currentTime > vakatTime) {
    var timeLeftData = currentTime - vakatTime;
    if (timeLeftData > 3600) {
      int h;
      h = timeLeftData ~/ 3600;
      String proslo = 'prije ' + h.toString() + (h > 4 ? ' sati' : ' sata');
      return proslo;
    } else if (timeLeftData < 3600 && timeLeftData > 60) {
      int m = timeLeftData ~/ 60;
      String proslo = 'prije ' + m.toString() + ' minuta';
      return proslo;
    } else {
      String proslo = 'prije ' + timeLeftData.toString() + ' sekundi';
      return proslo;
    }
  } else {
    var timeLeftData = vakatTime - currentTime;
    if (nextVakat) {
      int h;
      int m;
      int s;
      h = timeLeftData ~/ 3600;
      m = (timeLeftData - (h * 3600)) ~/ 60;
      s = (timeLeftData - (h * 3600) - (m * 60));
      String preostalo = h.toString().padLeft(2, '0') +
          ':' +
          m.toString().padLeft(2, '0') +
          ':' +
          s.toString().padLeft(2, '0');
      return preostalo;
    } else {
      if (timeLeftData > 3600) {
        int h;
        h = timeLeftData ~/ 3600;
        String preostalo = 'za ' + h.toString() + (h > 4 ? ' sati' : ' sata');
        return preostalo;
      } else if (timeLeftData < 3600 && timeLeftData > 60) {
        int m = timeLeftData ~/ 60;
        String preostalo = 'za ' + m.toString() + ' minuta';
        return preostalo;
      } else {
        String preostalo = 'za ' + timeLeftData.toString() + ' sekundi';
        return preostalo;
      }
    }
  }
}
