import 'package:get_it/get_it.dart';

import 'package:mortgage_exp/src/network/network.dart';
import 'package:mortgage_exp/src/utilities/utilities.dart';
import '/src/preferences/app_preference.dart';

class AppDependencies {
  static GetIt get injector => GetIt.I;

  static Future<void> initialize() async {
    _initRequest();
    _initServices();
    _initBlocs();
    injector.registerLazySingleton<AppPreference>(() => AppPreference());
    injector.registerLazySingleton<AppClient>(() => AppClient());
    injector
        .registerLazySingleton<NavigationService>(() => NavigationService());
  }

  static void _initRequest() {}

  static void _initServices() {}

  static void _initBlocs() {}
}
