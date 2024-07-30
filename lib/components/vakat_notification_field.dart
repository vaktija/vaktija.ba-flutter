import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaktijaba_fl/app_theme/theme_data.dart';
import 'package:vaktijaba_fl/components/models/vakat_settings_model.dart';
import 'package:vaktijaba_fl/components/text_styles/text_body_medium.dart';
import 'package:vaktijaba_fl/components/text_styles/text_body_small.dart';
import 'package:vaktijaba_fl/components/toggle_switch.dart';
import 'package:vaktijaba_fl/components/vertical_separator.dart';
import 'package:vaktijaba_fl/data/constants.dart';
import 'package:vaktijaba_fl/data/data.dart';
import 'package:vaktijaba_fl/services/vaktija_state_provider.dart';

class VakatNotificationField extends StatelessWidget {
  final int index;

  const VakatNotificationField({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StateProviderVaktija vaktijaProvider =
        Provider.of<StateProviderVaktija>(context);

    VakatSettingsModel vakatSettingsModel = vaktijaProvider.vaktovi[index];
    int timeValue = vakatSettingsModel.notificationTimeOut!;
    int sliderLength = 30;
    bool isActive = vakatSettingsModel.showNotification!;
    bool vibrate = vakatSettingsModel.notificationVibrate!;

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
                      text: 'Notifikacija',
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
                    vakatSettingsModel.showNotification = !isActive;
                    updateVakatSettings(context, vakatSettingsModel, index);
                  },
                  toggleState: isActive,
                )
              ],
            ),
          ),
          VerticalListSeparator(
            height: 1,
          ),
          CupertinoSlider(
            value: timeValue / 60,
            onChanged: !isActive
                ? null
                : (value) {
                    vakatSettingsModel.notificationTimeOut = value.toInt() * 60;
                    updateVakatSettings(context, vakatSettingsModel, index);
                  },
            divisions: sliderLength,
            activeColor:
                isActive ? AppColors.colorAction : AppColors.colorGreyLight,
            thumbColor: isActive ? Colors.white : AppColors.colorGreyLight,
            min: 0,
            max: sliderLength.toDouble(),
          ),
          // gap16,
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
          //                 'Vibracija tokom notifikacije ${vibrate ? '' : 'de'}aktivirana',
          //             italic: false,
          //             color: !isActive ? AppColors.colorGreyLight : null,
          //           )
          //         ],
          //       ),
          //       ToggleSwitch(
          //         onTap: !isActive
          //             ? null
          //             : () {
          //                 vakatSettingsModel.notificationVibrate = !vibrate;
          //                 updateVakatSettings(
          //                     context, vakatSettingsModel, index);
          //               }, //setActive,
          //         toggleState: vibrate,
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
