import 'package:flutter/material.dart';
import 'package:mortgage_exp/src/config/my_theme.dart';
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
        color: Colors.white,
        child: Stack(
          children: [
            Row(
              children: [
                const SizedBox(width: Dimens.size6),
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Center(
                      child: Image.asset(
                        icon,
                        height: Dimens.size40,
                        width: Dimens.size40,
                      ),
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
                      const SizedBox(height: Dimens.size4),
                      Flexible(
                        child: FittedBox(
                            fit: BoxFit.contain,
                            child:
                                Text(title, style: theme.textTheme.headline6)),
                      ),
                      const SizedBox(height: Dimens.size2),
                      Flexible(
                        child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(subTitle,
                                style: theme.textTheme.subtitle1)),
                      ),
                      const SizedBox(height: Dimens.size4),
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
                  height: Dimens.size20,
                  width: Dimens.size20,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 2,
                color: const Color(0xffe9ccb6),
              ),
            )
          ],
        ),
      ),
    );
  }
}
