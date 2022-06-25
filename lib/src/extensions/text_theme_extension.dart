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
      fontFamily: MyTheme.sourceSans,
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
      fontFamily: MyTheme.sourceSans,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
      color: MyColors.backgroundColor,
      fontSize: Dimens.size16,
    );
  }

  TextStyle s15w400({bool? isLightMode, Color? color}) {
    final bool _isLightMode =
        SchedulerBinding.instance?.window.platformBrightness ==
            Brightness.light;
    final isLight = isLightMode ?? _isLightMode;
    return const TextStyle(
      fontFamily: MyTheme.sourceSans,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: MyColors.black,
      fontSize: Dimens.size15,
    );
  }

  TextStyle styleBTabEnable({bool? isLightMode, Color? color}) {
    final bool _isLightMode =
        SchedulerBinding.instance?.window.platformBrightness ==
            Brightness.light;
    final isLight = isLightMode ?? _isLightMode;
    return const TextStyle(
      fontFamily: MyTheme.sourceSans,
      fontWeight: FontWeight.w700,
      height: 1.2,
      color: Colors.white,
      fontSize: Dimens.size15,
    );
  }

  TextStyle styleBTabDisable({bool? isLightMode, Color? color}) {
    final bool _isLightMode =
        SchedulerBinding.instance?.window.platformBrightness ==
            Brightness.light;
    final isLight = isLightMode ?? _isLightMode;
    return const TextStyle(
      fontFamily: MyTheme.sourceSans,
      fontWeight: FontWeight.w500,
      height: 1.2,
      color: Colors.white,
      fontSize: Dimens.size15,
    );
  }

  TextStyle styleButtonEnable({bool? isLightMode, Color? color}) {
    final bool _isLightMode =
        SchedulerBinding.instance?.window.platformBrightness ==
            Brightness.light;
    final isLight = isLightMode ?? _isLightMode;
    return const TextStyle(
      fontFamily: MyTheme.sourceSans,
      fontWeight: FontWeight.w700,
      color: Colors.white,
      fontSize: Dimens.size14,
    );
  }

  TextStyle styleButtonDisable({bool? isLightMode, Color? color}) {
    final bool _isLightMode =
        SchedulerBinding.instance?.window.platformBrightness ==
            Brightness.light;
    final isLight = isLightMode ?? _isLightMode;
    return const TextStyle(
      fontWeight: FontWeight.w600,
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
      fontFamily: MyTheme.sourceSans,
      fontWeight: FontWeight.w800,
      color: MyColors.dark,
      fontSize: Dimens.size20,
    );
  }

  TextStyle s14w700({bool? isLightMode, Color? color}) {
    final bool _isLightMode =
        SchedulerBinding.instance?.window.platformBrightness ==
            Brightness.light;
    final isLight = isLightMode ?? _isLightMode;
    return const TextStyle(
      fontFamily: MyTheme.sourceSans,
      fontWeight: FontWeight.w500,
      color: Colors.black,
      fontSize: Dimens.size14,
    );
  }

  TextStyle s16w700grey({bool? isLightMode, Color? color}) {
    final bool _isLightMode =
        SchedulerBinding.instance?.window.platformBrightness ==
            Brightness.light;
    final isLight = isLightMode ?? _isLightMode;
    return const TextStyle(
      fontFamily: MyTheme.sourceSans,
      fontWeight: FontWeight.w700,
      color: Color.fromRGBO(66, 76, 88, 1),
      fontSize: Dimens.size17,
    );
  }

  TextStyle s16w700white({bool? isLightMode, Color? color}) {
    final bool _isLightMode =
        SchedulerBinding.instance?.window.platformBrightness ==
            Brightness.light;
    final isLight = isLightMode ?? _isLightMode;
    return const TextStyle(
      fontFamily: MyTheme.sourceSans,
      fontWeight: FontWeight.w700,
      color: Colors.white,
      fontSize: Dimens.size17,
    );
  }

  TextStyle s16w700({bool? isLightMode, Color? color}) {
    final bool _isLightMode =
        SchedulerBinding.instance?.window.platformBrightness ==
            Brightness.light;
    final isLight = isLightMode ?? _isLightMode;
    return const TextStyle(
      fontFamily: MyTheme.sourceSans,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      fontSize: Dimens.size17,
    );
  }

  TextStyle s16w700black({bool? isLightMode, Color? color}) {
    final bool _isLightMode =
        SchedulerBinding.instance?.window.platformBrightness ==
            Brightness.light;
    final isLight = isLightMode ?? _isLightMode;
    return const TextStyle(
      fontFamily: MyTheme.sourceSans,
      fontWeight: FontWeight.w500,
      color: Colors.black,
      fontSize: Dimens.size16,
    );
  }

  TextStyle s16w800({bool? isLightMode, Color? color}) {
    final bool _isLightMode =
        SchedulerBinding.instance?.window.platformBrightness ==
            Brightness.light;
    final isLight = isLightMode ?? _isLightMode;
    return const TextStyle(
      fontFamily: MyTheme.sourceSans,
      fontWeight: FontWeight.w800,
      color: Color.fromRGBO(66, 76, 88, 1),
      fontSize: Dimens.size16,
    );
  }

  TextStyle s16w800normal({bool? isLightMode, Color? color}) {
    final bool _isLightMode =
        SchedulerBinding.instance?.window.platformBrightness ==
            Brightness.light;
    final isLight = isLightMode ?? _isLightMode;
    return const TextStyle(
      fontFamily: MyTheme.sourceSans,
      color: Color.fromRGBO(66, 76, 88, 1),
      fontSize: Dimens.size16,
    );
  }

  TextStyle s28bold({bool? isLightMode, Color? color}) {
    final bool _isLightMode =
        SchedulerBinding.instance?.window.platformBrightness ==
            Brightness.light;
    final isLight = isLightMode ?? _isLightMode;
    return const TextStyle(
      fontFamily: MyTheme.sourceSans,
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
      fontFamily: MyTheme.sourceSans,
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
        fontFamily: MyTheme.sourceSans,
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
        fontFamily: MyTheme.sourceSans,
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
        fontFamily: MyTheme.sourceSans,
        fontSize: Dimens.size12,
        fontWeight: FontWeight.w400,
        color: Colors.red);
  }
}
