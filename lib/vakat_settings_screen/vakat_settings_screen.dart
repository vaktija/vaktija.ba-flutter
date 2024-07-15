import 'package:flutter/material.dart';
import 'package:vaktijaba_fl/app_theme/theme_data.dart';
import 'package:vaktijaba_fl/components/divider/horizontal_divider.dart';
import 'package:vaktijaba_fl/components/text_styles/text_body_medium.dart';
import 'package:vaktijaba_fl/components/text_styles/text_body_small.dart';
import 'package:vaktijaba_fl/components/toggle_switch.dart';
import 'package:vaktijaba_fl/components/vakat_alarm_field.dart';
import 'package:vaktijaba_fl/components/vertical_separator.dart';
import 'package:vaktijaba_fl/data/constants.dart';
import 'package:vaktijaba_fl/data/data.dart';
import 'package:vaktijaba_fl/function/open_new_screen.dart';

import '../services/state_provider.dart';

class VakatSettingsScreen extends StatefulWidget {
  final index;

  const VakatSettingsScreen({Key? key, this.index}) : super(key: key);

  @override
  _VakatSettingsScreenState createState() => _VakatSettingsScreenState();
}

class _VakatSettingsScreenState extends State<VakatSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    //bool isDarkModeOn = isDarkMode(context);
    var vaktijaProvider = vaktijaStateProvider(context);

    var vakatNotifikacijaTime =
        vaktijaProvider.vaktoviNotifikacije[widget.index];

    var vakatAlarmTime = vaktijaProvider.vaktoviAlarm[widget.index];

    bool playVakatNotifikacija =
        vaktijaProvider.playVaktijaNotifikacijaSound[widget.index];

    bool playVakatAlarm = vaktijaProvider.playVaktijaAlarmSound[widget.index];

    bool podneVrijeme = vaktijaProvider.podneStvarnoVrijeme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        //elevation: 0,
        //backgroundColor: isDarkModeOn ? Colors.black : Colors.white,
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: TextBodyMedium(
          text: widget.index == 6 ? 'Džuma' : vaktoviName[widget.index],
          bold: true,
        ),
        iconTheme: IconThemeData(color: AppColors.colorAction),
        actions: [
          widget.index != 2
              ? Container()
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: TextButton(
                      onPressed: () {
                        // setDate();
                        openNewScreen(context, const VakatSettingsScreen(index: 6),
                            'namaska vremena');
                      },
                      child: TextBodyMedium(
                        text: 'Džuma',
                        color: AppColors.colorAction,
                      )),
                )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VerticalListSeparator(
            height: 2,
          ),
          //TODO: Alarm polje
          // VaktijaAlarmField(
          //   title: 'Alarm',
          //   subtitle: vakatAlarmTime,
          //   isActive: playVakatAlarm,
          //   setActive: () {
          //     setVaktijaAlarmSound(context, !playVakatAlarm,
          //         widget.vakatIndex);
          //   },
          //   sliderValue: vakatAlarmTime,
          //   sliderLength: 45,
          //   onSliderChange: (value) {
          //     setVaktijaAlarmTime(
          //         context, (value * 60), widget.vakatIndex);
          //   },
          // ),
          VaktijaAlarmField(
            title: 'Notifikacija',
            subtitle: vakatNotifikacijaTime,
            isActive: playVakatNotifikacija,
            setActive: () {
              setVakatNotifikacijaSound(
                  context, !playVakatNotifikacija, widget.index);
            },
            sliderValue: vakatNotifikacijaTime,
            sliderLength: 30,
            onSliderChange: (value) {
              setVakatNotifikacijaTime(context, (value * 60), widget.index);
            },
          ),
          if (widget.index == 2) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defPadding * 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  gap16,
                  const DividerCustomHorizontal(),
                  // gap16,
                  // const TextBodyMedium(
                  //   text: 'Podne-namaz',
                  //   bold: true,
                  // ),
                  gap16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const TextBodyMedium(
                              text: 'Vrijeme Podne-namaza',
                              bold: false,
                              //color: colorLightShade,
                            ),
                            const VerticalListSeparator(
                              height: 0.5,
                            ),
                            TextBodySmall(
                              text: podneVrijeme
                                  ? podneVakatTakvim
                                  : podneVakatAdet,
                              italic: false,
                            )
                          ],
                        ),
                      ),
                      gap16,
                      ToggleSwitch(
                        isToggle: !podneVrijeme,
                        onTap: () {
                          setVaktijaPodneVrijeme(context, !podneVrijeme);
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ]
        ],
      ),
    );
  }
}
