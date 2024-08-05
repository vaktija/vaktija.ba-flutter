import 'dart:convert';
import 'dart:io';

import 'package:alarm/alarm.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sound_mode/sound_mode.dart';
import 'package:sound_mode/utils/ringer_mode_statuses.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:vaktijaba_fl/app_theme/theme_dark.dart';
import 'package:vaktijaba_fl/app_theme/theme_light.dart';
import 'package:vaktijaba_fl/app_theme/theme_state.dart';
import 'package:vaktijaba_fl/components/models/vakat_settings_model.dart';
import 'package:vaktijaba_fl/components/models/vaktija_settings_model.dart';
import 'package:vaktijaba_fl/data/app_data.dart';
import 'package:vaktijaba_fl/data/data.dart';
import 'package:vaktijaba_fl/home/home_screen.dart';
import 'package:vaktijaba_fl/services/calendar_state_provider.dart';
import 'package:vaktijaba_fl/services/navigation_service.dart';
import 'package:vaktijaba_fl/services/vaktija_state_provider.dart';
import 'package:vaktijaba_fl/services/work_manager_service.dart';
import 'package:workmanager/workmanager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initVaktijaData();
  await presetValues();
  await Alarm.init();
  await Alarm.setNotificationOnAppKillContent(
    AppSettingsData.appBGkillIOStitle,
    AppSettingsData.appBGkillIOSbody,
  );
  tz.initializeTimeZones();
  //await _configureLocalTimeZone();
  // await NotificationService().init(
  //     handleNotifcation: (){}// runScheduleTask
  // );
  //await NotificationService().requestPermissions();
  //await NotificationController.initializeLocalNotifications();
  //await NotificationController.initializeIsolateReceivePort();
  if (Platform.isAndroid) {
    Workmanager().initialize(
      workmanagerCallbackDispatcher,
      isInDebugMode: false,
    );
  }
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    VaktijaApp(),
  );
}

// Future<void> _configureLocalTimeZone() async {
//   tz.initializeTimeZones();
//   final String? timeZoneName = await FlutterTimezone.getLocalTimezone();
//   tz.setLocalLocation(tz.getLocation(timeZoneName!));
// }

presetValues() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  SharedPreferences sp = await SharedPreferences.getInstance();
  if (Platform.isAndroid) {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    final String version = androidInfo.version.release;
    if (int.parse(version) >= 14) {
      AppSettingsData.isAndroid14plus = true;
    }
  }

  themeModeInit = sp.getInt(SpKeys.initThemeMode) ?? 1;
  AppSettingsData.APP_VERSION = packageInfo.version.toString();
  String vaktoviSave = sp.getString(SpKeys.vaktoviSettingsKey) ?? '';
  String vaktijaSave = sp.getString(SpKeys.vaktijaSettingsString) ?? '';
  showHintFieldInit = sp.getBool(SpKeys.initShowSettingsHint) ?? true;
  fontSizeIncreaseInit = sp.getDouble(SpKeys.initFontSizeMultiplier) ?? 0.0;
  if (vaktoviSave.isNotEmpty) {
    try {
      List vaktoviSaveData = jsonDecode(vaktoviSave);
      vaktoviInit.clear();
      for (var json in vaktoviSaveData) {
        VakatSettingsModel vakatSettingsModel =
            VakatSettingsModel.fromJson(json);
        vaktoviInit.add(vakatSettingsModel);
      }
    } catch (e) {
      print(e);
    }
  }
  if (vaktijaSave.isNotEmpty) {
    try {
      vaktijaSettingsInit = VaktijaSettingsModel.fromJson(
        jsonDecode(
          vaktijaSave,
        ),
      );
    } catch (e) {
      print(e);
    }
  }
}

Future<void> setSilentMode() async {
  await SoundMode.setSoundMode(RingerModeStatus.silent);
}

Future<void> setNormalMode() async {
  await SoundMode.setSoundMode(RingerModeStatus.normal);
}

initVaktijaData() async {
  var vaktijaDataBase =
      json.decode(await rootBundle.loadString('assets/vaktija/vaktija.json'));
  gradovi = vaktijaDataBase['locations'];
  differences = vaktijaDataBase['differences'];
  vaktijaData = vaktijaDataBase['vaktija'];
}

class VaktijaApp extends StatelessWidget {
  final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  VaktijaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StateAppTheme()),
        ChangeNotifierProvider(
          create: (_) => StateProviderVaktija(),
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
            // initialRoute: '/',
            // routes: <String, WidgetBuilder>{
            // //  HomeScreen.routeName: (_) => HomeScreen(),
            // },
            //scaffoldMessengerKey: rootScaffoldMessengerKey,
            debugShowCheckedModeBanner: false,
            navigatorKey: NavigationService.navigatorKey,
            theme: appThemeLight(fontSizeMultiplier: fontSizeMultiplier),
            darkTheme: appThemeDark(fontSizeMultiplier: fontSizeMultiplier),
            themeMode: themeModes[themeMode],
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}
