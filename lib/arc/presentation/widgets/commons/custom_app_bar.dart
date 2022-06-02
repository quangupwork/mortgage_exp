import 'package:flutter/material.dart';
import 'package:mortgage_exp/src/extensions/extension.dart';
import 'package:mortgage_exp/src/styles/style.dart';

import '../../../../src/constants.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final List<Widget>? action;
  final bool hasLeading;
  final Color color;
  CustomAppBar({
    Key? key,
    this.title,
    this.leading,
    this.color = Colors.transparent,
    this.action,
  })  : hasLeading = false,
        super(key: key);
  CustomAppBar.withLeading({
    Key? key,
    this.title,
    this.leading,
    this.action,
    this.color = MyColors.colorButton,
  })  : hasLeading = true,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
        backgroundColor: color,
        elevation: 0,
        leading: hasLeading
            ? leading ??
                GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Container(
                          color: Colors.transparent,
                          height: Dimens.size50,
                          width: Dimens.size50,
                          child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Image.asset(ImageAssetPath.icBack,
                                  fit: BoxFit.cover,
                                  color: Colors.white,
                                  height: Dimens.size20,
                                  width: Dimens.size20))),
                    ))
            : const SizedBox.shrink(),
        centerTitle: true,
        title: Text(title ?? '', style: theme.textTheme.styleAppBar()),
        actions: action);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
