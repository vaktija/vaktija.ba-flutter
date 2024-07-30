import 'package:flutter/material.dart';
import 'package:vaktijaba_fl/components/text_styles/text_list_field.dart';
import 'package:vaktijaba_fl/components/text_styles/text_body_medium.dart';
import 'package:vaktijaba_fl/data/constants.dart';
import 'package:vaktijaba_fl/data/data.dart';

class LocationListField extends StatelessWidget {
  final index;
  final length;
  final title;
  final subtitle;
  final isChecked;
  final onTap;
  final isRadioIcon;
  const LocationListField(
      {Key? key,
        this.index,
        this.length,
        this.title,
        this.isChecked,
        this.onTap,
        this.isRadioIcon, this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isRadioButton = isRadioIcon ?? false;
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          color: //isChecked ? Colors.grey.shade50 :
          Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 0.0, vertical: defPadding*2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextBodyMedium(
                text: title,
                bold: false,
              ),
              Icon(
                isChecked
                    ? (isRadioButton ? Icons.radio_button_on : Icons.check_rounded)
                    : (isRadioButton
                    ? Icons.radio_button_off
                    : null),
                size: 24,
                color: Colors.blue,
              )
            ],
          ),
        ),
      ),
    );
  }
}
