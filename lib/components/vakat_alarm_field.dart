import 'package:flutter/material.dart';
import 'package:vaktijaba_fl/components/text_styles/text_subtitle.dart';
import 'package:vaktijaba_fl/components/text_styles/text_title.dart';
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
  const VaktijaAlarmField({Key? key, this.isActive, this.setActive, this.onSliderChange, this.title, this.subtitle, this.sliderValue, this.sliderLength}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding*2),
      child: Column(
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
                            TextTitle(
                              text: title,
                              //color: colorLightShade,
                              bold: false,
                            ),
                            VerticalListSeparator(height: 1,),
                            TextSubtitle(
                              text: ((subtitle / 60).toInt())
                                  .toString() +
                                  ' minuta prije nastupa',
                              italic: false,
                              color: !isActive ? colorGreyLight : null,
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
              VerticalListSeparator(height: 1,),
              Slider.adaptive(
                  min: 0,
                  max: sliderLength.toDouble(),
                  divisions: sliderLength,
                  activeColor: isActive ? colorAction : colorGreyLight,
                  thumbColor:
                  isActive ? Colors.white : colorGreyLight,
                  value: sliderValue / 60,
                  onChanged: !isActive
                      ? null
                      : onSliderChange
              )
            ],
      ),
    );
  }
}
