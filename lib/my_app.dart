import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:mortgage_exp/injector.dart';
import 'package:mortgage_exp/src/preferences/app_preference.dart';
import 'package:mortgage_exp/src/utilities/navigator_service.dart';
import '../src/constants.dart';

import 'src/config/config.dart';
import 'src/preferences/app_preference.dart';

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: MaterialApp(
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        onGenerateInitialRoutes: (_) => AppRoutes.onGenerateInitialRoute(),
        debugShowCheckedModeBanner: false,
        title: Constants.appName,
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        navigatorKey:
            AppDependencies.injector.get<NavigationService>().navigationKey,
        builder: (context, Widget? child) {
          final isSmall =
              MediaQuery.of(context).size.width < 350 ? true : false;
          return MediaQuery(
            child: child ?? const SizedBox(),
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: isSmall ? 0.8 : 1,
            ),
          );
        },
        theme: MyTheme.lightTheme(),
        //  darkTheme: MyTheme.darkTheme(),
        //   themeMode: ThemeMode.system,
      ),
    );
  }
}
