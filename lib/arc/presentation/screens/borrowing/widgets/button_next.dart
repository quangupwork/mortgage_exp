import 'package:flutter/material.dart';
import 'package:mortgage_exp/src/constants.dart';

import '../../../../../src/styles/style.dart';

class ButtonNext extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool hasIcon;
  const ButtonNext({
    Key? key,
    required this.onTap,
    required this.text,
  })  : hasIcon = true,
        super(key: key);
  const ButtonNext.noIcon({
    Key? key,
    required this.onTap,
    required this.text,
  })  : hasIcon = false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Dimens.size50,
        color: MyColors.colorButton,
        child: Stack(
          children: [
            Center(
              child: Text(text,
                  style:
                      theme.textTheme.headline6?.copyWith(color: Colors.white)),
            ),
            if (hasIcon)
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: Dimens.size4),
                  child: Image.asset(
                    ImageAssetPath.icArrow,
                    height: Dimens.size20,
                    width: Dimens.size20,
                    color: Colors.white,
                  ),
                ),
              ),
            if (hasIcon)
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 4,
                  color: const Color(0xffe9ccb6),
                ),
              )
          ],
        ),
      ),
    );
  }
}
