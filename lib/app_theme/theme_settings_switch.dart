import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaktijaba_fl/app_theme/theme_data.dart';
import 'package:vaktijaba_fl/app_theme/theme_state.dart';
import 'package:vaktijaba_fl/data/constants.dart';

class ThemeSettingsSwitch extends StatelessWidget {
  final double? horizontalPadding;
  final double? verticalPadding;

  const ThemeSettingsSwitch({
    super.key,
    this.horizontalPadding,
    this.verticalPadding,
  });

  @override
  Widget build(BuildContext context) {
    List<String> themeModes = [
      'Svijetla',
      'Auto/OS',
      'Tamna',
    ];
    int themeMode = Provider.of<StateAppTheme>(context).themeMode;
    double fontMultiplier =
        Provider.of<StateAppTheme>(context).fontSizeMultiplier;
    TextStyle textStyle = Theme.of(context).textTheme.bodyMedium!;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding ?? 0.0,//defPadding,
        vertical: verticalPadding ?? defPadding,
      ),
      child: CupertinoSlidingSegmentedControl(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        // ?? CupertinoColors.tertiarySystemFill,
        children: Map.fromEntries(
          List.generate(
            themeModes.length,
            (index) => MapEntry(
              index,
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: defPadding,
                ), // tabInnerPadding ?? defPadding),
                child: Text(
                  themeModes[index],
                  textScaleFactor: 1.0,
                  style: textStyle.copyWith(
                    fontSize: AppFont.sizeBodyM,
                    color: themeMode == index ? Colors.white : null,
                  ),
                ),
              ),
            ),
          ),
        ),
        groupValue: themeMode,
        thumbColor: AppColors.colorGold,
        onValueChanged: (int? newValue) {
          Provider.of<StateAppTheme>(context, listen: false)
              .setThemeMode(newValue!);
        },
      ),
    );
  }
}
