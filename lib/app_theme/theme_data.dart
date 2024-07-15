import 'package:flutter/material.dart';

abstract class AppColors {
  static Color buttonColor = const Color(0xff1DA4A7);

  //Light mode
  static Color scaffoldBg = const Color(0xffffffff); //const Color(0xffE9F1F4);
  static Color containerColor = const Color(0xffE9F1F4);
  static Color iconColor = const Color(0xff2E2E2E);
  static Color disabledColor = const Color(0xffC3C3C3);
  static Color shadowColor = const Color(0xffd5d5d5);
  static Color dividerColor = const Color(0x22000000);

  static Color bottomNavigationBG = const Color(0xff055A5B);
  static Color bottomNavigationSelected = const Color(0xff055A5B);
  static Color bottomNavigationUnelected = const Color(0xffffffff);

  //text
  static Color textHeader = const Color(0xff2E2E2E);
  static Color textBody = const Color(0xff2E2E2E);
  static Color textLabel = const Color(0xff808080);

  //Dark mode
  static Color scaffoldBgDark = const Color(0xff000000);
  static Color containerColorDark = const Color(0xff1F222A);
  static Color iconColorDark = const Color(0xfffffff);
  static Color dividerColorDark = const Color(0xff676767);

  static Color bottomNavigationBGDark = const Color(0xff1DA4A7);
  static Color bottomNavigationSelectedDark = const Color(0xff1DA4A7);
  static Color bottomNavigationUnelectedDark = const Color(0xffE9F1F4);

  static Color textHeaderDark = const Color(0xffFFFFFF);
  static Color textBodyDark = const Color(0xffe8e8e8);
  static Color textLabelDark = const Color(0xff808080);

  static LinearGradient defaultGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      textHeaderDark,
      const Color(0xff52C1B5),
    ],
  );

  static Color colorBlack = Colors.black;
  static Color colorBlackBody = Colors.black87;
  static Color colorGreyDark = Colors.grey.shade900;
  static Color colorGreyMedium = Colors.grey.shade600;
  static Color colorGreyLight = Colors.grey.shade400;
  static Color colorWhite = Colors.white;

  static Color colorWarning = const Color(0xffff7a00);
  static Color colorBackground = const Color(0xffffffff);
  static Color colorErrorColor = const Color(0xff0000ff).withOpacity(1.0);
  static Color colorSubtitle = const Color(0xffCACACA);
  static Color colorTitle = const Color(0xff4a4a4a);
  static Color colorAction = const Color(0xff0882fd);
  static Color colorGold = const Color(0xffa59573);
  static Color colorSwitchActive = Colors.green;

  static IconThemeData iconThemeData = const IconThemeData(color: Colors.black87);

  static IconThemeData iconThemeDataNegative = const IconThemeData(color: Colors.white);
}

abstract class AppFont {
  static String family = '';
  static double sizeDisplayL = 57.0;
  static double sizeDisplayM = 44.0;
  static double sizeDisplayS = 36.0;

  static double sizeHeadlineL = 32.0;
  static double sizeHeadlineM = 28.0;
  static double sizeHeadlineS = 24.0;

  static double sizeTitleL = 22.0;
  static double sizeTitleM = 20.0;
  static double sizeTitleS = 18.0;

  static double sizeBodyL = 18.0;
  static double sizeBodyM = 16.0;
  static double sizeBodyS = 14.0;

  static double sizeLabelL = 12.0;
  static double sizeLabelM = 11.0;
  static double sizeLabelS = 10.0;

  static FontWeight bold = FontWeight.w700;
  static FontWeight semiBold = FontWeight.w600;
  static FontWeight normal = FontWeight.w500;
  static FontWeight light = FontWeight.w400;
  static FontWeight thin = FontWeight.w300;
}

TextStyle appTextStyle({
  required double fontSize,
  required double fontSizeMultiplier,
  required FontWeight fontWeight,
  required Color color,
  required double height,
  FontStyle? fontStyle,
}) {
  return TextStyle(
      fontSize: fontSize * (1.0 + (fontSizeMultiplier / 100)),
      fontWeight: fontWeight,
      color: color,
      height: height,
      fontStyle: fontStyle,
      fontFamily: 'DinNext');
}
