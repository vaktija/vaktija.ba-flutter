bool checkDST(DateTime date) {
  DateTime dateStart = DateTime(date.year, 1, 1, 12, 0);
  DateTime dateCurrent = DateTime(date.year, date.month, date.day, 12, 0);
  if (dateStart.timeZoneOffset != dateCurrent.timeZoneOffset) {
    return true;
  }
  return false;
}
