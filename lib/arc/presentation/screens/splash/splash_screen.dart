import 'package:flutter/material.dart';
import 'package:mortgage_exp/src/config/config.dart';
import 'package:mortgage_exp/src/constants.dart';

import '../../../../injector.dart';
import '../../../../src/utilities/utilities.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final navigator = AppDependencies.injector.get<NavigationService>();

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 1),
      () => navigator.pushNamed(RouteKey.home),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: Center(
        child: Image.asset(
          ImageAssetPath.icLogo,
          height: size.width / 1.2,
          width: size.width / 1.2,
        ),
      ),
    );
  }
}
