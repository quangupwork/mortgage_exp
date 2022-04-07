import 'package:flutter/material.dart';

class NavigationService {
  GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  static NavigationService instance = NavigationService();

  ///Push page without context
  Future<Object?>? pushNamed(String routeName, {Object? arguments}) {
    return navigationKey.currentState
        ?.pushNamed(routeName, arguments: arguments);
  }

  Future<Object?>? pushNamedAndRemoveUntil(String routeName,
      {Object? arguments, bool predicate = false}) {
    return navigationKey.currentState?.pushNamedAndRemoveUntil(
      routeName,
      (Route<dynamic> route) => predicate,
      arguments: arguments,
    );
  }

  pop() {
    return navigationKey.currentState?.pop();
  }

  push(BuildContext rootContext, Widget child) {
    return Navigator.of(rootContext).push(
      MaterialPageRoute(
        builder: (context) {
          return child;
        },
      ),
    );
  }

  canPop() {
    return navigationKey.currentState?.canPop();
  }
}
