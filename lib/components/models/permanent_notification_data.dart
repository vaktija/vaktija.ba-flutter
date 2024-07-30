class PermanentNotificationDataItem {
  int id;
  String title;
  String vakatTimeHHMM;
  DateTime vakatDateTime;
  int bodyId;

  PermanentNotificationDataItem({
    required this.id,
    required this.title,
    required this.vakatTimeHHMM,
    required this.vakatDateTime,
    required this.bodyId,
  });
}
