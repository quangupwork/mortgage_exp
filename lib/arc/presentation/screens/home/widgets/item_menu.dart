import 'package:flutter/material.dart';
import 'package:mortgage_exp/src/constants.dart';

import '../../../../../src/styles/style.dart';

class ItemMenu extends StatelessWidget {
  final String icon;
  final String title;
  final String subTitle;
  final VoidCallback onTap;
  const ItemMenu({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
    required this.subTitle,
  }) : super(key: key);

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
            Row(
              children: [
                const SizedBox(width: Dimens.size6),
                FittedBox(
                  fit: BoxFit.contain,
                  child: Center(
                    child: Image.asset(
                      icon,
                      color: theme.backgroundColor,
                      height: Dimens.size40,
                      width: Dimens.size40,
                    ),
                  ),
                ),
                const SizedBox(width: Dimens.size6),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FittedBox(
                        child: Text(title, style: theme.textTheme.headline6),
                      ),
                      FittedBox(
                        child: Text(subTitle, style: theme.textTheme.subtitle1),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: Dimens.size4),
                child: Image.asset(
                  ImageAssetPath.icArrow,
                  color: Colors.white,
                  height: Dimens.size20,
                  width: Dimens.size20,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 4,
                color: theme.backgroundColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
