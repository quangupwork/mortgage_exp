import 'package:device_preview/device_preview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mortgage_exp/app_bloc.dart';

import '../my_app.dart';
import '../src/config/app_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../src/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.instance.configApp();

  Bloc.observer = AppBlocObserver();

  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: Constants.languages,
      startLocale: Constants.languages[0],
      fallbackLocale: Constants.languages[0],
      child: const MyApp(),
    ),
  );
}
