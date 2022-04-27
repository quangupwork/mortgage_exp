import 'package:flutter/material.dart';

import '../../../../injector.dart';
import '../../../../src/preferences/app_preference.dart';
import '../../../../src/utilities/utilities.dart';

final navigator = AppDependencies.injector.get<NavigationService>();
final appPreference = AppDependencies.injector.get<AppPreference>();
void showDialogWarnig({
  required BuildContext context,
  required String msg,
}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(
            msg,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () => Navigator.pop(context),
                child:
                    Text('OK', style: Theme.of(context).textTheme.bodyMedium)),
          ],
        );
      });
}
