import 'package:flutter/material.dart';
import 'package:mortgage_exp/src/extensions/extension.dart';

import '../../../../../src/styles/style.dart';

class ItemTab extends StatelessWidget {
  final String text;
  final bool status;
  final VoidCallback onTap;
  const ItemTab({
    Key? key,
    required this.text,
    required this.status,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: Dimens.size64,
        width: size.width,
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(text,
                textAlign: TextAlign.center,
                style: status
                    ? theme.textTheme.styleBTabEnable()
                    : theme.textTheme.styleBTabEnable()),
            const SizedBox(height: Dimens.size6),
            Container(
              height: 4,
              margin: const EdgeInsets.symmetric(horizontal: Dimens.size10),
              decoration: BoxDecoration(
                color: status ? theme.backgroundColor : Colors.transparent,
                borderRadius: BorderRadius.circular(1),
              ),
            )
          ],
        ),
      ),
    );
  }
}
