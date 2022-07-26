import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:vaktijaba_fl/components/text_styles/text_title_big.dart';
import 'package:vaktijaba_fl/components/text_styles/text_subtitle.dart';
import 'package:vaktijaba_fl/components/text_styles/vakat_time_field.dart';
import 'package:vaktijaba_fl/data/data.dart';
import 'package:vaktijaba_fl/function/open_new_screen.dart';
import 'package:vaktijaba_fl/vakat_settings_screen/vakat_settings_screen.dart';
import '../function/sec_2_hhmm.dart';
import '../function/vaktija_time_left.dart';
import '../services/state_provider.dart';

class VakatField extends StatefulWidget {
  final index;
  const VakatField({Key? key, this.index}) : super(key: key);

  @override
  _VakatFieldState createState() => _VakatFieldState();
}

class _VakatFieldState extends State<VakatField> {
  void _onPressed(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    var vaktijaProvider = vaktijaStateProvider(context);

    bool podneVrijeme = vaktijaProvider.podneStvarnoVrijeme;
    int nextVakatIndex = vaktijaProvider.nextVakat;
    bool nextVakat = nextVakatIndex == widget.index ? true : false;
    bool dzuma = vaktijaProvider.currentWeekDay == 4;
    bool specialDzuma = vaktijaProvider.dzumaVrijemeAdet;
    int dst = vaktijaProvider.dstTime;
    int podneDefaultTime = 43200;
    int dan = vaktijaProvider.currentDay;
    int mjesec = vaktijaProvider.currentMonth;
    int grad = vaktijaProvider.currentLocation;
    int currentTime = vaktijaProvider.currentTimeVaktija;
    int vakatTime = widget.index == 2 && (!podneVrijeme || (dzuma && specialDzuma))
        ? podneDefaultTime + dst
        : vaktijaData['months'][mjesec]['days'][dan]['vakat'][widget.index] +
            differences[grad]['months'][mjesec]['vakat'][widget.index] +
            dst;

    return SlidableAutoCloseBehavior(
      closeWhenOpened: true,
      closeWhenTapped: true,
      child: Slidable(
        key: Key(widget.index.toString()),
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          extentRatio: 0.3,
          children: [
            SlidableAction(
                autoClose: true,
                label: 'Postavke',
                spacing: defaultPadding * 4,
                foregroundColor: Colors.white,
                backgroundColor: colorGreyLight,
                padding: EdgeInsets.all(defaultPadding * 2),
                onPressed: (context){
                  openNewScreen(context, VakatSettingsScreen(
                    index: widget.index,
                  ), 'vakat postavke');
                }
                ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(
              left: defaultPadding * 4, right: defaultPadding * 4),
          child: ListTile(
            title: TextTitleBig(
              text: widget.index == 2 && dzuma ? 'Džuma' : vaktoviName[widget.index],
              color: nextVakat ? colorGold : null
            ),
            subtitle: TextSubtitle(
              text: vaktijaTimeLeft(currentTime, vakatTime, nextVakat),
              italic: true,
            ),
            trailing: TextVakatTime(
              text: vaktijaSec2Min(vakatTime),
            ),
          ),
        ),
      ),
    );
  }
}
