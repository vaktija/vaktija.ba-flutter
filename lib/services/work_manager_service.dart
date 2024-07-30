//import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:sound_mode/sound_mode.dart';
import 'package:sound_mode/utils/ringer_mode_statuses.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void workmanagerCallbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    var type = inputData!['type'];

    if (type == 'silence') {
      makeDeviceSilent(inputData);
    }

    if (type == 'restoreDevice') {
      restoreDeviceSilent();
    }

    return Future.value(true);
  });
}

void restoreDeviceSilent() async {
  await SoundMode.setSoundMode(RingerModeStatus.normal);
}

void makeDeviceSilent(Map<String, dynamic> inputData) async {
  await SoundMode.setSoundMode(RingerModeStatus.silent);
}
