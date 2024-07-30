import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:vaktijaba_fl/app_theme/theme_data.dart';
import 'package:vaktijaba_fl/components/button/button_square.dart';
import 'package:vaktijaba_fl/data/constants.dart';

class AlarmDialogue extends StatelessWidget {
  final AlarmSettings alarmSettings;
  final Function()? runScheduleTask;

  const AlarmDialogue({super.key, required this.alarmSettings, this.runScheduleTask});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyleTitle = Theme.of(context).textTheme.bodyLarge!;
    TextStyle textStyleSubtitle = Theme.of(context).textTheme.bodyMedium!;
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defPadding * 5),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              alarmSettings.notificationTitle,
              style: textStyleTitle.copyWith(
                color: AppColors.colorWhite,
                fontSize: 24.0
              ),
              textAlign: TextAlign.center,
            ),
            gap16,
            Text(
              alarmSettings.notificationBody,
              style: textStyleSubtitle.copyWith(color: AppColors.colorSubtitle),
              textAlign: TextAlign.center,
            ),
            gap32,
            ButtonSquare(
              onTap: () async {
                await Alarm.stop(alarmSettings.id);
                if(runScheduleTask != null){
                  runScheduleTask!();
                }
                Navigator.pop(context);
              },
              label: 'ZAUSTAVI',
            )
          ],
        ),
      ),
    );
  }
}
