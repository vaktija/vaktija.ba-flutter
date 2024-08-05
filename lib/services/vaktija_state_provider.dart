import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:alarm/alarm.dart';
//import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaktijaba_fl/components/models/device_silent_data_item.dart';
import 'package:vaktijaba_fl/components/models/model_notification_item.dart';
import 'package:vaktijaba_fl/components/models/permanent_notification_data.dart';
import 'package:vaktijaba_fl/components/models/vakat_settings_model.dart';
import 'package:vaktijaba_fl/components/models/vaktija_settings_model.dart';
import 'package:vaktijaba_fl/data/app_data.dart';
import 'package:vaktijaba_fl/data/data.dart';
import 'package:vaktijaba_fl/function/alarm_permission.dart';
import 'package:vaktijaba_fl/function/check_dst.dart';
import 'package:vaktijaba_fl/function/date_2_hijra.dart';
import 'package:vaktijaba_fl/function/sec_2_hhmm.dart';
import 'package:vaktijaba_fl/function/show_snackbar_message.dart';
import 'package:vaktijaba_fl/services/alarm_service.dart';
import 'package:vaktijaba_fl/services/notification_service.dart';
import 'package:workmanager/workmanager.dart';

List<VakatSettingsModel> vaktoviInit = [
  VakatSettingsModel(
    vakatName: 'Zora/Sabah',
    fullName: 'Sabah-namaz',
    shortName: 'Zora',
    vakatIndex: 0,
  ),
  VakatSettingsModel(
    vakatName: 'Izlazak sunca',
    fullName: 'Izlazak sunca',
    shortName: 'I. sunca',
    vakatIndex: 1,
    silentBefore: true,
  ),
  VakatSettingsModel(
      vakatName: 'Podne',
      fullName: 'Podne-namaz',
      shortName: 'Podne',
      vakatIndex: 2,
      fixedTime: true),
  VakatSettingsModel(
    vakatName: 'Ikindija',
    fullName: 'Ikindija-namaz',
    shortName: 'Ikindija',
    vakatIndex: 3,
  ),
  VakatSettingsModel(
    vakatName: 'Akšam',
    fullName: 'Akšam-namaz',
    shortName: 'Akšam',
    vakatIndex: 4,
  ),
  VakatSettingsModel(
    vakatName: 'Jacija',
    fullName: 'Jacija-namaz',
    shortName: 'Jacija',
    vakatIndex: 5,
  ),
  VakatSettingsModel(
      vakatName: 'Džuma',
      fullName: 'Džuma-namaz',
      shortName: 'Džuma',
      vakatIndex: 6,
      deviceSilentTime: 2700,
      fixedTime: true),
];
VaktijaSettingsModel vaktijaSettingsInit =
    VaktijaSettingsModel(permanentVaktija: Platform.isAndroid ? true : false);

bool showHintFieldInit = true;

void updateVakatSettings(BuildContext context,
        VakatSettingsModel vakatSettingsModel, int index) =>
    Provider.of<StateProviderVaktija>(context, listen: false)
        .setVakatValues(index: index, vakatSettingsModel: vakatSettingsModel);

void updateVaktijaSettings(
        BuildContext context, VaktijaSettingsModel vaktijaSettingsModel) =>
    Provider.of<StateProviderVaktija>(context, listen: false).setVaktijaValues(
      vaktijaSettingsModel: vaktijaSettingsModel,
    );

void hideHint(BuildContext context) =>
    Provider.of<StateProviderVaktija>(context, listen: false).hideHint();

//Vaktija state provider

class StateProviderVaktija extends ChangeNotifier {
  VaktijaSettingsModel _vaktijaSettings = vaktijaSettingsInit;
  List<VakatSettingsModel> _vaktovi = vaktoviInit;
  int _totalVakatNotifications = Platform.isIOS ? 42 : 24;

  VaktijaSettingsModel get vaktijaSettings => _vaktijaSettings;

  List<VakatSettingsModel> get vaktovi => _vaktovi;

  bool _showHintField = showHintFieldInit;

  bool get showHintField => _showHintField;

  Timer _timer = Timer(Duration(seconds: 0), () {});

  final Duration _snackDuration = const Duration(milliseconds: 2500);

  // EdgeInsetsGeometry _snackbarMargin(BuildContext context) {
  //   return EdgeInsets.only(
  //     top: MediaQuery.of(context).size.height - 500,
  //   );
  // }

  setVakatValues({
    required int index,
    required VakatSettingsModel vakatSettingsModel,
  }) {
    _vaktovi[index] = vakatSettingsModel;
    scheduleVakat();
    notifyListeners();
    saveVaktoviSettings();
  }

