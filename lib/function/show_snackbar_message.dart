import 'package:flutter/material.dart';
import 'package:vaktijaba_fl/app_theme/theme_data.dart';
import 'package:vaktijaba_fl/components/text_styles/text_body_large.dart';
import 'package:vaktijaba_fl/components/text_styles/text_body_medium.dart';
import 'package:vaktijaba_fl/services/navigation_service.dart';


removeSnackbarCurrent(){
  ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!).removeCurrentSnackBar();
}

removeSnackbarAll(){
  ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!).clearSnackBars();
}

showSnackbarMessage({
  String? message,
  Color? messageColor,
  Color? buttonColor,
  EdgeInsetsGeometry? margin,
  Duration? duration,
  SnackBarBehavior? behavior
}) {
  // .currentState.showSnackBar(mySnackBar);
  // scaffoldMessengerKey.currentState.hideCurrentSnackBar(mySnackBar);
  // scaffoldMessengerKey.currentState.removeCurrentSnackBar(mySnackBar);
  BuildContext context = NavigationService.navigatorKey.currentContext!;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: AppColors.containerSecondaryColorDark,
      content: TextBodyMedium(
        text: message ?? "Poruka poslata!",
        color: messageColor ?? Colors.white,
      ),
      duration: duration ?? const Duration(milliseconds: 5000),
      margin: margin,
      action: SnackBarAction(
        label: "Zatvori",
        textColor: buttonColor ?? AppColors.colorWarning,
        onPressed: () {},
      ),
      behavior: behavior,
    ),
  );
}
