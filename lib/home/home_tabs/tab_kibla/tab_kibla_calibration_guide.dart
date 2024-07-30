import 'package:flutter/material.dart';
import 'package:vaktijaba_fl/app_theme/theme_data.dart';
import 'package:vaktijaba_fl/components/text_styles/text_body_medium.dart';
import 'package:vaktijaba_fl/components/text_styles/text_body_small.dart';
import 'package:vaktijaba_fl/data/constants.dart';

class TabKiblaCalibrationGuide extends StatelessWidget {
  const TabKiblaCalibrationGuide({super.key});

  @override
  Widget build(BuildContext context) {
    String description =
        'Prije upotrebe Kibla kompasa,\npo uputstvu na ilustraciji kalibrirati kompas kako bi bilo moguće '
        'pravilno odrediti pravac Kible.';
    String descriptionBold = 'Ovaj pokret ponoviti minimalno 5 puta!';
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(defPadding * 3),
        child: Material(
          borderRadius: BorderRadius.circular(defPadding * 2),
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 330.0,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .primaryContainer, //scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(defPadding * 2),
            ),
            padding: const EdgeInsets.only(
              top: defPadding,
              //right: defPadding,
              bottom: defPadding * 3,
              //left: defPadding * 3,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: [
                    gap16,
                    const Expanded(
                      child: TextBodyMedium(
                        text: 'Kalibracija kompasa',
                      ),
                    ),
                    gap16,
                    IconButton(
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      icon: Icon(
                        Icons.close_outlined,
                        color: AppColors.colorAction,
                      ),
                      iconSize: defPadding * 3,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    gap4,
                  ],
                ),
                gap16,
                AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Image.asset(
                    'assets/icons/kibletnama_calibrate_compass.gif',
                    fit: BoxFit.contain,
                  ),
                ),
                gap16,
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: defPadding * 2,
                  ),
                  child: TextBodySmall(
                    text: description,
                    textAlign: TextAlign.center,
                  ),
                ),
                gap16,
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: defPadding * 2,
                  ),
                  child: TextBodySmall(
                    text: descriptionBold,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
