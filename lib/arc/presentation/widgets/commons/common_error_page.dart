import 'package:flutter/material.dart';

import '../../../../src/styles/style.dart';
import '../../../../translation_key.dart';

class CommonErrorPage extends StatelessWidget {
  const CommonErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: Dimens.size24),
        Text(TranslationKey.errorCommon.tr()),
        const SizedBox(height: Dimens.size40),
      ],
    );
  }
}
