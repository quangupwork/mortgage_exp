import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mortgage_exp/src/config/config.dart';
import 'package:mortgage_exp/src/styles/colors.dart';
import 'package:mortgage_exp/src/styles/dimens.dart';

/// Ex:
/// import '~/text_theme_extension.dart';
///
/// final theme = Theme.of(context);
/// theme.customStyle();

extension ThemeExtension on TextTheme {
  TextStyle customStyle({bool? isLightMode, Color? color}) {
    final bool _isLightMode =
        SchedulerBinding.instance?.window.platformBrightness ==
            Brightness.light;
    final isLight = isLightMode ?? _isLightMode;
    return TextStyle(
      fontFamily: MyTheme.crimsonPro,
      color: isLight ? MyColors.black : MyColors.black,
      fontSize: Dimens.textSize12,
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle styleTextFields({bool? isLightMode, Color? color}) {
    final bool _isLightMode =
        SchedulerBinding.instance?.window.platformBrightness ==
            Brightness.light;
    final isLight = isLightMode ?? _isLightMode;
    return const TextStyle(
      fontFamily: MyTheme.roboto,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      color: Color.fromRGBO(141, 117, 93, 1),
      fontSize: Dimens.size16,
    );
  }

  TextStyle styleButtonEnable({bool? isLightMode, Color? color}) {
    final bool _isLightMode =
        SchedulerBinding.instance?.window.platformBrightness ==
            Brightness.light;
    final isLight = isLightMode ?? _isLightMode;
    return const TextStyle(
      fontFamily: MyTheme.roboto,
      fontWeight: FontWeight.w700,
      color: Color(0xff424c58),
      fontSize: Dimens.size14,
    );
  }

  TextStyle styleButtonDisable({bool? isLightMode, Color? color}) {
    final bool _isLightMode =
        SchedulerBinding.instance?.window.platformBrightness ==
            Brightness.light;
    final isLight = isLightMode ?? _isLightMode;
    return const TextStyle(
      fontWeight: FontWeight.w500,
      color: Color(0xff808080),
      fontSize: Dimens.size14,
    );
  }

  TextStyle s22w800({bool? isLightMode, Color? color}) {
    final bool _isLightMode =
        SchedulerBinding.instance?.window.platformBrightness ==
            Brightness.light;
    final isLight = isLightMode ?? _isLightMode;
    return const TextStyle(
      fontFamily: MyTheme.din,
      fontWeight: FontWeight.w800,
      color: Color.fromRGBO(66, 76, 88, 1),
      fontSize: Dimens.size20,
    );
  }

  TextStyle s28bold({bool? isLightMode, Color? color}) {
    final bool _isLightMode =
        SchedulerBinding.instance?.window.platformBrightness ==
            Brightness.light;
    final isLight = isLightMode ?? _isLightMode;
    return const TextStyle(
      fontFamily: MyTheme.din,
      fontWeight: FontWeight.bold,
      color: Color(0xff424c58),
      fontSize: Dimens.size28,
    );
  }

  TextStyle s12w800({bool? isLightMode, Color? color}) {
    final bool _isLightMode =
        SchedulerBinding.instance?.window.platformBrightness ==
            Brightness.light;
    final isLight = isLightMode ?? _isLightMode;
    return const TextStyle(
      fontFamily: MyTheme.din,
      fontWeight: FontWeight.w800,
      color: Color(0xff424c58),
      fontSize: Dimens.size12,
    );
  }

  TextStyle s14w600({bool? isLightMode, Color? color}) {
    final bool _isLightMode =
        SchedulerBinding.instance?.window.platformBrightness ==
            Brightness.light;
    final isLight = isLightMode ?? _isLightMode;
    return const TextStyle(
        fontFamily: MyTheme.din,
        fontWeight: FontWeight.w600,
        color: Color(0xff424c58),
        fontSize: Dimens.size14);
  }

  TextStyle styleAppBar({bool? isLightMode, Color? color}) {
    final bool _isLightMode =
        SchedulerBinding.instance?.window.platformBrightness ==
            Brightness.light;
    final isLight = isLightMode ?? _isLightMode;
    return const TextStyle(
        fontFamily: MyTheme.din,
        fontSize: Dimens.size22,
        fontWeight: FontWeight.w700,
        color: Colors.white);
  }

  TextStyle error({bool? isLightMode, Color? color}) {
    final bool _isLightMode =
        SchedulerBinding.instance?.window.platformBrightness ==
            Brightness.light;
    final isLight = isLightMode ?? _isLightMode;
    return const TextStyle(
        fontFamily: MyTheme.roboto,
        fontSize: Dimens.size12,
        fontWeight: FontWeight.w400,
        color: Colors.red);
  }
}
