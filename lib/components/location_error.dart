import 'package:flutter/material.dart';
import 'package:vaktijaba_fl/components/text_styles/text_body_medium.dart';
import 'package:vaktijaba_fl/components/text_styles/text_body_small.dart';
import 'package:vaktijaba_fl/data/constants.dart';

class LocationError extends StatelessWidget {
  final String error;
  final Function callback;

  const LocationError({Key? key, required this.error, required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = SizedBox(height: 32);

    return Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.location_off,
              size: 24.0,
              color: Theme.of(context).indicatorColor.withOpacity(0.8),
            ),
            box,
            TextBodyMedium(
              text: error,
              //color: colorGrey6,
            ),
            box,
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(defPadding),
                color: Theme.of(context).dividerColor,
              ),
              child: TextButton(
                child: TextBodySmall(
                  text: "Pokušaj ponovo",
                ),
                onPressed: () {
                  callback();
                },
              ),
            ),
            gap16,
            const Padding(
              padding: EdgeInsets.all(defPadding * 2),
              child: TextBodySmall(
                text:
                    "Nakon aktiviranja lokacije obavezno kalibrirati kompas kao u uputstvu!",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
