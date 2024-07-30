import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaktijaba_fl/components/models/vaktija_settings_model.dart';
import 'package:vaktijaba_fl/components/text_styles/text_headline_small.dart';
import 'package:vaktijaba_fl/data/constants.dart';
import 'package:vaktijaba_fl/data/data.dart';
import 'package:vaktijaba_fl/function/dark_mode_check.dart';
import 'package:vaktijaba_fl/function/open_new_screen.dart';
import 'package:vaktijaba_fl/location_screen/location_screen.dart';

import '../services/vaktija_state_provider.dart';

class LocationFieldHome extends StatefulWidget {
  const LocationFieldHome({Key? key}) : super(key: key);

  @override
  _LocationFieldHomeState createState() => _LocationFieldHomeState();
}

class _LocationFieldHomeState extends State<LocationFieldHome> {
  @override
  Widget build(BuildContext context) {
    bool isDarkModeOn = isDarkMode(context);
    StateProviderVaktija vaktijaProvider = Provider.of<StateProviderVaktija>(context);
    VaktijaSettingsModel vaktijaSettingsModel = vaktijaProvider.vaktijaSettings;
    int grad = vaktijaSettingsModel.currentCity!;
    return GestureDetector(
      onTap: () {
        openNewScreen(context, LocationScreen(), 'lokacija');
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: defaultPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              size: 22.0,
              color: Theme.of(context)
                  .indicatorColor, // isDarkModeOn ? colorWhite : colorGreyDark,
            ),
            gap16,
            TextHeadlineSmall(
              text: gradovi[grad],
              fontSize: 32.0,
            ),
          ],
        ),
      ),
    );
  }
}
