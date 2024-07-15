import 'package:flutter/material.dart';
import 'package:vaktijaba_fl/app_theme/theme_data.dart';

ThemeData appThemeLight({double? fontSizeMultiplier}) {
  return ThemeData(
      useMaterial3: false,
      brightness: Brightness.light,
      textTheme: TextTheme(
        displayLarge: appTextStyle(
          fontSize: AppFont.sizeDisplayL,
          fontSizeMultiplier: fontSizeMultiplier ?? 0.0,
          fontWeight: AppFont.semiBold,
          color: AppColors.textHeader,
          height: 1.25,
        ),
        displayMedium: appTextStyle(
          fontSize: AppFont.sizeDisplayM,
          fontSizeMultiplier: fontSizeMultiplier ?? 0.0,
          fontWeight: AppFont.semiBold,
          color: AppColors.textHeader,
          height: 1.25,
        ),
        displaySmall: appTextStyle(
          fontSize: AppFont.sizeDisplayS,
          fontSizeMultiplier: fontSizeMultiplier ?? 0.0,
          fontWeight: AppFont.bold,
          color: AppColors.textHeader,
          height: 1.25,
        ),

        headlineLarge: appTextStyle(
          fontSize: AppFont.sizeHeadlineL,
          fontSizeMultiplier: fontSizeMultiplier ?? 0.0,
          fontWeight: AppFont.semiBold,
          color: AppColors.textHeader,
          height: 1.25,
        ),
        headlineMedium: appTextStyle(
          fontSize: AppFont.sizeHeadlineM,
          fontSizeMultiplier: fontSizeMultiplier ?? 0.0,
          fontWeight: AppFont.bold,
          color: AppColors.textHeader,
          height: 1.25,
        ),
        headlineSmall: appTextStyle(
          fontSize: AppFont.sizeHeadlineS,
          fontSizeMultiplier: fontSizeMultiplier ?? 0.0,
          fontWeight: AppFont.bold,
          color: AppColors.textHeader,
          height: 1.25,
        ),

        titleLarge: appTextStyle(
          fontSize: AppFont.sizeTitleL,
          fontSizeMultiplier: fontSizeMultiplier ?? 0.0,
          fontWeight: AppFont.semiBold,
          color: AppColors.textHeader,
          height: 1.25,
        ),
        titleMedium: appTextStyle(
          fontSize: AppFont.sizeTitleM,
          fontSizeMultiplier: fontSizeMultiplier ?? 0.0,
          fontWeight: AppFont.bold,
          color: AppColors.textHeader,
          height: 1.25,
        ),
        titleSmall: appTextStyle(
          fontSize: AppFont.sizeTitleS,
          fontSizeMultiplier: fontSizeMultiplier ?? 0.0,
          fontWeight: AppFont.bold,
          color: AppColors.textHeader,
          height: 1.25,
        ),

        bodyLarge: appTextStyle(
          fontSize: AppFont.sizeBodyL,
          fontSizeMultiplier: fontSizeMultiplier ?? 0.0,
          fontWeight: AppFont.semiBold,
          color: AppColors.textHeader,
          height: 1.25,
        ),
        bodyMedium: appTextStyle(
          fontSize: AppFont.sizeBodyM,
          fontSizeMultiplier: fontSizeMultiplier ?? 0.0,
          fontWeight: AppFont.light,
          color: AppColors.textBody,
          height: 1.25,
        ),
        bodySmall: appTextStyle(
          fontSize: AppFont.sizeBodyS,
          fontSizeMultiplier: fontSizeMultiplier ?? 0.0,
          fontWeight: AppFont.thin,
          color: AppColors.textBody,
          height: 1.25,
        ),

        labelLarge: appTextStyle(
          fontSize: AppFont.sizeLabelL,
          fontSizeMultiplier: fontSizeMultiplier ?? 0.0,
          fontWeight: AppFont.normal,
          color: AppColors.textLabel,
          height: 1.25,
        ),
        labelMedium: appTextStyle(
          fontSize: AppFont.sizeLabelM,
          fontSizeMultiplier: fontSizeMultiplier ?? 0.0,
          fontWeight: AppFont.light,
          color: AppColors.textLabel,
          height: 1.25,
        ),
        labelSmall: appTextStyle(
          fontSize: AppFont.sizeLabelS,
          fontSizeMultiplier: fontSizeMultiplier ?? 0.0,
          fontWeight: AppFont.thin,
          color: AppColors.textLabel,
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
      iconTheme: IconThemeData(
        color: AppColors.iconColor,
        size: 22.0,
      ),
      colorScheme: ColorScheme.light(
        brightness: Brightness.light,
        primaryContainer: AppColors.containerColor,
        primary: AppColors.iconColor,
        surface: AppColors.scaffoldBg,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.scaffoldBg,
        elevation: 0.0, // defPadding/2,
        shadowColor: Colors.transparent,
        centerTitle: true,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.bottomNavigationBG,
        selectedItemColor: AppColors.bottomNavigationSelected,
        unselectedItemColor: AppColors.bottomNavigationUnelected,
      ),
      primaryColor: AppColors.iconColor,
      secondaryHeaderColor: AppColors.textBody,
      scaffoldBackgroundColor: AppColors.scaffoldBg,
      disabledColor: AppColors.disabledColor,
      shadowColor: AppColors.shadowColor,
      dividerColor: AppColors.dividerColor,
      indicatorColor: AppColors.colorBlack);
}
