import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:vaktijaba_fl/app_theme/theme_data.dart';
import 'package:vaktijaba_fl/components/models/vakat_settings_model.dart';
import 'package:vaktijaba_fl/components/models/vaktija_settings_model.dart';
import 'package:vaktijaba_fl/components/text_styles/text_body_small.dart';
import 'package:vaktijaba_fl/components/text_styles/text_headline_small.dart';
import 'package:vaktijaba_fl/components/text_styles/vakat_time_field.dart';
import 'package:vaktijaba_fl/data/constants.dart';
import 'package:vaktijaba_fl/data/data.dart';
import 'package:vaktijaba_fl/function/check_dst.dart';
import 'package:vaktijaba_fl/function/get_next_vakat.dart';
import 'package:vaktijaba_fl/function/open_new_screen.dart';
import 'package:vaktijaba_fl/vakat_settings_screen/vakat_settings_screen.dart';

import '../function/sec_2_hhmm.dart';
import '../function/vaktija_time_left.dart';
import '../services/vaktija_state_provider.dart';

class VakatField extends StatefulWidget {
  final index;

  const VakatField({Key? key, this.index}) : super(key: key);

  @override
  _VakatFieldState createState() => _VakatFieldState();
}

class _VakatFieldState extends State<VakatField> {
  @override
  Widget build(BuildContext context) {
    double spacing = defPadding;
    double infoIconSize = 14.0;
    Color disabledColor = Theme.of(context).disabledColor;
    Color disabledBgColor = Theme.of(context)
        .colorScheme
        .secondaryContainer;
    EdgeInsets actionPadding = const EdgeInsets.symmetric(
        horizontal: defPadding, vertical: defPadding);
    DateTime now = DateTime.now();
    int podneDefaultTime = 43200;
    bool dzuma = now.weekday == 5;
    int dan = now.day - 1;
    int mjesec = now.month - 1;
    int currentTime = (now.hour * 3600) + (now.minute * 60) + now.second;
    int dstAddonTime = checkDST(now) ? 3600 : 0;

    StateProviderVaktija stateProviderVaktija =
        Provider.of<StateProviderVaktija>(context);

    VaktijaSettingsModel vaktijaSettingsModel =
        stateProviderVaktija.vaktijaSettings;

    VakatSettingsModel vakatSettingsModel =
        stateProviderVaktija.vaktovi[widget.index];

    bool specialDzuma = stateProviderVaktija.vaktijaSettings.dzumaSpecial!;

    if (widget.index == 2 && dzuma && specialDzuma) {
      vakatSettingsModel = stateProviderVaktija.vaktovi[6];
    }

    bool hintActive = stateProviderVaktija.showHintField;

    bool podneVrijemeFixed = vakatSettingsModel.fixedTime ?? false;

    int grad = vaktijaSettingsModel.currentCity!;

    int nextVakatIndex = getNextVakat(
      currentTime,
      grad,
      mjesec,
      dan,
      dstAddonTime,
    );

    bool nextVakat = nextVakatIndex == widget.index ? true : false;
    bool vakatNotification = vakatSettingsModel.showNotification!;
    bool vakatAlarm = vakatSettingsModel.alarmShow!;
    bool vakatDeviceSilent = vakatSettingsModel.deviceSilent!;
    int vakatTime = widget.index == 2 && podneVrijemeFixed
        ? podneDefaultTime + dstAddonTime
        : vaktijaData['months'][mjesec]['days'][dan]['vakat'][widget.index] +
            differences[grad]['months'][mjesec]['vakat'][widget.index] +
            dstAddonTime;

    List<SlidableAction> actions = [
      SlidableAction(
        autoClose: true,
        label: 'Postavke',
        icon: Icons.settings_outlined,
        spacing: spacing,
        foregroundColor: Colors.white,
        backgroundColor: AppColors.colorGold,
        //Color(0xFF90CAF9),//AppColors.colorGreyLight,
        padding: actionPadding,
        onPressed: (context) {
          if (hintActive) {
            hideHint(context);
          }
          openNewScreen(
              context,
              VakatSettingsScreen(
                index: widget.index,
              ),
              'vakat postavke');
        },
      ),
      SlidableAction(
        autoClose: false,
        label: 'Obavijest',
        icon: vakatNotification
            ? Icons.notifications_active_outlined
            : Icons.notifications_off_outlined,
        spacing: spacing,
        foregroundColor: vakatNotification ? Colors.white : disabledColor,
        backgroundColor: vakatNotification
            ? AppColors.colorNotificationActive
            : disabledBgColor,
        padding: actionPadding,
        onPressed: (context) {
          if (hintActive) {
            hideHint(context);
          }
          vakatSettingsModel.showNotification = !vakatNotification;
          updateVakatSettings(
              context, vakatSettingsModel, vakatSettingsModel.vakatIndex);
        },
      ),
      SlidableAction(
        autoClose: false,
        label: 'Alarm',
        icon: vakatAlarm ? Icons.alarm_on_outlined : Icons.alarm_off_outlined,
        spacing: spacing,
        foregroundColor: vakatAlarm ? Colors.white : disabledColor,
        backgroundColor:
            vakatAlarm ? AppColors.colorAlarmActive : disabledBgColor,
        padding: actionPadding,
        onPressed: (context) {
          if (hintActive) {
            hideHint(context);
          }
          vakatSettingsModel.alarmShow = !vakatAlarm;
          updateVakatSettings(
              context, vakatSettingsModel, vakatSettingsModel.vakatIndex);
        },
      ),
      if (Platform.isAndroid) ...[
        SlidableAction(
          autoClose: false,
          label: 'Utišaj',
          icon: vakatDeviceSilent
              ? Icons.do_disturb_on_outlined
              : Icons.do_disturb_off_outlined,
          spacing: spacing,
          foregroundColor: vakatDeviceSilent ? Colors.white : disabledColor,
          backgroundColor:
              vakatDeviceSilent ? AppColors.colorDNDActive : disabledBgColor,
          padding: actionPadding,
          onPressed: (context) {
            if (hintActive) {
              hideHint(context);
            }
            vakatSettingsModel.deviceSilent = !vakatDeviceSilent;
            updateVakatSettings(
                context, vakatSettingsModel, vakatSettingsModel.vakatIndex);
          },
        ),
      ]
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: defPadding),
      child: SlidableAutoCloseBehavior(
        closeWhenOpened: true,
        closeWhenTapped: true,
        child: Slidable(
          key: Key(widget.index.toString()),
          endActionPane: ActionPane(
            motion: DrawerMotion(),
            extentRatio: actions.length * 0.22,
            children: List.generate(
              actions.length,
              (index) => actions[index],
            ),
          ),
          child: ListTile(
            tileColor: nextVakat
                ? disabledBgColor
                : null,
            contentPadding: EdgeInsets.only(
                left: defaultPadding * (nextVakat ? 4 : 4),
                right: defPadding * 3.5,
                top: nextVakat ? defPadding : 0.0,
                bottom: nextVakat ? defPadding * 1.5 : 0.0),
            title: TextHeadlineSmall(
                text: widget.index == 2 && dzuma
                    ? 'Džuma'
                    : vakatSettingsModel.vakatName,
                color: nextVakat
                    ? AppColors.colorGold
                    : Theme.of(context).textTheme.headlineSmall!.color!
                //.withOpacity(1.0),
                ),
            subtitle: Padding(
              padding: EdgeInsets.only(top: nextVakat ? defPadding / 2 : 0.0),
              child: TextBodySmall(
                text: vaktijaTimeLeft(
                  currentTime,
                  vakatTime,
                  nextVakat,
                ),
                italic: nextVakat ? false : true,
                fontSize: nextVakat ? 20.0 : null,
                fontWeight: nextVakat ? FontWeight.w700 : null,
              ),
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(left: defPadding * 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextVakatTime(
                    text: secondsToHHMM(
                      vakatTime,
                    ),
                    color: nextVakat
                        ? Theme.of(context).textTheme.headlineMedium!.color
                        : null,
                  ),
                  gap8,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        vakatNotification
                            ? Icons.notifications_active_outlined
                            : Icons.notifications_off_outlined,
                        color: vakatNotification
                            ? AppColors.colorNotificationActive
                            : Theme.of(context).disabledColor,
                        size: infoIconSize,
                      ),
                      gap2,
                      Icon(
                        vakatAlarm
                            ? Icons.alarm_on_outlined
                            : Icons.alarm_off_outlined,
                        color: vakatAlarm
                            ? AppColors.colorAlarmActive
                            : Theme.of(context).disabledColor,
                        size: infoIconSize,
                      ),
                      if (Platform.isAndroid) ...[
                        gap2,
                        Icon(
                          vakatDeviceSilent
                              ? Icons.do_disturb_on_outlined
                              : Icons.do_disturb_off_outlined,
                          color: vakatDeviceSilent
                              ? AppColors.colorDNDActive
                              : Theme.of(context).disabledColor,
                          size: infoIconSize,
                        ),
                      ]
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
