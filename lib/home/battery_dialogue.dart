import 'dart:async';

import 'package:android_intent_plus/android_intent.dart';
import 'package:disable_battery_optimization/disable_battery_optimization.dart';
import 'package:flutter/material.dart';
import 'package:sound_mode/permission_handler.dart';
import 'package:vaktijaba_fl/app_theme/theme_data.dart';
import 'package:vaktijaba_fl/components/text_styles/text_body_medium.dart';
import 'package:vaktijaba_fl/components/text_styles/text_body_small.dart';
import 'package:vaktijaba_fl/data/constants.dart';

class BatteryDialogue extends StatefulWidget {
  final Function()? runSchedule;
  const BatteryDialogue({super.key, this.runSchedule});

  @override
  State<BatteryDialogue> createState() => _BatteryDialogueState();
}

class _BatteryDialogueState extends State<BatteryDialogue> {
  bool batteryOptimisationDisabled = false;
  bool batteryOptimisationDisabledManufacturer = false;
  bool doNotDisturbPermission = false;
  Timer _timer = Timer(const Duration(seconds: 0), () {});

  //bool autoStartEnabled = false;

  @override
  void initState() {
    super.initState();
    checkStatus();
  }

  checkStatus() async {
    batteryOptimisationDisabled =
        (await DisableBatteryOptimization.isBatteryOptimizationDisabled)!;
    doNotDisturbPermission =
        await PermissionHandler.permissionsGranted ?? false;
    setState(() {});
    if (_timer.isActive) {
      _timer.cancel();
    }
    _timer = Timer(const Duration(seconds: 1), () {
      checkStatus();
    });
  }

  void openBatteryOptimizationSettings() async {
    const AndroidIntent intent = AndroidIntent(
      action: 'android.settings.IGNORE_BATTERY_OPTIMIZATION_SETTINGS',
    );
    await intent.launch();
  }

  void checkDnB() async {
    await PermissionHandler.openDoNotDisturbSetting();
  }

  String title = 'Da bi aplikacija mogla ispravno raditi u pozadini, '
      'potrebno je deaktivirati optimizaciju baterije za Vaktija.ba aplikaciju.';

  @override
  void dispose() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    if(widget.runSchedule != null){
      widget.runSchedule!();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(defPadding * 3),
        child: Material(
          borderRadius: BorderRadius.circular(defPadding * 2),
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 330.0,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .primaryContainer, //scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(defPadding * 2),
            ),
            padding: const EdgeInsets.only(
              top: defPadding,
              right: defPadding,
              bottom: defPadding * 3,
              left: defPadding * 3,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: [
                    const Expanded(
                      child: TextBodyMedium(
                        text: 'Obavezne dozvole',
                      ),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      icon: Icon(
                        Icons.close_outlined,
                        color: AppColors.colorAction,
                      ),
                      iconSize: defPadding * 3,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                gap4,
                Padding(
                  padding: const EdgeInsets.only(
                    right: defPadding * 2,
                  ),
                  child: TextBodySmall(
                    text: title,
                  ),
                ),
                gap16,
                Padding(
                  padding: const EdgeInsets.only(
                    right: defPadding,
                  ),
                  child: InkWell(
                    onTap: batteryOptimisationDisabled
                        ? null
                        : openBatteryOptimizationSettings,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextBodyMedium(
                          text: batteryOptimisationDisabled
                              ? 'Optimizacija deaktivirana'
                              : 'Postavke optimizacije baterije',
                        ),
                        Icon(
                          batteryOptimisationDisabled
                              ? Icons.check_box_outlined
                              : Icons.arrow_forward,
                          color: batteryOptimisationDisabled
                              ? AppColors.colorSwitchActive
                              : AppColors.colorAction,
                          size: defPadding * 3,
                        ),
                      ],
                    ),
                  ),
                ),
                gap16,
                Padding(
                  padding: const EdgeInsets.only(
                    right: defPadding,
                  ),
                  child: InkWell(
                    onTap: doNotDisturbPermission
                        ? null
                        : checkDnB,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextBodyMedium(
                            text: doNotDisturbPermission
                                ? "Dozvola za 'Do Not Disturb' (DNB)"
                                : "Postavke za 'Do Not Disturb' (DNB)",
                          ),
                        ),
                        gap16,
                        Icon(
                          doNotDisturbPermission
                              ? Icons.check_box_outlined
                              : Icons.arrow_forward,
                          color: doNotDisturbPermission
                              ? AppColors.colorSwitchActive
                              : AppColors.colorAction,
                          size: defPadding * 3,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
