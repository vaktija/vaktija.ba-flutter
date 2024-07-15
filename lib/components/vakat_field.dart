import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:vaktijaba_fl/app_theme/theme_data.dart';
import 'package:vaktijaba_fl/components/text_styles/text_body_small.dart';
import 'package:vaktijaba_fl/components/text_styles/text_headline_small.dart';
import 'package:vaktijaba_fl/components/text_styles/vakat_time_field.dart';
import 'package:vaktijaba_fl/data/data.dart';
import 'package:vaktijaba_fl/function/check_dst.dart';
import 'package:vaktijaba_fl/function/get_next_vakat.dart';
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
    DateTime now = DateTime.now();
    int podneDefaultTime = 43200;
    bool dzuma = now.weekday == 4;
    int dan = now.day - 1;
    int mjesec = now.month - 1;
    int currentTime = (now.hour * 3600) + (now.minute * 60) + now.second;
    int dstAddonTime = checkDST(now) ? 3600 : 0;
    var vaktijaProvider = vaktijaStateProvider(context);
    int grad = vaktijaProvider.currentLocation;
    bool podneVrijeme = vaktijaProvider.podneStvarnoVrijeme;
    int nextVakatIndex = getNextVakat(
      currentTime,
      grad,
      mjesec,
      dan,
      dstAddonTime,
    );
    bool nextVakat = nextVakatIndex == widget.index ? true : false;
    bool specialDzuma = vaktijaProvider.dzumaVrijemeAdet;

    int vakatTime = widget.index == 2 &&
            (!podneVrijeme || (dzuma && specialDzuma))
        ? podneDefaultTime + dstAddonTime
        : vaktijaData['months'][mjesec]['days'][dan]['vakat'][widget.index] +
            differences[grad]['months'][mjesec]['vakat'][widget.index] +
            dstAddonTime;

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
                backgroundColor: AppColors.colorGreyLight,
                padding: EdgeInsets.all(defaultPadding * 2),
                onPressed: (context) {
                  openNewScreen(
                      context,
                      VakatSettingsScreen(
                        index: widget.index,
                      ),
                      'vakat postavke');
                }),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(
              left: defaultPadding * 4, right: defaultPadding * 4),
          child: ListTile(
            title: TextHeadlineSmall(
                text: widget.index == 2 && dzuma
                    ? 'Džuma'
                    : vaktoviName[widget.index],
                color: nextVakat ? AppColors.colorGold : null),
            subtitle: TextBodySmall(
              text: vaktijaTimeLeft(currentTime, vakatTime, nextVakat),
              italic: true,
            ),
            trailing: TextVakatTime(
              text: vaktijaSec2HourString(vakatTime),
            ),
          ),
        ),
      ),
    );
  }
}
