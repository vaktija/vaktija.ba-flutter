import 'package:flutter/material.dart';
import 'package:vaktijaba_fl/app_theme/theme_data.dart';
import 'package:vaktijaba_fl/data/constants.dart';

class ButtonSquare extends StatelessWidget {
  final Function()? onTap;
  final String? label;
  final Color? color;

  const ButtonSquare({super.key, this.onTap, this.label, this.color});

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = BorderRadius.circular(defPadding*2);
    TextStyle textStyle = Theme.of(context).textTheme.bodyLarge!;
    return Material(
      color: color ?? AppColors.colorWarning,
      borderRadius: borderRadius,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
          ),
          padding: const EdgeInsets.symmetric(
              vertical: defPadding * 2, horizontal: defPadding * 2),
          child: Text(
            label ?? 'Zaustavi',
            style: textStyle.copyWith(
              color: Colors.white,
              //letterSpacing: 0.1,
              fontWeight: FontWeight.w500
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
