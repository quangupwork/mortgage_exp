import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class BottomSpace extends StatelessWidget {
  const BottomSpace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return SizedBox(
          height:
              isKeyboardVisible ? MediaQuery.of(context).viewInsets.bottom : 0);
    });
  }
}
