//import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart';
import 'package:vaktijaba_fl/services/notification_service.dart';

//
class ModelNotificationItem {
  //NotificationContent?
  Null notificationContent;
  DateTime? scheduleDate;

  int id;
  String? title;
  String body;
  TZDateTime? scheduleTZDate;
  AndroidNotificationDetails? androidNotificationDetails;
  DarwinNotificationDetails? iOSPlatformChannelSpecifics;
  AndroidScheduleMode? androidScheduleMode;
  UILocalNotificationDateInterpretation? uiLocalNotificationDateInterpretation;
  String? payload;

  ModelNotificationItem({
    this.notificationContent,
    this.scheduleDate,
    required this.id,
    this.title,
    required this.body,
    this.scheduleTZDate,
    this.androidNotificationDetails,
    this.iOSPlatformChannelSpecifics,
    this.androidScheduleMode,
    this.uiLocalNotificationDateInterpretation,
    this.payload,
  });
}

class NotificationChannelAndroidModel {
  String channelId;
  String channelName;
  String? channelDescription;

  NotificationChannelAndroidModel({
    required this.channelId,
    required this.channelName,
    this.channelDescription,
  });
}

ModelNotificationItem buildNotificationTimer({
  required id,
  String? title,
  required String body,
  required DateTime vakatDateTime,
  DateTime? scheduleDateTime,
  required bool isFirst,
  String? summaryText,
}) {
  TZDateTime scheduleDate = getScheduleDate(scheduleDateTime ?? vakatDateTime);
  int seconds = vakatDateTime.difference(DateTime.now()).inSeconds;
  ModelNotificationItem modelNotificationItem = ModelNotificationItem(
    id: id,
    title: title,
    body: body,
    scheduleTZDate: isFirst ? null : scheduleDate,
    androidNotificationDetails: buildAndroidNotificationDetailsTimer(
      vakatTime: vakatDateTime,
      body: body,
      isFirst: isFirst
      //summaryText: summaryText,
    ),
    notificationContent: null,
    // buildNotificationContentTimer(
    //   id: id + 10000,
    //   channelKey:
    //       NotificationChannels.notificationChannelVaktijaPermanent.channelKey!,
    //   body: body,
    //   timeoutAfter: Duration(
    //     seconds: seconds,
    //   ),
    // ),
    scheduleDate: vakatDateTime,
    androidScheduleMode: AndroidScheduleMode.alarmClock,
  );
  return modelNotificationItem;
}

ModelNotificationItem buildNotificationVakat({
  required id,
  String? title,
  required String body,
  required DateTime vakatDateTime,
  required DateTime scheduleDateTime,
  required int timeoutAfter,
}) {
  TZDateTime scheduleTZDate = getScheduleDate(scheduleDateTime);
  ModelNotificationItem modelNotificationItem = ModelNotificationItem(
    id: id,
    title: title,
    body: body,
    scheduleTZDate: scheduleTZDate,
    notificationContent: null,
    // buildNotificationContent(
    //   id: id,
    //   channelKey: NotificationChannels.notificationChannelVakat.channelKey!,
    //   body: body,
    // ),
    androidNotificationDetails: buildAndroidNotificationDetailsVakat(
      timeoutAfter: timeoutAfter,
    ),
    scheduleDate: scheduleDateTime,
    androidScheduleMode: AndroidScheduleMode.alarmClock,
  );
  return modelNotificationItem;
}

ModelNotificationItem buildNotificationSilent({
  required int id,
  required String title,
  required String body,
  required String payload,
  required DateTime scheduleDateTime,
}) {
  TZDateTime scheduleTZDate = getScheduleDate(scheduleDateTime);
  ModelNotificationItem modelNotificationItem = ModelNotificationItem(
    id: id,
    title: title,
    body: body,
    scheduleTZDate: scheduleTZDate,
    notificationContent: null,
    androidNotificationDetails: buildAndroidNotificationDetailsSilent(),
    scheduleDate: scheduleDateTime,
    androidScheduleMode: AndroidScheduleMode.alarmClock,
    payload: payload
  );
  return modelNotificationItem;
}
