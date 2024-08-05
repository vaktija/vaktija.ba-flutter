class PermanentNotificationDataItem {
  int id;
  int vakatIndex;
  String title;
  String titleFull;
  String vakatTimeHHMM;
  DateTime vakatDateTime;
  int bodyId;

  PermanentNotificationDataItem({
    required this.id,
    required this.vakatIndex,
    required this.title,
    required this.titleFull,
    required this.vakatTimeHHMM,
    required this.vakatDateTime,
    required this.bodyId,
  });
}
