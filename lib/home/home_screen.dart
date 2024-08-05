import 'dart:async';
import 'dart:io';

import 'package:alarm/alarm.dart';
import 'package:auto_start_flutter/auto_start_flutter.dart';
//import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:disable_battery_optimization/disable_battery_optimization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sound_mode/permission_handler.dart';
import 'package:vaktijaba_fl/components/alarm_dialogue.dart';
import 'package:vaktijaba_fl/data/app_data.dart';
import 'package:vaktijaba_fl/data/data.dart';
import 'package:vaktijaba_fl/function/show_full_screen.dart';
import 'package:vaktijaba_fl/home/battery_dialogue.dart';
import 'package:vaktijaba_fl/home/home_tabs/tab_calendar.dart';
import 'package:vaktijaba_fl/home/home_tabs/tab_kibla/tab_kibla.dart';
import 'package:vaktijaba_fl/home/home_tabs/tab_settings.dart';
import 'package:vaktijaba_fl/home/home_tabs/tab_vaktija.dart';
import 'package:vaktijaba_fl/services/calendar_state_provider.dart';
import 'package:vaktijaba_fl/services/notification_service.dart';
import 'package:vaktijaba_fl/services/vaktija_state_provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  static StreamSubscription<AlarmSettings>? subscription;
  late TabController _tabController;
  int currentTab = 0;
  bool isRinging = false;
  bool rescheduleComplete = false;
  DateTime startDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (Alarm.android) {
      checkAndroidNotificationPermission();
      checkAndroidScheduleExactAlarmPermissionInit();
    }
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0)
      ..addListener(() {
        setState(() {
          currentTab = _tabController.index;
        });
        setSelectedDate(context, DateTime.now());
      });
    //requestNotificationPermissions();
    subscription ??= Alarm.ringStream.stream.listen(handleAlarm);
    // handleLocalNotification();
    checkBatteryOptimisation();
    initLocalNotifications();
    if (Platform.isAndroid) {
      initAutoStart();
    }
    //loadNotificationsSchedule();
  }

  Future<void> initAutoStart() async {
    try {
      //check auto-start availability.
      var test = await (isAutoStartAvailable);
      print(test);
      //if available then navigate to auto-start setting page.
      if (test ?? false) await getAutoStartPermission();
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;
  }

  initLocalNotifications() async {
    await NotificationService().init(handleNotification: runScheduleTask);
    await NotificationService().requestPermissions();
    loadNotificationsSchedule();
  }

  checkBatteryOptimisation() async {
    if (Platform.isAndroid) {
      SharedPreferences sp = await SharedPreferences.getInstance();
      bool hideBatteryDialogue =
          sp.getBool(SpKeys.initHideBatteryDialogue) ?? false;
      if (hideBatteryDialogue) {
        return;
      }

      bool batteryOptimisationDisabled =
          (await DisableBatteryOptimization.isBatteryOptimizationDisabled)!;
      bool doNotDisturbPermission =
          await PermissionHandler.permissionsGranted ?? false;
      if (!batteryOptimisationDisabled || !doNotDisturbPermission) {
        showFullscreen(
          context: context,
          child: BatteryDialogue(
            runSchedule: runScheduleTask,
            hideBatteryDialogue: hideBatteryDialogue,
          ),
          dismissible: false,
        );
      }
    }
  }

  Future<void> handleAlarm(AlarmSettings alarm) async {
    isRinging = await Alarm.isRinging(alarm.id);
    if (isRinging) {
      Future.delayed(Duration(milliseconds: 20), () {
        showFullscreen(
          context: context,
          child: AlarmDialogue(
            alarmSettings: alarm,
            runScheduleTask: () {
              isRinging = false;
              runScheduleTask();
            },
          ),
          bgOpacity: 0.95,
          dismissible: false,
        );
      });
    }
  }

  loadNotificationsSchedule() async {
    Future.delayed(
      const Duration(milliseconds: 100),
      () {
        if (!isRinging) {
          runScheduleTask();
        }
      },
    );
  }

  Future<void> checkAndroidNotificationPermission() async {
    final status = await Permission.notification.status;
    if (status.isDenied) {
      alarmPrint('Requesting notification permission...');
      final res = await Permission.notification.request();
      alarmPrint(
        'Notification permission ${res.isGranted ? '' : 'not '}granted',
      );
    }
  }

  Future<void> checkAndroidScheduleExactAlarmPermissionInit() async {
    final status = await Permission.scheduleExactAlarm.status;
    alarmPrint('Schedule exact alarm permission: $status.');
    if (status.isDenied) {
      alarmPrint('Requesting schedule exact alarm permission...');
      final res = await Permission.scheduleExactAlarm.request();
      alarmPrint(
        'Schedule exact alarm permission ${res.isGranted ? '' : 'not'} granted',
      );
    }
  }

  runScheduleTask() async {
    Provider.of<StateProviderVaktija>(context, listen: false).scheduleVakat(
      delay: true,
    );
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        startDate = DateTime.now();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Color iconColor = Theme.of(context).indicatorColor;
    List tabs = [
      HomeTabVaktija(
          dateTimeStart: startDate, runScheduleTask: runScheduleTask),
      const HomeTabCalendar(),
      const HomeTabKibla(),
      const HomeTabSettings()
    ];
    return Scaffold(
      /// backgroundColor: isDarkModeOn ? Colors.black : Colors.white,
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: SafeArea(
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: List.generate(tabs.length, (index) => tabs[index]),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: TabBar(
          controller: _tabController,
          unselectedLabelColor: iconColor.withOpacity(0.3),
          labelColor: iconColor,
          indicatorColor: Colors.transparent,
          tabs: List.generate(
            tabIcons.length,
            (index) => Tab(
              child: Image.asset(
                tabIcons[index],
                height: 24.0,
                color: currentTab == index
                    ? iconColor
                    : iconColor.withOpacity(0.3),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
