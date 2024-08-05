import 'dart:io';

import 'package:alarm/alarm.dart';
import 'package:vaktijaba_fl/components/models/vakat_ezan_model.dart';
import 'package:vaktijaba_fl/components/models/vakat_settings_model.dart';
import 'package:vaktijaba_fl/data/app_data.dart';

AlarmSettings vakatAlarmData({
  required int id,
  required DateTime vakatTimeDateTime,
  required DateTime scheduledDateTime,
  required VakatSettingsModel vakatSettingsModel,
}) {
  String vakatName = vakatSettingsModel.fullName;
  //String vakatNameShort = vakatSettingsModel.vakatName;
  String title = vakatName;
  //'$vakatName${vakatName.contains('ora') || vakatName.contains('laza') ? '' : '-namaz!'}';

  String body =
      '$vakatName nastupa za ${(vakatSettingsModel.alarmTimeOut! / 60).toInt()} minuta!';

  DateTime date = scheduledDateTime;

  EzanModel ezanModel = vakatSettingsModel.ezan ?? Athans.defaultAthan;

  //TODO for testing
  // date = DateTime.now().add(
  //   Duration(
  //     seconds: id + 20,
  //   ),
  // );

  return AlarmSettings(
    id: id,
    dateTime: date,
    assetAudioPath: ezanModel.path,
    //'assets/ezan/alarm.mp3',
    //ezaniBiH[0],
    loopAudio: true,
    vibrate: vakatSettingsModel.alarmVibrate!,
    volume: 0.8,
    fadeDuration: 3.0,
    notificationTitle: title,
    notificationBody: body,
    enableNotificationOnKill: Platform.isIOS,
    androidFullScreenIntent: true,
  );
}
