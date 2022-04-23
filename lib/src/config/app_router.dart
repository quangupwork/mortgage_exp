import 'package:flutter/material.dart';
import 'package:mortgage_exp/arc/presentation/screens/about/about_screen.dart';
import 'package:mortgage_exp/arc/presentation/screens/borrowing/borrowing_power_screen.dart';
import 'package:mortgage_exp/arc/presentation/screens/borrowing/your_borrowing_screen.dart';
import 'package:mortgage_exp/arc/presentation/screens/find_adviser/filter_adviser.dart';
import 'package:mortgage_exp/arc/presentation/screens/find_adviser/find_adviser.dart';
import 'package:mortgage_exp/arc/presentation/screens/find_adviser/widgets/pdf_view.dart';
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
      case RouteKey.borrowingPower:
        return _materialRoute(const BorrowingPowerScreen());
      case RouteKey.yourBorrowingPower:
        final args = settings.arguments as Map;
        double canBorrow = args['canBorrow'];
        double livingExpreses = args['livingExpreses'];
        double monthlyIncome = args['monthlyIncome'];
        double otherRepayment = args['otherRepayment'];
        double mortgageRepayment = args['mortgageRepayment'];
        double remaining = args['remaining'];
        return _materialRoute(YourBorrowingScreen(
          canBorrow: canBorrow,
          livingExpreses: livingExpreses,
          monthlyIncome: monthlyIncome,
          otherRepayment: otherRepayment,
          mortgageRepayment: mortgageRepayment,
          remaining: remaining,
        ));
      case RouteKey.findAnAdvicer:
        return _materialRoute(const FindAdvicerScreen());
      case RouteKey.filterAdvicer:
        final args = settings.arguments as int;
        return _materialRoute(FilterAdviserScreen(selectedValue: args));
      case RouteKey.about:
        return _materialRoute(const AboutScreen());
      case RouteKey.pdfView:
        final args = settings.arguments as String;
        return _materialRoute(PDFViewScreen(url: args));
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
