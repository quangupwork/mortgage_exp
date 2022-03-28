import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mortgage_exp/src/config/my_theme.dart';
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
    this.color = const Color(0xff434c57),
  })  : hasLeading = true,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
        backgroundColor: color,
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
