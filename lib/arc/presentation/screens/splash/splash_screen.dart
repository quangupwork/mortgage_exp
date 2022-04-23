import 'package:flutter/material.dart';
import 'package:mortgage_exp/arc/presentation/blocs/blocs.dart';
import 'package:mortgage_exp/src/config/config.dart';
import 'package:mortgage_exp/src/constants.dart';

import '../../../../injector.dart';
import '../../../../src/base_widget_state/base_widget_state.dart';
import '../../../../src/bloc/base.dart';
import '../../../../src/utilities/utilities.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends IStateful<SplashBloc, SplashScreen> {
  final navigator = AppDependencies.injector.get<NavigationService>();

  @override
  void initState() {
    super.initState();
    bloc.add(SplashLoadEvent());
  }

  @override
  void listener(BuildContext context, IBaseState state) async {
    super.listener(context, state);
    if (state is SplashLoadedState) {
      Future.delayed(
        const Duration(seconds: 1),
        () => navigator.pushNamedAndRemoveUntil(RouteKey.home),
      );
    }
  }

  @override
  Widget buildContent(BuildContext context, {IBaseState? state}) {
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
