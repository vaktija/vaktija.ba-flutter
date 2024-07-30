// import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
// import 'package:sound_mode/sound_mode.dart';
// import 'package:sound_mode/utils/ringer_mode_statuses.dart';
//
// void _scheduleSilentMode() {
//   final DateTime now = DateTime.now();
//   final DateTime silentTime = DateTime(now.year, now.month, now.day, 13, 0);
//   final DateTime normalTime = DateTime(now.year, now.month, now.day, 14, 0);
//
//   Alarm.set(
//     alarmDateTime: silentTime,
//     assetAudio: 'assets/silent_alarm.mp3',
//     loopAudio: false,
//     notificationTitle: 'Silent Mode',
//     notificationBody: 'Device will be set to silent mode.',
//     onRing: _setSilentMode,
//   );
//
//   Alarm.set(
//     alarmDateTime: normalTime,
//     assetAudio: 'assets/normal_alarm.mp3',
//     loopAudio: false,
//     notificationTitle: 'Normal Mode',
//     notificationBody: 'Device will be set back to normal mode.',
//     onRing: _setNormalMode,
//   );
// }
//
// Future<void> _setSilentMode() async {
//   await SoundMode.setSoundMode(RingerModeStatus.silent);
// }
//
// Future<void> _setNormalMode() async {
//   await SoundMode.setSoundMode(RingerModeStatus.normal);
// }