import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaktijaba_fl/app_theme/theme_data.dart';
import 'package:vaktijaba_fl/components/models/vakat_settings_model.dart';
import 'package:vaktijaba_fl/components/text_styles/text_body_medium.dart';
import 'package:vaktijaba_fl/components/text_styles/text_body_small.dart';
import 'package:vaktijaba_fl/components/toggle_switch.dart';
import 'package:vaktijaba_fl/data/constants.dart';
import 'package:vaktijaba_fl/data/data.dart';
import 'package:vaktijaba_fl/services/vaktija_state_provider.dart';

class VakatDeviceSilentField extends StatelessWidget {
  final int index;

  const VakatDeviceSilentField({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int sliderLength = 60;
    StateProviderVaktija vaktijaProvider =
        Provider.of<StateProviderVaktija>(context);
    VakatSettingsModel vakatSettingsModel = vaktijaProvider.vaktovi[index];
    int timeValue = vakatSettingsModel.deviceSilentTime!;
    bool isActive = vakatSettingsModel.deviceSilent!;

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
                      text: 'Utišaj uređaj tokom namaza',
                      //color: colorLightShade,
                      bold: true,
                    ),
                    gap8,
                    TextBodySmall(
                      text:
                          '${(timeValue / 60).toInt()} minuta ${vakatSettingsModel.vakatIndex == 1 ? 'prije' : 'od'} nastupa vakta',
                      italic: false,
                      color: !isActive ? AppColors.colorGreyLight : null,
                    )
                  ],
                ),
                ToggleSwitch(
                  onTap: () {
                    vakatSettingsModel.deviceSilent = !isActive;
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
                    vakatSettingsModel.deviceSilentTime = (value * 60).toInt();
                    updateVakatSettings(context, vakatSettingsModel, index);
                  },
            divisions: sliderLength,
            activeColor:
                isActive ? AppColors.colorAction : AppColors.colorGreyLight,
            thumbColor: isActive ? Colors.white : AppColors.colorGreyLight,
            min: 0,
            max: sliderLength.toDouble(),
          ),
        ],
      ),
    );
  }
}
