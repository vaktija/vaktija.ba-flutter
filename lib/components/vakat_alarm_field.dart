import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaktijaba_fl/app_theme/theme_data.dart';
import 'package:vaktijaba_fl/components/models/vakat_ezan_model.dart';
import 'package:vaktijaba_fl/components/models/vakat_settings_model.dart';
import 'package:vaktijaba_fl/components/text_styles/text_body_medium.dart';
import 'package:vaktijaba_fl/components/text_styles/text_body_small.dart';
import 'package:vaktijaba_fl/components/toggle_switch.dart';
import 'package:vaktijaba_fl/data/app_data.dart';
import 'package:vaktijaba_fl/data/constants.dart';
import 'package:vaktijaba_fl/data/data.dart';
import 'package:vaktijaba_fl/function/show_full_screen.dart';
import 'package:vaktijaba_fl/services/vaktija_state_provider.dart';
import 'package:vaktijaba_fl/vakat_settings_screen/athan_select_dialogue.dart';

class VakatAlarmField extends StatelessWidget {
  final int index;

  const VakatAlarmField({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int sliderLength = 60;
    StateProviderVaktija vaktijaProvider =
        Provider.of<StateProviderVaktija>(context);

    VakatSettingsModel vakatSettingsModel = vaktijaProvider.vaktovi[index];
    int timeValue = vakatSettingsModel.alarmTimeOut!;
    bool isActive = vakatSettingsModel.alarmShow!;
    bool vibrate = vakatSettingsModel.alarmVibrate!;
    EzanModel activeAthan = vakatSettingsModel.ezan ?? Athans.defaultAthan;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const TextBodyMedium(
                      text: 'Alarm',
                      //color: colorLightShade,
                      bold: true,
                    ),
                    gap8,
                    TextBodySmall(
                      text: '${(timeValue / 60).toInt()} minuta prije nastupa',
                      italic: false,
                      color: !isActive ? AppColors.colorGreyLight : null,
                    )
                  ],
                ),
                ToggleSwitch(
                  onTap: () {
                    vakatSettingsModel.alarmShow = !isActive;
                    updateVakatSettings(context, vakatSettingsModel, index);
                  }, //setActive,
                  toggleState: isActive,
                ),
              ],
            ),
          ),
          gap8,
          CupertinoSlider(
            value: timeValue / 60,
            onChanged: !isActive
                ? null
                : (value) {
                    vakatSettingsModel.alarmTimeOut = (value * 60).toInt();
                    updateVakatSettings(context, vakatSettingsModel, index);
                  },
            divisions: sliderLength,
            activeColor:
                isActive ? AppColors.colorAction : AppColors.colorGreyLight,
            thumbColor: isActive ? Colors.white : AppColors.colorGreyLight,
            min: 0,
            max: sliderLength.toDouble(),
          ),
          //gap16,
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            activeColor: AppColors.colorAction,
            title: Padding(
              padding: const EdgeInsets.only(left: defPadding),
              child: TextBodySmall(
                  text:
                      'Vibracija tokom alarma ${vibrate ? '' : 'de'}aktivirana'),
            ),
            value: vibrate,
            onChanged: !isActive
                ? null
                : (newValue) {
                    vakatSettingsModel.alarmVibrate = !vibrate;
                    updateVakatSettings(context, vakatSettingsModel, index);
                  },
          ),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: defaultPadding),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         mainAxisSize: MainAxisSize.min,
          //         children: [
          //           const TextBodyMedium(
          //             text: 'Vibracija',
          //             //color: colorLightShade,
          //             bold: false,
          //           ),
          //           gap8,
          //           TextBodySmall(
          //             text:
          //                 'Vibracija tokom alarma ${vibrate ? '' : 'de'}aktivirana',
          //             italic: false,
          //             color: !isActive ? AppColors.colorGreyLight : null,
          //           )
          //         ],
          //       ),
          //       ToggleSwitch(
          //         onTap: !isActive
          //             ? null
          //             : () {
          //                 vakatSettingsModel.alarmVibrate = !vibrate;
          //                 updateVakatSettings(
          //                     context, vakatSettingsModel, index);
          //               }, //setActive,
          //         toggleState: vibrate,
          //       ),
          //     ],
          //   ),
          // ),
          gap16,
          InkWell(
            onTap: !isActive
                ? null
                : () {
                    showFullscreen(
                        context: context,
                        child: AthanSelectDialogue(
                          vakatIndex: index,
                          activeAthan: activeAthan,
                        ),
                        dismissible: false);
                  },
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor),
              padding: EdgeInsets.symmetric(horizontal: defPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextBodyMedium(
                        text: 'Zvuk alarma',
                        bold: false,
                      ),
                      gap4,
                      TextBodySmall(
                        text: activeAthan.muazzin,
                        color: !isActive ? AppColors.colorGreyLight : null,
                        //bold: false,
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: !isActive
                        ? Theme.of(context).disabledColor
                        : AppColors.colorAction,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
