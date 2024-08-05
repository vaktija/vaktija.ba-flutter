import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sound_mode/sound_mode.dart';
import 'package:sound_mode/utils/ringer_mode_statuses.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:vaktijaba_fl/components/models/model_notification_item.dart';
import 'package:vaktijaba_fl/main.dart';

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> init({
    required Function() handleNotification,
  }) async {
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
          selectNotification(payload, handleNotification);
        }
      },
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
        );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      //onDidReceiveNotificationResponse: onActionReceivedMethod,
      //onDidReceiveBackgroundNotificationResponse: onActionReceivedMethod,
    );
  }

  @pragma('vm:entry-point')
  Future<void> onActionReceivedMethod(
      NotificationResponse notificationResponse) async {
    if (notificationResponse.payload == 'silent') {
      await SoundMode.setSoundMode(RingerModeStatus.silent);
    } else if (notificationResponse.payload == 'restore') {
      await SoundMode.setSoundMode(RingerModeStatus.normal);
    }
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
          critical: false,
        );
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  Future<void> showNotification({
    required ModelNotificationItem notificationItem,
  }) async {
    //for scheduled notification
    //print('Scheduled ${notificationItem.androidNotificationDetails!.ongoing}');
    if (notificationItem.scheduleTZDate != null) {
      try {
        //TODO uncomment for testing
        // print('old ${notificationItem.scheduleTZDate}');
        // notificationItem.scheduleTZDate =
        //     tz.TZDateTime.now(tz.local).add(Duration(seconds: 30));
        // print(
        //     '${notificationItem.id} - new ${notificationItem.scheduleTZDate}');
        await flutterLocalNotificationsPlugin.zonedSchedule(
          notificationItem.id,
          notificationItem.title,
          notificationItem.body,
          notificationItem.scheduleTZDate!,
          NotificationDetails(
            android: notificationItem.androidNotificationDetails,
            iOS: notificationItem.iOSPlatformChannelSpecifics,
          ),
          androidScheduleMode: notificationItem.androidScheduleMode ??
              AndroidScheduleMode.alarmClock,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          payload: notificationItem.payload,
        );
        //print('zakazano uspjesno ${notificationItem.scheduleTZDate}');
      } catch (e) {
        print(e);
      }
      return;
    }

    //for immediate notification
    try {
      await flutterLocalNotificationsPlugin.show(
        notificationItem.id,
        notificationItem.title,
        notificationItem.body,
        NotificationDetails(
            android: notificationItem.androidNotificationDetails,
            iOS: notificationItem.iOSPlatformChannelSpecifics),
        payload: notificationItem.payload ?? '',
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelNotificationAll() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

//additional void
Future selectNotification(
    String? payload, Function() handleNotification) async {
  handleNotification();
  NotificationService().cancelNotification(int.parse(payload!));
}

tz.TZDateTime getScheduleDate(DateTime date, {int? hours, int? minutes}) {
  final DateTime nowNew = DateTime(
          date.year,
          date.month,
          date.day,
          hours ?? date.hour,
          minutes ?? date.minute,
          date.second,
          date.millisecond)
      .subtract(date.timeZoneOffset);
  tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      nowNew.year,
      nowNew.month,
      nowNew.day,
      nowNew.hour,
      nowNew.minute,
      nowNew.second,
      date.millisecond);
  return scheduledDate;
}

AndroidNotificationDetails buildAndroidNotificationDetailsSilent({
  int? timeoutAfter,
}) {
  return AndroidNotificationDetails(
    NotificationChannels.silent.channelId,
    NotificationChannels.silent.channelName,
    channelDescription: NotificationChannels.silent.channelDescription,
    importance: Importance.high,
    priority: Priority.high,
    //timeoutAfter: timeoutAfter,
    showWhen: true,
    playSound: true,
    enableVibration: true,
    silent: false,
    channelShowBadge: false,
    autoCancel: true,
    visibility: NotificationVisibility.public,
    //sound: RawResourceAndroidNotificationSound('notification'),
  );
}

AndroidNotificationDetails buildAndroidNotificationDetailsVakat({
  required int timeoutAfterMS,
}) {
  return AndroidNotificationDetails(
    NotificationChannels.vakat.channelId,
    NotificationChannels.vakat.channelName,
    channelDescription: NotificationChannels.vakat.channelDescription,
    importance: Importance.high,
    priority: Priority.high,
    timeoutAfter: timeoutAfterMS,
    showWhen: true,
    playSound: true,
    enableVibration: true,
    silent: false,
    channelShowBadge: false,
    autoCancel: true,
    visibility: NotificationVisibility.public,
    //sound: RawResourceAndroidNotificationSound('notification'),
  );
}

// DarwinNotificationDetails buildIOSNotificationDetailsVakat(){
//   return const DarwinNotificationDetails(
//     presentAlert: true,
//     presentSound: true,
//     //sound: 'notification.mp3',
//   );
// }

AndroidNotificationDetails buildAndroidNotificationDetailsTimer({
  required DateTime vakatDateTime,
  DateTime? vakatDateTimeNext,
  required String body,
  required bool isFirst,
  String? subtext,
  String? summaryText,
  required int timeoutAfterMS
}) {

  return AndroidNotificationDetails(
    NotificationChannels.vakatTimer.channelId,
    NotificationChannels.vakatTimer.channelName,
    channelDescription: NotificationChannels.vakatTimer.channelDescription!,
    importance: Importance.high,
    priority: Priority.high,
    onlyAlertOnce: false,
    usesChronometer: true,
    chronometerCountDown: true,
    playSound: isFirst ? false: true,
    enableVibration: isFirst ? false : true,
    when: (vakatDateTimeNext ?? vakatDateTime).millisecondsSinceEpoch,
    timeoutAfter: timeoutAfterMS,
    subText: subtext,
    silent: isFirst ? true : false,
    ongoing: true,
    showWhen: true,
    showProgress: true,
    channelShowBadge: false,
    autoCancel: false,
    visibility: NotificationVisibility.public,
    //sound: RawResourceAndroidNotificationSound('notification'),
    styleInformation: BigTextStyleInformation(
      body,
      summaryText: 'Naredni vakat za:',
      //summaryText,
      htmlFormatSummaryText: true,
      htmlFormatContentTitle: true,
      htmlFormatContent: true,
      htmlFormatBigText: true,
    ),
  );
}

//Notification channels
class NotificationChannels {
  static NotificationChannelAndroidModel silent =
      NotificationChannelAndroidModel(
    channelId: 'silent-device-1',
    channelName: 'Device - silent',
    channelDescription: 'Vrijeme utišavanje uređaja',
  );

  static NotificationChannelAndroidModel vakat =
      NotificationChannelAndroidModel(
    channelId: 'vakat-1',
    channelName: 'Vakat',
    channelDescription: 'Napomena za naredni vakat',
  );

  static NotificationChannelAndroidModel vakatTimer =
      NotificationChannelAndroidModel(
    channelId: 'vakat-timer-1',
    channelName: 'Vakat - timer',
    channelDescription: 'Vrijeme do narednog vakta',
  );
}

class FixedNotificationId{
  static int firstPermanenet = 1000;
  static int idSilent = 10000;
  static int idTimer = 11000;
}
