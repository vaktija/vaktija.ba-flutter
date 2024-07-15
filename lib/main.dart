import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaktijaba_fl/app_theme/theme_dark.dart';
import 'package:vaktijaba_fl/app_theme/theme_light.dart';
import 'package:vaktijaba_fl/app_theme/theme_state.dart';
import 'package:vaktijaba_fl/data/app_data.dart';
import 'package:vaktijaba_fl/data/data.dart';
import 'package:vaktijaba_fl/home/home_screen.dart';
import 'package:vaktijaba_fl/services/calendar_state_provider.dart';
import 'package:vaktijaba_fl/services/notification_service.dart';
import 'package:vaktijaba_fl/services/state_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initVaktijaData();
  await presetValues();
  // await NotificationService().init();
  await NotificationService().requestPermissions();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const VaktijaApp());
}

presetValues() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  SharedPreferences sp = await SharedPreferences.getInstance();
  themeModeInit = sp.getInt(SpKeys.initThemeMode) ?? 1;
  AppSettings.APP_VERSION = packageInfo.version.toString();
  //print(AppSettings.APP_VERSION);
  var vaktijaSaveCache = sp.getString(SpKeys.prefsVaktijaSaveDataKey) ?? null;
  if (vaktijaSaveCache != null) {
    var vaktijaSaveData = jsonDecode(vaktijaSaveCache);
    //print(vaktijaSaveData);
    currentLocationInit = vaktijaSaveData[0];
    vaktoviNotifikacijeTimeInit = vaktijaSaveData[1];
    vaktoviNotifikacijaSoundInit = vaktijaSaveData[2];
    vaktoviAlarmTimeInit = vaktijaSaveData[3];
    vaktoviAlarmSoundInit = vaktijaSaveData[4];
    podneStvarnoVrijemeInit = vaktijaSaveData[5];
    vaktijaDzumaVrijemeInit = vaktijaSaveData[6];
    if (vaktijaSaveData.length == 8) {
      showDailyVaktijaInit = vaktijaSaveData[7];
    }
  }
}

initVaktijaData() async {
  var vaktijaDataBase =
      json.decode(await rootBundle.loadString('assets/vaktija/vaktija.json'));
  gradovi = vaktijaDataBase['locations'];
  differences = vaktijaDataBase['differences'];
  vaktijaData = vaktijaDataBase['vaktija'];
}

class VaktijaApp extends StatelessWidget {
  const VaktijaApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StateAppTheme()),
        ChangeNotifierProvider(
          create: (_) => VaktijaDateTimeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CalendarPickerStateProvider(),
        ),
      ],
      child: ChangeNotifierProvider(
        create: (context) => StateAppTheme(),
        builder: (context, _) {
          StateAppTheme themeStateProvider =
              Provider.of<StateAppTheme>(context);
          int themeMode = themeStateProvider.themeMode;
          double fontSizeMultiplier = themeStateProvider.fontSizeMultiplier;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: appThemeLight(fontSizeMultiplier: fontSizeMultiplier),
            darkTheme: appThemeDark(fontSizeMultiplier: fontSizeMultiplier),
            themeMode: themeModes[themeMode],
            home: HomeScreen(),
          );
        },
      ),
      // MaterialApp(
      //   debugShowCheckedModeBanner: false,
      //   title: 'Flutter Demo',
      //   theme: ThemeData(
      //     primarySwatch: Colors.green,
      //   ),
      //   home: InitScreen(),
      // ),
    );
  }
}
