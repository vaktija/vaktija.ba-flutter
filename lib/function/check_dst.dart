
bool checkDST (DateTime date){
  DateTime dateStart = DateTime(date.year, 1, 1, 12, 0);
  if(date.timeZoneOffset != dateStart.timeZoneOffset){
    return true;
  }
  return false;
}