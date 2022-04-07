import 'package:flutter/material.dart';
import 'package:mortgage_exp/arc/presentation/screens/repayment/extra_repayment_screen.dart';
import 'package:mortgage_exp/arc/presentation/screens/screens.dart';
import 'package:mortgage_exp/src/config/config.dart';

import '../../arc/presentation/widgets/commons/common.dart';

class AppRoutes {
  static Route? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RouteKey.splash:
        return _materialRoute(const SplashScreen());
      case RouteKey.home:
        return _materialRoute(const HomeScreen());
      case RouteKey.repayment:
        return _materialRoute(const RepaymentScreen());
      case RouteKey.extraRepayment:
        return _materialRoute(const ExtraRepaymentScreen());
      default:
        return _materialRoute(const CommonErrorPage());
    }
  }

  static List<Route> onGenerateInitialRoute() {
    return [_materialRoute(const SplashScreen())];
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute<String>(builder: (_) => view);
  }
}
