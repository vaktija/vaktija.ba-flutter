import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaktijaba_fl/app_theme/theme_data.dart';
import 'package:vaktijaba_fl/components/divider/horizontal_divider.dart';
import 'package:vaktijaba_fl/components/models/vakat_settings_model.dart';
import 'package:vaktijaba_fl/components/models/vaktija_settings_model.dart';
import 'package:vaktijaba_fl/components/text_styles/text_body_medium.dart';
import 'package:vaktijaba_fl/components/text_styles/text_body_small.dart';
import 'package:vaktijaba_fl/components/toggle_switch.dart';
import 'package:vaktijaba_fl/components/vakat_alarm_field.dart';
import 'package:vaktijaba_fl/components/vakat_device_silent_field.dart';
import 'package:vaktijaba_fl/components/vakat_notification_field.dart';
import 'package:vaktijaba_fl/data/constants.dart';
import 'package:vaktijaba_fl/data/data.dart';
import 'package:vaktijaba_fl/function/open_new_screen.dart';

import '../services/vaktija_state_provider.dart';

class VakatSettingsScreen extends StatelessWidget {
  final index;

  const VakatSettingsScreen({Key? key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //bool isDarkModeOn = isDarkMode(context);
    StateProviderVaktija stateProviderVaktija =
        Provider.of<StateProviderVaktija>(context);
    VaktijaSettingsModel vaktijaSettingsModel =
        stateProviderVaktija.vaktijaSettings;
    VakatSettingsModel vakatSettingsModel = stateProviderVaktija.vaktovi[index];
    bool dzumaSpecial = vaktijaSettingsModel.dzumaSpecial ?? false;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        //elevation: 0,
        //backgroundColor: isDarkModeOn ? Colors.black : Colors.white,
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: TextBodyMedium(
          text:
              '${vakatSettingsModel.vakatName}${index == 2 && !dzumaSpecial ? '/Džuma' : ''}',
          bold: true,
        ),
        iconTheme: IconThemeData(color: AppColors.colorAction),
        actions: [
          if (index == 2 && dzumaSpecial)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding),
              child: TextButton(
                onPressed: () {
                  // setDate();
                  openNewScreen(context, const VakatSettingsScreen(index: 6),
                      'namaska vremena');
                },
                child: TextBodyMedium(
                  text: 'Džuma',
                  color: AppColors.colorAction,
                ),
              ),
            )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            gap16,
            if (index == 2 || index == 6) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defPadding * 3),
                child: Builder(builder: (context) {
                  bool dzumaZuhrFixed = vakatSettingsModel.fixedTime ?? false;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      gap16,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextBodyMedium(
                                  text: index == 2
                                      ? 'Vrijeme Podne-namaza'
                                      : 'Vrijeme Džume-namaza',
                                  bold: false,
                                  //color: colorLightShade,
                                ),
                                gap8,
                                TextBodySmall(
                                  text: dzumaZuhrFixed
                                      ? podneVakatAdet
                                      : podneVakatTakvim,
                                  italic: false,
                                )
                              ],
                            ),
                          ),
                          gap16,
                          ToggleSwitch(
                            toggleState: dzumaZuhrFixed,
                            onTap: () {
                              vakatSettingsModel.fixedTime = !dzumaZuhrFixed;
                              updateVakatSettings(
                                  context, vakatSettingsModel, index);
                            },
                          )
                        ],
                      ),
                    ],
                  );
                }),
              ),
              const DividerCustomHorizontal(
                height: defPadding * 8,
              ),
            ],
            if (index == 2) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defPadding * 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const TextBodyMedium(
                            text: 'Posebne postavke za džumu',
                            bold: false,
                            //color: colorLightShade,
                          ),
                          gap8,
                          TextBodySmall(
                            text: !dzumaSpecial
                                ? dzumaVakatTakvim
                                : dzumaVakatAdet,
                            italic: false,
                          )
                        ],
                      ),
                    ),
                    gap16,
                    ToggleSwitch(
                      toggleState: dzumaSpecial,
                      onTap: () {
                        vaktijaSettingsModel.dzumaSpecial = !dzumaSpecial;
                        updateVaktijaSettings(context, vaktijaSettingsModel);
                      },
                    ),
                  ],
                ),
              ),
              const DividerCustomHorizontal(
                height: defPadding * 8,
              ),
            ],
            VakatNotificationField(index: index),
            const DividerCustomHorizontal(
              height: defPadding * 8,
            ),
            VakatAlarmField(
              index: index,
            ),
            if (Platform.isAndroid) ...[
              const DividerCustomHorizontal(
                height: defPadding * 8,
              ),
              VakatDeviceSilentField(
                index: index,
              ),
            ]
          ],
        ),
      ),
    );
  }
}
