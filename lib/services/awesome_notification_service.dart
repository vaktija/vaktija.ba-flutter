// import 'dart:isolate';
// import 'dart:ui';
//
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:flutter/material.dart';
// import 'package:vaktijaba_fl/app_theme/theme_data.dart';
//
// class NotificationController {
//   static ReceivedAction? initialAction;
//
//   static Future<void> initializeLocalNotifications() async {
//     await AwesomeNotifications().initialize(
//         'resource://drawable/notification_icon',
//         [
//           NotificationChannels.notificationChannelSilent,
//           NotificationChannels.notificationChannelVakat,
//           NotificationChannels.notificationChannelVaktijaPermanent
//         ],
//         debug: true);
//     initialAction = await AwesomeNotifications()
//         .getInitialNotificationAction(removeFromActionEvents: false);
//   }
//
//   static ReceivePort? receivePort;
//
//   static Future<void> initializeIsolateReceivePort() async {
//     receivePort = ReceivePort('Notification action port in main isolate')
//       ..listen(
//           (silentData) => onActionReceivedImplementationMethod(silentData));
//
//     IsolateNameServer.registerPortWithName(
//         receivePort!.sendPort, 'notification_action_port');
//   }
//
//   static Future<void> startListeningNotificationEvents() async {
//     AwesomeNotifications()
//         .setListeners(onActionReceivedMethod: onActionReceivedMethod);
//   }
//
//   @pragma('vm:entry-point')
//   static Future<void> onActionReceivedMethod(
//       ReceivedAction receivedAction) async {
//     if (receivedAction.actionType == ActionType.SilentAction ||
//         receivedAction.actionType == ActionType.SilentBackgroundAction) {
//     } else if (receivedAction.actionType == ActionType.KeepOnTop) {
//       return onActionReceivedImplementationMethod(receivedAction);
//     } else {
//       if (receivePort == null) {
//         print(
//             'onActionReceivedMethod was called inside a parallel dart isolate.');
//         SendPort? sendPort =
//             IsolateNameServer.lookupPortByName('notification_action_port');
//
//         if (sendPort != null) {
//           print('Redirecting the execution to main isolate process.');
//           sendPort.send(receivedAction);
//           return;
//         }
//       }
//
//       return onActionReceivedImplementationMethod(receivedAction);
//     }
//   }
//
//   static Future<void> onActionReceivedImplementationMethod(
//       ReceivedAction receivedAction) async {
//     // NavigationService.navigatorKey.currentState?.pushAndRemoveUntil(
//     //   MaterialPageRoute(
//     //     builder: (context) => HomeScreen(),
//     //   ),
//     //   (route) => false, // Remove all previous routes
//     // );
//   }
//
//   static Future<void> executeLongTaskInBackground(
//       BuildContext? context) async {}
//
//   static Future<void> cancelNotification(int id) async {
//     await AwesomeNotifications().cancel(id);
//   }
//
//   static Future<void> cancelNotifications() async {
//     await AwesomeNotifications().cancelAll();
//   }
// }
//
// //build notification
// NotificationContent buildNotificationContent({
//   required int id,
//   required String channelKey,
//   ActionType? actionType,
//   String? title,
//   required String? body,
//   Map<String, String>? payload,
//   Duration? timeoutAfter,
//   bool? wakeUpScreen,
//   bool? showWhen,
//   bool? criticalAlert,
//   String? customSound,
// }) {
//   return NotificationContent(
//     id: id,
//     channelKey: channelKey,
//     actionType: actionType ?? ActionType.Default,
//     title: title ?? '',
//     body: body,
//     payload: payload,
//     timeoutAfter: timeoutAfter,
//     wakeUpScreen: wakeUpScreen ?? false,
//     showWhen: showWhen ?? true,
//     category: NotificationCategory.Alarm,
//     criticalAlert: criticalAlert ?? false,
//   );
// }
//
// NotificationContent buildNotificationContentTimer({
//   required int id,
//   required String channelKey,
//   ActionType? actionType,
//   String? title,
//   required String body,
//   Map<String, String>? payload,
//   Duration? timeoutAfter,
//   bool? wakeUpScreen,
//   bool? showWhen,
//   bool? criticalAlert,
//   String? customSound,
// }) {
//   return NotificationContent(
//     id: id,
//     channelKey: channelKey,
//     actionType: actionType ?? ActionType.Default,
//     title: title,
//     body: body,
//     notificationLayout: NotificationLayout.BigText,
//     payload: payload,
//     //timeoutAfter: timeoutAfter,
//     autoDismissible: false,
//     wakeUpScreen: false,
//     //showWhen: true,
//     criticalAlert: true,
//     duration: timeoutAfter,
//     chronometer: timeoutAfter,
//     summary: 'Naredni vakat za',
//     category: NotificationCategory.Alarm,
//     displayOnForeground: true,
//     displayOnBackground: true,
//   );
// }
//
// //createNotification
// Future<void> showNotificationAwesome(
//     {required NotificationContent notificationContent}) async {
//   await AwesomeNotifications().createNotification(
//     content: notificationContent,
//   );
// }
//
// //schedule notifications
// Future<void> showNotificationScheduleAwesome({
//   required DateTime scheduleDate,
//   required NotificationContent notificationContent,
//   bool? allowWhileIdle,
// }) async {
//   await AwesomeNotifications().createNotification(
//     schedule: NotificationCalendar(
//       year: scheduleDate.year,
//       month: scheduleDate.month,
//       day: scheduleDate.day,
//       hour: scheduleDate.hour,
//       minute: scheduleDate.minute,
//       second: scheduleDate.second,
//       allowWhileIdle: true,
//       preciseAlarm: true,
//       repeats: false,
//     ),
//     content: notificationContent,
//   );
// }
//
// //notification channels
// class NotificationChannels {
//   static NotificationChannel notificationChannelSilent = NotificationChannel(
//     channelKey: 'silent',
//     channelName: 'Device - silent',
//     channelDescription: 'Device - silent',
//     channelShowBadge: false,
//     playSound: false,
//     onlyAlertOnce: true,
//     enableVibration: true,
//     criticalAlerts: true,
//     groupAlertBehavior: GroupAlertBehavior.Children,
//     importance: NotificationImportance.High,
//     defaultPrivacy: NotificationPrivacy.Public,
//     defaultColor: AppColors.colorGold,
//     ledColor: AppColors.colorSwitchActive,
//   );
//
//   static NotificationChannel notificationChannelVakat = NotificationChannel(
//     channelKey: 'vakat',
//     channelName: 'Vakat',
//     channelDescription: 'Najava vakta',
//     channelShowBadge: false,
//     playSound: true,
//     onlyAlertOnce: true,
//     enableVibration: true,
//     criticalAlerts: true,
//     soundSource: 'resource://raw/notification',
//     groupAlertBehavior: GroupAlertBehavior.Children,
//     importance: NotificationImportance.High,
//     defaultPrivacy: NotificationPrivacy.Public,
//     defaultColor: AppColors.colorGold,
//     ledColor: AppColors.colorSwitchActive,
//   );
//
//   static NotificationChannel notificationChannelVaktijaPermanent =
//       NotificationChannel(
//     channelKey: 'vakat-timer',
//     channelName: 'Vakat timer',
//     channelDescription: 'Trajni vakat',
//     channelShowBadge: false,
//     playSound: false,
//     onlyAlertOnce: false,
//     enableVibration: false,
//     locked: true,
//     groupAlertBehavior: GroupAlertBehavior.Children,
//     importance: NotificationImportance.High,
//     defaultPrivacy: NotificationPrivacy.Public,
//     defaultColor: AppColors.colorGold,
//     ledColor: AppColors.colorSwitchActive,
//   );
// }
//