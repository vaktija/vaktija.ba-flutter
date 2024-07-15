import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  //NotificationService a singleton object
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  static const channelId = '123';

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('notification_icon');

    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {
        if (payload != null) {
          selectNotification(payload);
        }
      },
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    tz.initializeTimeZones();
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  requestPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
        critical: false);
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }




  AndroidNotificationDetails androidNotificationDetails =
  const AndroidNotificationDetails(
    '1000',
    'Isl. zajednica notifikacija',
    playSound: true,
    ongoing: false,
    autoCancel: true,
    priority: Priority.high,
    importance: Importance.high,
  );

  final DarwinNotificationDetails iOSPlatformChannelSpecifics =
  const DarwinNotificationDetails(
    //presentAlert: false,
    //presentBadge: false,
    presentSound: true,
  );


  Future<void> showNotifications(id, title, body, payload) async {
    print(title);
    try{
      await flutterLocalNotificationsPlugin.show(
          id ?? 0,
          title,
          body,
          NotificationDetails(
              android: androidNotificationDetails,
              iOS: iOSPlatformChannelSpecifics),
          payload: payload ?? '');
    } catch(e){
      print(e);
    }
  }

  Future<void> dnevnaVaktijaNotification(
      int id, title, body, payload, DateTime date, timeOut) async {
    //String longdata = body.toString().replaceAll(' | ', '\n');
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      body,
      htmlFormatSummaryText: true,
      htmlFormatContent: true,
      htmlFormatBigText: true,
    );
    AndroidNotificationDetails androidDnevnaVaktija =
    AndroidNotificationDetails(
      '10', 'Vaktija - dnevna',
      playSound: false,
      enableVibration: false,
      ongoing: true,
      autoCancel: false,
      priority: Priority.low,
      importance: Importance.low,
      timeoutAfter: int.parse(timeOut.round().toString()) * 1000,
      showWhen: false,
      //sound: UriAndroidNotificationSound("assets/vaktija/vaktija_audio_not.mp3"),
      visibility: NotificationVisibility.public,
      styleInformation: bigTextStyleInformation,
    );

    DarwinNotificationDetails iOSDnevnaVaktija = DarwinNotificationDetails(
      presentSound: false,
      presentAlert: false
    );

    NotificationDetails platformChannelSpecificsSchedule = NotificationDetails(
        android: androidDnevnaVaktija, iOS: iOSDnevnaVaktija);
    if (date.isBefore(DateTime.now())) {
      await flutterLocalNotificationsPlugin.show(
          id, title, body, platformChannelSpecificsSchedule,
          payload: id.toString());
    } else {
      await flutterLocalNotificationsPlugin.zonedSchedule(id, title, body,
          _dailySchedule(date), platformChannelSpecificsSchedule,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
          payload: id.toString());
    }
  }

  Future<void> scheduleNotifications(
      int id, title, body, date, hours, minutes, timeout) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('vaktovi-id', 'Vaktija',
            playSound: true,
            ongoing: true,
            autoCancel: false,
            priority: Priority.high,
            importance: Importance.high,
            showWhen: true,
            enableVibration: true,
            timeoutAfter: int.parse(timeout.round().toString()) * 1000,
            visibility: NotificationVisibility.public);

    DarwinNotificationDetails iOSPlatformChannelSpecifics =
        const DarwinNotificationDetails(
      presentSound: true,
      presentAlert: true
    );

   // print('id ${id}');
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        _nextVakat(date, hours, minutes),
        NotificationDetails(
            android: androidPlatformChannelSpecifics,
            iOS: iOSPlatformChannelSpecifics),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: id.toString());
  }

  Future<void> cancelNotifications(int id) async {
   // print('notification canceld ($id)');
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  tz.TZDateTime _nextVakat(date, hours, minutes) {
    final DateTime nowNew =
        DateTime(date.year, date.month, date.day, hours, minutes)
            .subtract(date.timeZoneOffset);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, nowNew.year,
        nowNew.month, nowNew.day, nowNew.hour, nowNew.minute);
    return scheduledDate;
  }

  tz.TZDateTime _dailySchedule(date) {
    final DateTime nowNew = DateTime(date.year, date.month, date.day, 1, 0)
        .subtract(date.timeZoneOffset);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, nowNew.year,
        nowNew.month, nowNew.day, nowNew.hour, nowNew.minute);
   // print(scheduledDate);
    return scheduledDate;
  }
}

Future selectNotification(String? payload) async {
  NotificationService().cancelNotifications(int.parse(payload!));
}
