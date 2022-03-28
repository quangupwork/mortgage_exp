import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../styles/style.dart';

class MyTheme {
  static const String crimsonPro = 'CrimsonPro';
  static const String din = 'DIN';
  static const String roboto = 'Roboto';

  final bool _isLightMode =
      SchedulerBinding.instance!.window.platformBrightness == Brightness.light;

  bool get isLightMode => _isLightMode;

  static ThemeData lightTheme() {
    return ThemeData(
      fontFamily: din,
      backgroundColor: MyColors.backgroundColor,
      primaryColor: MyColors.primaryColor,
      colorScheme: const ColorScheme(
        secondary: MyColors.secondaryColor,
        primary: MyColors.primaryColor,
        background: MyColors.backgroundColor,
        brightness: Brightness.light,
        error: MyColors.errorColor,
        onBackground: MyColors.backgroundColor,
        onError: MyColors.errorColor,
        onPrimary: MyColors.primaryColor,
        onSecondary: MyColors.secondaryColor,
        onSurface: MyColors.whiteColor,
        surface: MyColors.whiteColor,
      ),

      errorColor: MyColors.errorColor,
      primaryIconTheme:
          const IconThemeData(color: MyColors.primaryColor, size: 24),

      // Text
      primaryTextTheme: const TextTheme(
        bodyText1: TextStyle(
          fontFamily: MyTheme.crimsonPro,
          color: Colors.white,
          fontSize: Dimens.size15,
          fontWeight: FontWeight.w300,
        ),
      ),
      textTheme: const TextTheme(
        headline1: TextStyle(
          fontFamily: MyTheme.crimsonPro,
          color: Colors.white,
          fontSize: Dimens.size22,
          fontWeight: FontWeight.w700,
        ),
        headline6: TextStyle(
            fontFamily: MyTheme.din,
            fontSize: Dimens.size18,
            fontWeight: FontWeight.bold,
            color: Colors.black),
        subtitle1: TextStyle(
            fontFamily: MyTheme.crimsonPro,
            fontSize: Dimens.size14,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
            color: Colors.black),
        subtitle2: TextStyle(
            fontFamily: MyTheme.crimsonPro,
            fontSize: Dimens.size16,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
            color: Colors.black),
        bodyText1: TextStyle(
          fontFamily: crimsonPro,
          color: Colors.black,
          fontSize: Dimens.textSize16,
          fontWeight: FontWeight.w700,
        ),
        bodyText2: TextStyle(
            fontFamily: MyTheme.roboto,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            color: Colors.black,
            fontSize: Dimens.size14),
        button: TextStyle(
            fontFamily: MyTheme.din,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            fontSize: Dimens.size20),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      backgroundColor: MyColors.black,
      primaryColor: MyColors.primaryColor,
      colorScheme: const ColorScheme(
        secondary: MyColors.secondaryColor,
        primary: MyColors.primaryColor,
        background: MyColors.black,
        brightness: Brightness.light,
        error: MyColors.errorColor,
        onBackground: MyColors.backgroundColor,
        onError: MyColors.errorColor,
        onPrimary: MyColors.primaryColor,
        onSecondary: MyColors.secondaryColor,
        onSurface: MyColors.blackSurface,
        surface: MyColors.blackSurface,
      ),
      errorColor: MyColors.errorColor,
      dividerColor: Colors.white,
      primaryIconTheme:
          const IconThemeData(color: MyColors.primaryColor, size: 24),

      // Text
      primaryTextTheme: const TextTheme(
        bodyText1: TextStyle(
          fontFamily: crimsonPro,
          color: Colors.white,
          fontSize: Dimens.size15,
          fontWeight: FontWeight.w300,
        ),
      ),
      textTheme: const TextTheme(
        headline1: TextStyle(
          fontFamily: crimsonPro,
          color: Colors.white,
          fontSize: Dimens.size22,
          fontWeight: FontWeight.w700,
        ),
        headline6: TextStyle(
            fontFamily: crimsonPro,
            fontSize: Dimens.size17,
            fontWeight: FontWeight.bold,
            color: Colors.black),
        bodyText1: TextStyle(
          fontFamily: din,
          color: Colors.black,
          fontSize: Dimens.textSize14,
          fontWeight: FontWeight.w700,
        ),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }
}
