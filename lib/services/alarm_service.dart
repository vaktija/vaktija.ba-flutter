import 'dart:io';

import 'package:alarm/alarm.dart';
import 'package:vaktijaba_fl/components/models/vakat_settings_model.dart';

AlarmSettings vakatAlarmData({
  required int id,
  required DateTime vakatTimeDate,
  required DateTime scheduledDate,
  required VakatSettingsModel vakatSettingsModel,
}) {
  String vakatName = vakatSettingsModel.fullName;
  String vakatNameShort = vakatSettingsModel.vakatName;
  String title = vakatName;
  //'$vakatName${vakatName.contains('ora') || vakatName.contains('laza') ? '' : '-namaz!'}';

  String body =
      '$vakatName nastupa za ${(vakatSettingsModel.alarmTimeOut! / 60).toInt()} minuta!';

  int alarmOffset = vakatSettingsModel.alarmTimeOut!;

  DateTime date = vakatTimeDate.subtract(
    Duration(seconds: alarmOffset),
  );

  //TODO for testing
  //date = DateTime.now().add(Duration(seconds: 20));

  return AlarmSettings(
    id: id,
    dateTime: date,
    assetAudioPath: 'assets/ezan/alarm.mp3',
    //ezan_selim_hosi.mp3',
    //ezaniBiH[0],
    loopAudio: true,
    vibrate: vakatSettingsModel.alarmVibrate!,
    volume: 0.8,
    fadeDuration: 3.0,
    notificationTitle: title,
    notificationBody: body,
    enableNotificationOnKill: Platform.isIOS,
    androidFullScreenIntent: false
  );
}