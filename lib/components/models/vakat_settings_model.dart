import 'package:vaktijaba_fl/components/models/vakat_ezan_model.dart';

class VakatSettingsModel {
  String vakatName;
  String fullName;
  String shortName;
  int vakatIndex;

  //Notification settings
  bool? showNotification;
  bool? notificationVibrate;
  int? notificationTimeOut;

  //Alarm settings
  bool? alarmShow;
  bool? alarmVibrate;
  int? alarmTimeOut;

  //Do not disturb settings
  bool? deviceSilent;
  bool? silentBefore;
  int? deviceSilentTime;
  bool? fixedTime;

  EzanModel? ezan;

  VakatSettingsModel({
    required this.vakatName,
    required this.vakatIndex,
    required this.fullName,
    required this.shortName,
    this.showNotification = true,
    this.alarmShow = false,
    this.notificationVibrate = true,
    this.alarmVibrate = false,
    this.deviceSilent = false,
    this.silentBefore = false,
    this.notificationTimeOut = 900,
    this.alarmTimeOut = 1800,
    this.deviceSilentTime = 1800,
    this.ezan,
    this.fixedTime = false,
  });

  factory VakatSettingsModel.fromJson(Map<String, dynamic> json) {
    return VakatSettingsModel(
      fullName: json['fullName'],
      vakatName: json['vakatName'],
      shortName: json['shortName'],
      vakatIndex: json['vakatIndex'],
      showNotification: json['showNotification'],
      alarmShow: json['showAlarm'],
      notificationVibrate: json['notificationVibrate'],
      alarmVibrate: json['alarmVibrate'],
      deviceSilent: json['deviceSilent'],
      silentBefore: json['silentBefore'],
      notificationTimeOut: json['notificationTimeOut'],
      alarmTimeOut: json['alarmTime'],
      deviceSilentTime: json['deviceSilentTime'],
      ezan: json['ezan'] != null ? EzanModel.fromJson(json['ezan']) : null,
      fixedTime: json['fixedTime']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'vakatName': vakatName,
      'shortName': shortName,
      'vakatIndex': vakatIndex,
      'showNotification': showNotification,
      'showAlarm': alarmShow,
      'notificationVibrate': notificationVibrate,
      'alarmVibrate': alarmVibrate,
      'deviceSilent': deviceSilent,
      'silentBefore': silentBefore,
      'notificationTimeOut': notificationTimeOut,
      'alarmTime': alarmTimeOut,
      'deviceSilentTime': deviceSilentTime,
      'ezan': ezan?.toJson(),
      'fixedTime': fixedTime
    };
  }
}
