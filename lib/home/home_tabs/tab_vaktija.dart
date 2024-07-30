import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaktijaba_fl/components/hijra_date_home.dart';
import 'package:vaktijaba_fl/components/location_field_home.dart';
import 'package:vaktijaba_fl/components/regenerate_notifications.dart';
import 'package:vaktijaba_fl/components/vakat_field.dart';
import 'package:vaktijaba_fl/components/vakat_settings_hint.dart';
import 'package:vaktijaba_fl/data/constants.dart';
import 'package:vaktijaba_fl/function/check_same_day.dart';
import 'package:vaktijaba_fl/services/vaktija_state_provider.dart';

class HomeTabVaktija extends StatefulWidget {
  final DateTime dateTimeStart;
  final Function() runScheduleTask;

  const HomeTabVaktija({
    Key? key,
    required this.dateTimeStart,
    required this.runScheduleTask,
  }) : super(key: key);

  @override
  _HomeTabVaktijaState createState() => _HomeTabVaktijaState();
}

class _HomeTabVaktijaState extends State<HomeTabVaktija> {
  Timer timer = Timer(Duration(seconds: 0), () {});

  @override
  void initState() {
    super.initState();
    startRefreshTimer();
  }

  startRefreshTimer() {
    if (timer.isActive) {
      timer.cancel();
    }
    timer = Timer(Duration(seconds: 1), () {
      if (!isSameDay(widget.dateTimeStart, DateTime.now())) {
        widget.runScheduleTask();
      }
      setState(() {});
      startRefreshTimer();
    });
  }

  @override
  void dispose() {
    if (timer.isActive) {
      timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StateProviderVaktija stateProviderVaktija =
        Provider.of<StateProviderVaktija>(context);
    bool showVakatSettingsHint =
        stateProviderVaktija.vaktijaSettings.vakatFieldHint!;
    //List<VakatSettingsModel> vaktovi = stateProviderVaktija.vaktovi;
    return Scaffold(
      //backgroundColor: isDarkModeOn ? Colors.black : Colors.white,
      extendBodyBehindAppBar: true,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Platform.isAndroid ? RegenerateNotifications() : gap16,
              const LocationFieldHome(),
              gap4,
              const HijraDateHome(),
              gap32,
              if (stateProviderVaktija.showHintField) ...[
                const VakatSettingsHint(),
                gap16,
              ],
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  6, //vaktovi.length,
                  (index) => VakatField(
                    index: index,
                  ),
                ),
              ),
              gap16,
            ],
          ),
        ),
      ),
    );
  }
}
