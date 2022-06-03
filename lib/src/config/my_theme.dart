import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../styles/style.dart';

class MyTheme {
  static const String sourceSans = 'SourceSans';
  static const String sourceSansSemi = 'SourceSansSemi';
  final bool _isLightMode =
      SchedulerBinding.instance!.window.platformBrightness == Brightness.light;

  bool get isLightMode => _isLightMode;

  static ThemeData lightTheme() {
    return ThemeData(
      fontFamily: sourceSans,
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
          fontFamily: MyTheme.sourceSans,
          color: Colors.white,
          fontSize: Dimens.size15,
          fontWeight: FontWeight.w300,
        ),
        bodyText2: TextStyle(
          fontFamily: MyTheme.sourceSansSemi,
          color: Colors.black,
          fontSize: Dimens.size15,
          fontWeight: FontWeight.w500,
        ),
      ),
      textTheme: const TextTheme(
        headline1: TextStyle(
          fontFamily: MyTheme.sourceSans,
          color: Colors.white,
          fontSize: Dimens.size22,
          fontWeight: FontWeight.w700,
        ),
        headline6: TextStyle(
            fontFamily: MyTheme.sourceSans,
            fontSize: Dimens.size18,
            fontWeight: FontWeight.bold,
            color: Colors.white),
        subtitle1: TextStyle(
            fontFamily: MyTheme.sourceSans,
            fontSize: Dimens.size14,
            fontWeight: FontWeight.w500,
            color: Colors.white),
        subtitle2: TextStyle(
            fontFamily: MyTheme.sourceSans,
            fontSize: Dimens.size15,
            fontWeight: FontWeight.w400,
            color: Colors.black),
        bodyText1: TextStyle(
          fontFamily: sourceSans,
          color: Colors.black,
          fontSize: Dimens.textSize16,
          fontWeight: FontWeight.w700,
        ),
        bodyText2: TextStyle(
            fontFamily: MyTheme.sourceSans,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            color: Colors.black,
            fontSize: Dimens.size14),
        button: TextStyle(
            fontFamily: MyTheme.sourceSans,
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
          fontFamily: sourceSans,
          color: Colors.white,
          fontSize: Dimens.size15,
          fontWeight: FontWeight.w300,
        ),
      ),
      textTheme: const TextTheme(
        headline1: TextStyle(
          fontFamily: sourceSans,
          color: Colors.white,
          fontSize: Dimens.size22,
          fontWeight: FontWeight.w700,
        ),
        headline6: TextStyle(
            fontFamily: sourceSans,
            fontSize: Dimens.size17,
            fontWeight: FontWeight.bold,
            color: Colors.black),
        bodyText1: TextStyle(
          fontFamily: sourceSans,
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
