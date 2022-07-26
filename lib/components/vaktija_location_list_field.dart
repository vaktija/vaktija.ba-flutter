import 'package:flutter/material.dart';
import 'package:vaktijaba_fl/components/text_styles/text_list_field.dart';
import 'package:vaktijaba_fl/components/text_styles/text_title.dart';
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
        decoration: BoxDecoration(
          color: //isChecked ? Colors.grey.shade50 :
          Colors.transparent,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: defaultPadding * 0, vertical: defaultPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextTitle(
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
