import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:vaktijaba_fl/app_theme/theme_data.dart';
import 'package:vaktijaba_fl/components/models/vaktija_settings_model.dart';
import 'package:vaktijaba_fl/components/text_styles/text_body_medium.dart';
import 'package:vaktijaba_fl/data/data.dart';
import 'package:vaktijaba_fl/function/dark_mode_check.dart';
import 'package:vaktijaba_fl/function/open_filter_screen.dart';
import 'package:vaktijaba_fl/location_screen/location_search_screen.dart';
import 'package:vaktijaba_fl/services/vaktija_state_provider.dart';

import '../components/divider/horizontal_divider.dart';
import '../components/vaktija_location_list_field.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  void closeFilter() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    StateProviderVaktija vaktijaProvider = Provider.of<StateProviderVaktija>(context);
    VaktijaSettingsModel vaktijaSettingsModel = vaktijaProvider.vaktijaSettings;
    var grad = vaktijaSettingsModel.currentCity;
    bool isDarkModeOn = isDarkMode(context);
    return Scaffold(
      //backgroundColor: isDarkModeOn ? Colors.black : Colors.white,
      appBar: AppBar(
        //iconTheme: IconThemeData(color: AppColors.colorAction),
        // elevation: 0,
        // backgroundColor: isDarkModeOn ? Colors.black : Colors.white,
        // shadowColor: Colors.transparent,
        centerTitle: true,
        title: TextBodyMedium(
          text: 'Lokacija',
          bold: true,
        ),
        actions: [
          IconButton(
              onPressed: () {
                openFilterScreen(
                    context,
                    LocationSearchScreen(
                      closeFilter: closeFilter,
                    ));
              },
              icon: Icon(
                Icons.search,
                color: AppColors.colorAction,
              )),
        ],
      ),
      body: ScrollablePositionedList.separated(
        itemCount: gradovi.length,
        initialScrollIndex: grad! > 0 ? grad - 1 : grad,
        padding: EdgeInsets.symmetric(
            horizontal: defaultPadding * 2, vertical: defaultPadding * 2),
        itemBuilder: (context, indexGrada) {
          return LocationListField(
            title: gradovi[indexGrada],
            isChecked: grad == indexGrada ? true : false,
            isRadioIcon: false,
            index: indexGrada,
            length: gradovi.length,
            onTap: () {
              vaktijaSettingsModel.currentCity = indexGrada;
              updateVaktijaSettings(context, vaktijaSettingsModel);
              Navigator.pop(context);
            },
          );
        },
        separatorBuilder: (context, index) {
          return DividerCustomHorizontal();
        },
      ),
    );
  }
}
