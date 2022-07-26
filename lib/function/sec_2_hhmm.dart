
String vaktijaSec2Min(int value) {
  int h, m, s;

  h = value ~/ 3600;

  m = ((value - h * 3600)) ~/ 60;

  s = value - (h * 3600) - (m * 60);

  String sati = h.toString().padLeft(2, '0');
  String minute = m.toString().padLeft(2, '0');

  String vakatVrijeme = "$sati:$minute";
  return vakatVrijeme;
}