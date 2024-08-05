import 'package:vaktijaba_fl/components/models/vakat_ezan_model.dart';

class SpKeys {
  static String initThemeMode = 'themeModeInit';
  static String initFontSizeMultiplier = 'fontMultiplier';
  static String vaktoviSettingsKey = 'vaktoviSettingsSave';
  static String vaktijaSettingsString = 'vaktijaSettignsSave';
  static String prefsVaktijaSaveDataKey = 'vaktijaData';
  static String initShowSettingsHint = 'vakatSettingHint210';
  static String initHideBatteryDialogue = 'dndDialogue211';
}

class AppSettingsData {
  static String APP_VERSION = '2.1.0';
  static String appBGkillIOStitle = 'Alarmi se možda neće oglasiti!';
  static String appBGkillIOSbody =
      'Ponovo pokrenite aplikaciju i ostavite je aktivnu u pozadini.';
  static bool isAndroid14plus = false;
}

class Athans {
  static String ezanPath = 'assets/ezan';
  static EzanModel defaultAthan = EzanModel(
    muazzin: 'Zadano',
    path: '$ezanPath/alarm.mp3',
    id: 1,
  );
  static EzanModel sarajevo = EzanModel(
    muazzin: 'Sarajevo - Careva',
    path: '$ezanPath/sarajevo.mp3',
    id: 2,
  );
  static EzanModel istanbul = EzanModel(
    muazzin: 'Istanbul - Aja Sofia',
    path: '$ezanPath/istanbul.mp3',
    id: 3,
  );
  static EzanModel quds = EzanModel(
    muazzin: 'Kuds/Jerusalem - Aksa',
    path: '$ezanPath/quds.mp3',
    id: 4,
  );
  static EzanModel makkah = EzanModel(
    muazzin: 'Meka - Harem',
    path: '$ezanPath/makkah.mp3',
    id: 5,
  );
  static EzanModel madinah = EzanModel(
    muazzin: 'Medina - Poslanikova a.s. džamija',
    path: '$ezanPath/madinah.mp3',
    id: 6,
  );
  static EzanModel cairo = EzanModel(
    muazzin: 'Kairo',
    path: '$ezanPath/kairo.mp3',
    id: 7,
  );

  static List<EzanModel> athans = [
    defaultAthan,
    sarajevo,
    istanbul,
    quds,
    makkah,
    madinah,
    cairo,
  ];
}
