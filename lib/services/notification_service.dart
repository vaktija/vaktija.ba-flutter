
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
    AndroidInitializationSettings('launch_image');

    final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS);

    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  AndroidNotificationDetails _androidNotificationDetails =
  AndroidNotificationDetails(
    'channel ID',
    'channel name',
    playSound: true,
    ongoing: true,
    autoCancel: true,
    priority: Priority.high,
    importance: Importance.high,
  );

  var _iOSPlatformChannelSpecifics = IOSNotificationDetails(
    presentSound: true,
    //presentAlert: true
  );

  Future<void> showNotifications(id, title, body, payload) async {
    await flutterLocalNotificationsPlugin.show(
        id ?? 0,
        title,
        body,
        NotificationDetails(
            android: _androidNotificationDetails,
            iOS: _iOSPlatformChannelSpecifics),
        payload: payload ?? '');
  }

  Future<void> scheduleNotifications(id, title, body, duration) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id ?? 0,
        title ?? "Notification Title",
        body ?? "This is the Notification Body!",
        tz.TZDateTime.now(tz.local).add(Duration(seconds: duration ?? 10)),
        NotificationDetails(android: _androidNotificationDetails),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        payload: id.toString());
  }

  Future<void> cancelNotifications(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

Future selectNotification(String? payload) async {
  //HomePageData.homePageInitialIndex = 9;
  NotificationService().cancelNotifications(int.parse(payload!));
  print(payload);

  /*Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
          builder: (context) => HomePage(),
          settings: RouteSettings(name: 'homePage')),
          (route) => false);*/

  /*await Navigator.pushReplacement(
    context,
    MaterialPageRoute<void>(builder: (context) => HomePage()),
  );*/
}
