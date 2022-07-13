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
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 350 ? true : false;
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
                      height: isSmall ? Dimens.size30 : Dimens.size40,
                      width: isSmall ? Dimens.size30 : Dimens.size40,
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
                      Text(
                        title,
                        style: isSmall
                            ? theme.textTheme.headline6
                                ?.copyWith(fontSize: Dimens.size17)
                            : theme.textTheme.headline6,
                      ),
                      Text(
                        subTitle,
                        style: isSmall
                            ? theme.textTheme.subtitle1
                                ?.copyWith(fontSize: Dimens.size12)
                            : theme.textTheme.subtitle1,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  ImageAssetPath.icArrow,
                  color: Colors.white,
                  height: Dimens.size20,
                  width: Dimens.size20,
                ),
              ],
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
