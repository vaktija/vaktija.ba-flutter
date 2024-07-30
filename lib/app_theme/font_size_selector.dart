import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaktijaba_fl/app_theme/theme_state.dart';
import 'package:vaktijaba_fl/components/text_styles/text_body_medium.dart';
import 'package:vaktijaba_fl/data/constants.dart';

class FontSizeSelector extends StatelessWidget {
  const FontSizeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    double fontSizeMultiplier =
        Provider.of<StateAppTheme>(context).fontSizeMultiplier;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const TextBodyMedium(
          text: 'Veličina teksta',
          bold: true,
        ),
        gap8,
        CupertinoSlider(
          value: fontSizeMultiplier,
          activeColor: Theme.of(context).iconTheme.color,
          divisions: 4,
          min: 0.0,
          max: 40.0,
          onChanged: (value) {
            //double newValue = value / 100;
            // print(newValue);
            Provider.of<StateAppTheme>(context, listen: false)
                .setFontSize(value);
          },
        )
      ],
    );
  }
}
