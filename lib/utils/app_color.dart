import 'package:flutter/material.dart';

class AppColors {
  static const kPrimary = Color(0xff473F97);
  static const kLightBlue = Color(0x8a473f97);
   static const kGreenRemarks = Color(0xFF05AC31);
   static const kTransparent = Colors.transparent;

  static const kBlueBG = Color(0xFFB8C7FF);
  static const kBlueBG2 = Color(0XFFE9E6FF);
  //static const kLightGreen = Color(0xFFAAE6BF);
  static const kGrayBG = Color(0xffEFEFEF);
  static const kButtonBGColor = Color(0xFFAEAFDB);
  static const kLightRed = Color(0xFFF1A8A8);
  static const kLightYellow = Color(0xFFFAF3C0);
  static const kDarkYellow = Color(0xFFBD903C);
  static const kEarlyLight = Color(0xFFE7F1A8);
  static const kEarlyDark = Color(0xFFA0AB3C);
  static const kHolidayLight = Color(0xFFDFEDFF);
  static const kHolidayDark = Color(0xFF3575D9);
  static const kFile = Color(0xFF726CB3);
  static const kLateRed = Color(0xFFAB3C3C);
  static const kGray = Color(0xff89898B);
  static const kTextFieldColor = Color(0xffE8EFF3);
  static const kLightGreen = Color(0xFFAAE6BF);
  static const kGreen = Color(0xff00A110);
  static const kDarkGreen = Color(0xff007A20);
  static const kGrayText = Color(0xff9E9E9E);
  static const appName = "British Lyceum App";
  static const bg_primary = Color(0xff29577f);
  static const lightBlue = Color(0xffABCBEB);
  static const silver = Color(0xffB6AFAF);
  static const blue = Color(0xff2E3092);
  static const lightGreen = Color(0xff2acb97);
  static const black_light = Color(0xffF5F5F5);
  static const red = Colors.red;
  static const black = Colors.black;
  static const kWhite = Colors.white;
  static const noInternet = Color(0xffe7effa);
  static const kFormText = Color(0xffe5ecff);
  static const kPageBG =  Color(0xFFE4E2F0);
  static const kOrange =  Color(0xFFE27D47);
  static const kLightOrange =  Color(0xFFFF8B28);
  static const kBG =  Color(0xFFE9E6FF);
  static const kBlack = Colors.black;
  static const kRed = Colors.red;
  static const kFormHint = Color(0xff8680bb);
  static const kAppTheme = Color(0xff2E3092);
  static const kHintColor = Color(0xff9fb8e0);
  static const kBtnColor = Color(0xffE1E2F9);
  static const klightGray = Color(0xffEEEEEE);
  static const kBoxBg = Color(0xffF6F9FD);
  static const kAppBackground = Color(0xffE9E6FF);
  static ThemeData lightTheme = ThemeData(
    backgroundColor: kWhite,
    primaryColor: kWhite,
    accentColor: kWhite,
    scaffoldBackgroundColor: kWhite,
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        headline6: TextStyle(
          color: kBlack,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );

  static OutlineInputBorder outlineInputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(width: 1.5, color: color),
    );
  }

  static TextStyle myTextStyle(double fontSize, FontWeight fontWeight) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }
}
