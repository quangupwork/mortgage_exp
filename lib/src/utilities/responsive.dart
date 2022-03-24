import 'package:flutter/material.dart';

import '../constants.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveLayout({
    Key? key,
    required this.mobile,
    this.tablet,
    this.desktop,
  }) : super(key: key);

  // This size work fine on my design, maybe you need some customization depends on your design

  // This isMobile, isTablet, isDesktop helep us later
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < Constants.kTabletBreakpoint;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < Constants.kDesktopBreakpoint &&
      MediaQuery.of(context).size.width >= Constants.kTabletBreakpoint;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= Constants.kDesktopBreakpoint;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isMobile(context)
          ? mobile
          : isTablet(context)
              ? tablet ?? mobile
              : desktop ?? mobile,
    );
  }
}
