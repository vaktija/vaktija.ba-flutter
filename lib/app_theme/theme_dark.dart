import 'package:flutter/material.dart';
import 'package:vaktijaba_fl/app_theme/theme_data.dart';
import 'package:vaktijaba_fl/data/constants.dart';

ThemeData appThemeDark({double? fontSizeMultiplier}) {
  return ThemeData(
    useMaterial3: false,
    brightness: Brightness.dark,
    textTheme: TextTheme(
      displayLarge: appTextStyle(
        fontSize: AppFont.sizeDisplayL,
        fontSizeMultiplier: fontSizeMultiplier ?? 0.0,
        fontWeight: AppFont.semiBold,
        color: AppColors.textHeaderDark,
        height: 1.25,
      ),
      displayMedium: appTextStyle(
        fontSize: AppFont.sizeDisplayM,
        fontSizeMultiplier: fontSizeMultiplier ?? 0.0,
        fontWeight: AppFont.semiBold,
        color: AppColors.textHeaderDark,
        height: 1.25,
      ),
      displaySmall: appTextStyle(
        fontSize: AppFont.sizeDisplayS,
        fontSizeMultiplier: fontSizeMultiplier ?? 0.0,
        fontWeight: AppFont.bold,
        color: AppColors.textHeaderDark,
        height: 1.25,
      ),

      headlineLarge: appTextStyle(
        fontSize: AppFont.sizeHeadlineL,
        fontSizeMultiplier: fontSizeMultiplier ?? 0.0,
        fontWeight: AppFont.semiBold,
        color: AppColors.textHeaderDark,
        height: 1.25,
      ),
      headlineMedium: appTextStyle(
        fontSize: AppFont.sizeHeadlineM,
        fontSizeMultiplier: fontSizeMultiplier ?? 0.0,
        fontWeight: AppFont.bold,
        color: AppColors.textHeaderDark,
        height: 1.25,
      ),
      headlineSmall: appTextStyle(
        fontSize: AppFont.sizeHeadlineS,
        fontSizeMultiplier: fontSizeMultiplier ?? 0.0,
        fontWeight: AppFont.bold,
        color: AppColors.textHeaderDark,
        height: 1.25,
      ),

      titleLarge: appTextStyle(
        fontSize: AppFont.sizeTitleL,
        fontSizeMultiplier: fontSizeMultiplier ?? 0.0,
        fontWeight: AppFont.semiBold,
        color: AppColors.textHeaderDark,
        height: 1.25,
      ),
      titleMedium: appTextStyle(
        fontSize: AppFont.sizeTitleM,
        fontSizeMultiplier: fontSizeMultiplier ?? 0.0,
        fontWeight: AppFont.bold,
        color: AppColors.textHeaderDark,
        height: 1.25,
      ),
      titleSmall: appTextStyle(
        fontSize: AppFont.sizeTitleS,
        fontSizeMultiplier: fontSizeMultiplier ?? 0.0,
        fontWeight: AppFont.bold,
        color: AppColors.textHeaderDark,
        height: 1.25,
      ),

      bodyLarge: appTextStyle(
        fontSize: AppFont.sizeBodyL,
        fontSizeMultiplier: fontSizeMultiplier ?? 0.0,
        fontWeight: AppFont.semiBold,
        color: AppColors.textHeaderDark,
        height: 1.25,
      ),
      bodyMedium: appTextStyle(
        fontSize: AppFont.sizeBodyM,
        fontSizeMultiplier: fontSizeMultiplier ?? 0.0,
        fontWeight: AppFont.light,
        color: AppColors.textBodyDark,
        height: 1.25,
      ),
      bodySmall: appTextStyle(
        fontSize: AppFont.sizeBodyS,
        fontSizeMultiplier: fontSizeMultiplier ?? 0.0,
        fontWeight: AppFont.thin,
        color: AppColors.textBodyDark,
        height: 1.25,
      ),

      labelLarge: appTextStyle(
        fontSize: AppFont.sizeLabelL,
        fontSizeMultiplier: fontSizeMultiplier ?? 0.0,
        fontWeight: AppFont.normal,
        color: AppColors.textLabelDark,
        height: 1.25,
      ),
      labelMedium: appTextStyle(
        fontSize: AppFont.sizeLabelM,
        fontSizeMultiplier: fontSizeMultiplier ?? 0.0,
        fontWeight: AppFont.light,
        color: AppColors.textLabelDark,
        height: 1.25,
      ),
      labelSmall: appTextStyle(
        fontSize: AppFont.sizeLabelS,
        fontSizeMultiplier: fontSizeMultiplier ?? 0.0,
        fontWeight: AppFont.thin,
        color: AppColors.textLabelDark,
        height: 1.25,
      ),
      // displayLarge 	Roboto 57/64
      // displayMedium 	Roboto 45/52
      // displaySmall 	Roboto 36/44
      // headlineLarge 	Roboto 32/40
      // headlineMedium 	Roboto 28/36
      // headlineSmall 	Roboto 24/32
      // titleLarge 	New- Roboto Medium 22/28
      // titleMedium 	Roboto Medium 16/24
      // titleSmall 	Roboto Medium 14/20
      // bodyLarge 	Roboto 16/24
      // bodyMedium 	Roboto 14/20
      // bodySmall 	Roboto 12/16
      // labelLarge 	Roboto Medium 14/20
      // labelMedium 	Roboto Medium 12/16
      // labelSmall 	New Roboto Medium, 11/16
    ),
    colorScheme: ColorScheme.dark(
      brightness: Brightness.dark,
      surface: AppColors.scaffoldBgDark,
      primary: AppColors.iconColorDark,
      primaryContainer: AppColors.containerColorDark,
    ),
    iconTheme: IconThemeData(
      color: AppColors.iconColorDark, //colorGreyDark
      size: 22.0,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.scaffoldBgDark,
      //foregroundColor: AppColors.scaffoldBg,
      //surfaceTintColor: AppColors.scaffoldBg,
      //color: AppColors.scaffoldBg,
      elevation: 0.0,//defPadding/2,
      centerTitle: true,
      shadowColor: Colors.transparent,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.bottomNavigationBGDark,
      selectedItemColor: AppColors.bottomNavigationSelectedDark,
      unselectedItemColor: AppColors.bottomNavigationUnelectedDark,
    ),
    primaryColor: AppColors.iconColorDark,
    scaffoldBackgroundColor: AppColors.scaffoldBgDark,
    secondaryHeaderColor: AppColors.textBodyDark,
    dividerColor: AppColors.dividerColorDark,
    indicatorColor: AppColors.colorWhite
  );
}
