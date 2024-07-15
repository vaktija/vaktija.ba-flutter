import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vaktijaba_fl/app_theme/theme_data.dart';
import 'package:vaktijaba_fl/components/text_styles/text_body_medium.dart';
import 'package:vaktijaba_fl/components/text_styles/text_body_small.dart';
import 'package:vaktijaba_fl/components/toggle_switch.dart';
import 'package:vaktijaba_fl/components/vertical_separator.dart';
import 'package:vaktijaba_fl/data/data.dart';

class VaktijaAlarmField extends StatelessWidget {
  final isActive;
  final setActive;
  final onSliderChange;
  final sliderValue;
  final sliderLength;
  final title;
  final subtitle;

  const VaktijaAlarmField(
      {Key? key,
      this.isActive,
      this.setActive,
      this.onSliderChange,
      this.title,
      this.subtitle,
      this.sliderValue,
      this.sliderLength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    TextBodyMedium(
                      text: title,
                      //color: colorLightShade,
                      bold: false,
                    ),
                    VerticalListSeparator(
                      height: 1,
                    ),
                    TextBodySmall(
                      text: ((subtitle / 60).toInt()).toString() +
                          ' minuta prije nastupa',
                      italic: false,
                      color: !isActive ? AppColors.colorGreyLight : null,
                    )
                  ],
                ),
                ToggleSwitch(
                  onTap: setActive,
                  isToggle: isActive,
                )
              ],
            ),
          ),
          VerticalListSeparator(
            height: 1,
          ),
          CupertinoSlider(
            value: sliderValue / 60,
            onChanged: !isActive ? null : onSliderChange,
            divisions: sliderLength,
            activeColor:
            isActive ? AppColors.colorAction : AppColors.colorGreyLight,
            thumbColor: isActive ? Colors.white : AppColors.colorGreyLight,
            min: 0,
            max: sliderLength.toDouble(),
          ),
          // Slider.adaptive(
          //     min: 0,
          //     max: sliderLength.toDouble(),
          //     divisions: sliderLength,
          //     activeColor:
          //         isActive ? AppColors.colorAction : AppColors.colorGreyLight,
          //     thumbColor: isActive ? Colors.white : AppColors.colorGreyLight,
          //     value: sliderValue / 60,
          //     onChanged: !isActive ? null : onSliderChange)
        ],
      ),
    );
  }
}