  setVaktijaValues({
    required VaktijaSettingsModel vaktijaSettingsModel,
  }) {
    _vaktijaSettings = vaktijaSettingsModel;
    scheduleVakat();
    notifyListeners();
    saveVaktijaSettings();
  }

  hideHint() {
    _showHintField = false;
    notifyListeners();
    saveShowHintState();
  }

  saveVaktoviSettings() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String saveData = jsonEncode(_vaktovi);
    sp.setString(SpKeys.vaktoviSettingsKey, saveData);
  }

  saveVaktijaSettings() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String saveData = jsonEncode(_vaktijaSettings);
    sp.setString(SpKeys.vaktijaSettingsString, saveData);
  }

  saveShowHintState() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool(SpKeys.initShowSettingsHint, _showHintField);
  }

  scheduleVakat({
    bool? delay,
  }) async {
    if (_timer.isActive) {
      _timer.cancel();
    }
    try {
      removeSnackbarAll();
      showSnackbarMessage(
        message: 'Podešavam notifikacije!',
        //margin: _snackbarMargin(context),
        duration: Duration(seconds: 15),
        //behavior: SnackBarBehavior.floating
      );
    } catch (e) {
      print(e);
    }
    _timer = Timer(
      Duration(seconds: delay ?? true ? 4 : 0),
      () async {
        //app update vaktovi settings here
        if (_vaktovi[0].vakatName != 'Zora/Sabah') {
          _vaktovi[0].vakatName = 'Zora/Sabah';
          notifyListeners();
          saveVaktoviSettings();
        }
        if (_vaktovi[0].fullName != 'Sabah-namaz') {
          _vaktovi[0].fullName = 'Sabah-namaz';
          notifyListeners();
          saveVaktoviSettings();
        }
        if (vaktijaData != null) {
          //remove current
          await Alarm.stopAll();
          if (Platform.isAndroid) {
            Workmanager().cancelAll();
          }
          NotificationService().cancelNotificationAll();

          int currentCity = vaktijaSettings.currentCity!;
          int podneDefaultTime = 43200;
          int totalAlarms = 3;
          //for testing only
          //totalAlarms = 1;
          List<AlarmSettings> newAlarms = [];
          List<ModelNotificationItem> notificationItemsVakat = [];
          List<PermanentNotificationDataItem> permanentNotifications = [];
          List<DeviceSilentDataItem> deviceSilentItems = [];
          List<String> bodyData = [];
          for (int indexDana = 0; indexDana < 6; indexDana++) {
            DateTime date = DateTime.now().add(
              Duration(
                days: indexDana,
              ),
            );
            int dstAddonTime = checkDST(date) ? 3600 : 0;
            List<String> totalVakats = [
              ' - <br><b>${gradovi[_vaktijaSettings.currentCity!]}</b>, ${dateToHijraDate(date)}',
            ];
            for (int vakatIndex = 0; vakatIndex < 6; vakatIndex++) {
              int month = date.month - 1;
              int day = date.day - 1;

              VakatSettingsModel vakatSettingsModel = _vaktovi[vakatIndex];
              bool dzumaSpecial = _vaktijaSettings.dzumaSpecial ?? false;
              if (vakatIndex == 2 &&
                  dzumaSpecial &&
                  date.weekday == DateTime.friday) {
                vakatSettingsModel = _vaktovi[6];
                print('posebno za dzumu');
              }
              bool zuhrFixedTime = vakatSettingsModel.fixedTime ?? false;
              bool showAlarm = vakatSettingsModel.alarmShow!;
              bool showNotification = vakatSettingsModel.showNotification!;
              bool deviceSilent = vakatSettingsModel.deviceSilent!;
              var vakatTime = vakatIndex == 2 && zuhrFixedTime
                  ? podneDefaultTime + dstAddonTime
                  : vaktijaData['months'][month]['days'][day]['vakat']
                          [vakatIndex] +
                      differences[currentCity]['months'][month]['vakat']
                          [vakatIndex] +
                      dstAddonTime;
              String vakatTimeHHMM = secondsToHHMM(vakatTime);
              DateTime vakatDateTime = DateTime.parse(
                '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} $vakatTimeHHMM',
              );

              totalVakats.add(
                  '<b>$vakatTimeHHMM</b> - ${vakatSettingsModel.vakatName}');

              //Alarm schedule
              if (showAlarm && newAlarms.length < totalAlarms) {
                int id = ((indexDana + 1) * 10) + (vakatIndex + 1);
                int alarmOffset = vakatSettingsModel.alarmTimeOut!;
                DateTime scheduleDateAlarm = vakatDateTime.subtract(
                  Duration(seconds: alarmOffset),
                );

                if (scheduleDateAlarm.isAfter(DateTime.now())) {
                  AlarmSettings vakatAlarm = vakatAlarmData(
                    id: id,
                    vakatTimeDateTime: vakatDateTime,
                    scheduledDateTime: scheduleDateAlarm,
                    vakatSettingsModel: vakatSettingsModel,
                  );
                  newAlarms.add(vakatAlarm);
                }
              }

              //vakat notification
              if (showNotification) {
                int id = ((indexDana + 1) * 100) + (vakatIndex + 1);
                int notificationOffset =
                    vakatSettingsModel.notificationTimeOut!;
                String vakatNameFull = vakatSettingsModel.vakatName;
                String title =
                    '$vakatNameFull nastupa za ${(notificationOffset / 60).toInt()} minuta';

                String body =
                    '${gradovi[currentCity]} | ${vakatSettingsModel.vakatName}: $vakatTimeHHMM';
                DateTime scheduleDateTime = vakatDateTime.subtract(
                  Duration(seconds: notificationOffset),
                );

                //TODO forTesting
                // scheduleDateTime = DateTime.now()
                //     .add(Duration(milliseconds: 10000 * (vakatIndex + 3)));
                // print('notifikacija schedule $scheduleDateTime');
                // notificationOffset = 5;

                if (scheduleDateTime.isAfter(DateTime.now())) {
                  ModelNotificationItem notificationItem =
                      buildNotificationVakat(
                    id: id,
                    title: title,
                    body: body,
                    vakatDateTime: vakatDateTime,
                    scheduleDateTime: scheduleDateTime,
                    timeoutAfterMS: notificationOffset * 1000,
                  );
                  if (notificationItemsVakat.length <
                      _totalVakatNotifications) {
                    notificationItemsVakat.add(notificationItem);
                  }
                }
              }

              //vakatTimer
              if (_vaktijaSettings.permanentVaktija! &&
                  vakatDateTime.isAfter(DateTime.now())) {
                if (permanentNotifications.length <
                    _totalVakatNotifications) {
                  int id = ((indexDana + 1) * 1000) + (vakatIndex + 1);
                  permanentNotifications.add(
                    PermanentNotificationDataItem(
                      id: id,
                      vakatIndex: vakatIndex,
                      title: vakatSettingsModel.shortName,
                      titleFull: vakatSettingsModel.fullName,
                      vakatTimeHHMM: vakatTimeHHMM,
                      vakatDateTime: vakatDateTime,
                      bodyId: indexDana,
                    ),
                  );
                }
              }

              //DND mode schedule settings - for Android only
              if (deviceSilent && Platform.isAndroid) {
                int timeOut = vakatSettingsModel.deviceSilentTime!;
                DateTime date = vakatDateTime;

                if (vakatSettingsModel.silentBefore!) {
                  date = vakatDateTime.subtract(
                    Duration(
                      seconds: timeOut,
                    ),
                  );
                }
                DateTime timeOutDate = date.add(Duration(seconds: timeOut));

                //TODO forTesting
                // date = DateTime.now().add(Duration(
                //     seconds: ((indexDana + 1) + (vakatIndex + 1)) * 45));
                // timeOutDate = date.add(Duration(seconds: 30));
                // print('iskljuci $date --- ukljuci $timeOutDate');
                print(
                    '${vakatSettingsModel.fullName} -- ${timeOut ~/ 60} min\n$date -> $timeOutDate');
                DeviceSilentDataItem deviceSilentDataItem =
                    DeviceSilentDataItem(
                  id: ((indexDana + 1) * 100) + (vakatIndex + 1),
                  date: date,
                  timeOutDate: timeOutDate,
                );

                if (date.isAfter(DateTime.now()) ||
                    timeOutDate.isAfter(DateTime.now())) {
                  if (notificationItemsVakat.length <
                      _totalVakatNotifications) {
                    deviceSilentItems.add(deviceSilentDataItem);
                  }
                }
              }
            }

            bodyData.add(
              totalVakats.join('<br>'),
            );
          }

          //start vakat timer & device silent - Android only
          if (Platform.isAndroid) {
            if (permanentNotifications.isNotEmpty) {
              for (int i = 0; i < permanentNotifications.length - 1; i++) {
                bool isFirst = i == 0;
                int index = i;

                if (!isFirst) {
                  index = i - 1;
                }
                PermanentNotificationDataItem item =
                    permanentNotifications[index];
                PermanentNotificationDataItem itemNext =
                    permanentNotifications[index + 1];

                String title = item.title;
                String titleFull = item.titleFull;
                String titleNext = itemNext.title;
                String timeNext = itemNext.vakatTimeHHMM;
                String bodyContent = '';
                //bool isFirst = i == 0;
                if (isFirst) {
                  if (item.vakatIndex == 0) {
                    titleFull = 'Jacija-namaz';
                  } else {
                    titleFull = vaktovi[item.vakatIndex - 1].fullName;
                  }
                  titleNext = item.title;
                  timeNext = item.vakatTimeHHMM;
                }
                DateTime scheduleDateTime = item.vakatDateTime;
                int timeoutAfterMS = 10000;

                if (isFirst) {
                  timeoutAfterMS = item.vakatDateTime
                      .difference(DateTime.now())
                      .inMilliseconds;
                } else {
                  timeoutAfterMS = itemNext.vakatDateTime
                      .difference(item.vakatDateTime)
                      .inMilliseconds;
                }

                //if(i>0){
                // String timeOutHHMM = secondsToHHMM(timeoutAfterMS~/1000);
                // print('$titleFull -- $titleNext');
                // print('${item.vakatTimeHHMM} -- $timeOutHHMM -- $timeNext');
                //}

                if (titleFull.contains('sunca')) {
                  titleFull = 'Duha-namaz';
                }

                if (_vaktijaSettings.permanentVaktijaDailyVakats ?? true) {
                  bodyContent = '<br>${bodyData[item.bodyId]}';
                }

                ModelNotificationItem notificationItem = buildNotificationTimer(
                  id: isFirst ? FixedNotificationId.firstPermanenet : item.id,
                  body: '🤲&nbsp;&nbsp;<b>$titleFull</b>&nbsp;&nbsp;&nbsp;'
                      '&nbsp;&nbsp;&nbsp;➡️&nbsp;&nbsp;'
                      '$titleNext: <b>$timeNext</b>$bodyContent',
                  vakatDateTime: item.vakatDateTime,
                  vakatDateTimeNext: isFirst ? null : itemNext.vakatDateTime,
                  isFirst: isFirst,
                  timeoutAfterMS: timeoutAfterMS,
                );
                notificationItemsVakat.add(notificationItem);
                //for awesome notification display
                // if (i == 0) {
                //   await showNotificationAwesome(
                //       notificationContent:
                //           notificationItem.notificationContent);
                // } else {
                //   await showNotificationScheduleAwesome(
                //     scheduleDate: item.vakatDateTime,
                //     notificationContent: notificationItem.notificationContent,
                //   );
                // }
              }
            }
            if (deviceSilentItems.isNotEmpty) {
              for (int i = 0; i < deviceSilentItems.length; i++) {
                DeviceSilentDataItem item = deviceSilentItems[i];

                setDeviceSilentTask(
                  type: 'silence',
                  index: i,
                  date: item.date,
                );

                setDeviceSilentTask(
                  type: 'restoreDevice',
                  index: i,
                  date: item.timeOutDate,
                );
              }
            }
          }

          //schedule notifications
          for (ModelNotificationItem item in notificationItemsVakat) {
            NotificationService().showNotification(
              notificationItem: item,
            );
          }

          //scheduleAlarm
          for (AlarmSettings alarmSettings in newAlarms) {
            if (Platform.isAndroid) {
              bool alarmPermission =
                  await checkAndroidScheduleExactAlarmPermission();
              if (alarmPermission) {
                await Alarm.set(
                  alarmSettings: alarmSettings,
                );
              }
            } else {
              await Alarm.set(
                alarmSettings: alarmSettings,
              );
            }
          }
        }
        removeSnackbarCurrent();
        showSnackbarMessage(
          message: 'Notifikacije podešene!',
          duration: _snackDuration,
          // margin: _snackbarMargin(context),
          // behavior: SnackBarBehavior.floating,
        );
      },
    );
  }

  void setDeviceSilentTask({
    required String type,
    required int index,
    required DateTime date,
  }) {
    if (date.isAfter(DateTime.now())) {
      String uniqueName = 'dnd-set-$type-$index';
      String taskName = 'dnd-set-task-$type-$index';
      int seconds = date.difference(DateTime.now()).inSeconds;
      Duration taskDelay = Duration(seconds: seconds);
      // String twoDigits(int n) => n.toString().padLeft(2, '0');
      Workmanager().registerOneOffTask(
        uniqueName,
        taskName,
        initialDelay: taskDelay,
        inputData: {
          'type': type,
          'index': index,
          'time': '${twoDigits(date.hour)}:${twoDigits(date.minute)}',
          'timeOut': seconds ~/ 60
        },
      );
      //print('task $type - $date set');
    }
  }
}
