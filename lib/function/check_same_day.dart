
bool isSameDay(
    DateTime? date1,
    DateTime? date2, {
      List<DateTime>? markedDays,
    }) {
  if (date1 != null && markedDays != null) {
    for (DateTime markedDay in markedDays) {
      if (date1.year == markedDay.year &&
          date1.month == markedDay.month &&
          date1.day == markedDay.day) {
        return true;
      }
    }
    return false;
  }
  if (date1 == null || date2 == null) {
    return false;
  }

  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}