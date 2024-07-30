import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaktijaba_fl/app_theme/theme_data.dart';
import 'package:vaktijaba_fl/data/app_data.dart';
import 'package:vaktijaba_fl/data/constants.dart';
import 'package:vaktijaba_fl/services/vaktija_state_provider.dart';

class RegenerateNotifications extends StatefulWidget {
  const RegenerateNotifications({super.key});

  @override
  State<RegenerateNotifications> createState() =>
      _RegenerateNotificationsState();
}

class _RegenerateNotificationsState extends State<RegenerateNotifications> {
  @override
  Widget build(BuildContext context) {
    return AppSettingsData.isAndroid14plus
        ? Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: defPadding * 1.5),
              child: IconButton(
                onPressed: () {
                  Provider.of<StateProviderVaktija>(context, listen: false)
                      .scheduleVakat(delay: false);
                },
                icon: Icon(
                  Icons.sync_problem_outlined,
                  color: AppColors.colorAction,
                ),
              ),
            ),
          )
        : gap16;
  }
}
