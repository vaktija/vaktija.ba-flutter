import 'package:flutter/material.dart';
import 'package:vaktijaba_fl/components/text_styles/text_title.dart';
import 'package:vaktijaba_fl/components/vakat_alarm_field.dart';
import 'package:vaktijaba_fl/components/vertical_separator.dart';
import 'package:vaktijaba_fl/data/data.dart';
import 'package:vaktijaba_fl/function/dark_mode_check.dart';
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
    bool isDarkModeOn = isDarkMode(context);
    var vaktijaProvider = vaktijaStateProvider(context);

    var vakatNotifikacijaTime =
        vaktijaProvider.vaktoviNotifikacije[widget.index];

    var vakatAlarmTime = vaktijaProvider.vaktoviAlarm[widget.index];

    bool playVakatNotifikacija =
        vaktijaProvider.playVaktijaNotifikacijaSound[widget.index];

    bool playVakatAlarm = vaktijaProvider.playVaktijaAlarmSound[widget.index];

    return Scaffold(
      backgroundColor: isDarkModeOn ? Colors.black : Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: isDarkModeOn ? Colors.black : Colors.white,
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: TextTitle(
          text: widget.index == 6 ? 'Džuma' : vaktoviName[widget.index],
          bold: true,
        ),
        iconTheme: IconThemeData(color: colorAction),
        actions: [
          widget.index != 2
              ? Container()
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: TextButton(
                      onPressed: () {
                        // setDate();
                        openNewScreen(context, VakatSettingsScreen(index: 6),
                            'namaska vremena');
                      },
                      child: TextTitle(
                        text: 'Džuma',
                        color: colorAction,
                      )),
                )
        ],
      ),
      body: Column(
        children: [
          VerticalListSeparator(height: 2,),
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
        ],
      ),
    );
  }
}
