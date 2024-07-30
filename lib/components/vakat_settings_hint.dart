import 'package:flutter/material.dart';
import 'package:vaktijaba_fl/app_theme/theme_data.dart';
import 'package:vaktijaba_fl/components/text_styles/text_body_small.dart';
import 'package:vaktijaba_fl/data/constants.dart';

class VakatSettingsHint extends StatelessWidget {
  const VakatSettingsHint({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defPadding * 2),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.colorWarning,
          borderRadius: BorderRadius.circular(
            defPadding,
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: defPadding * 2,
          vertical: defPadding*1.5,
        ),
        child: TextBodySmall(
          text:
              'NAPOMENA: Za postavke pojedinačnog vakta povucite karticu vakta ulijevo!',
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w600,
          color: AppColors.colorWhite,
          //fontSize: 32.0,
        ),
      ),
    );
  }
}
