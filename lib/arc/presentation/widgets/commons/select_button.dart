import 'package:flutter/material.dart';
import 'package:mortgage_exp/src/extensions/extension.dart';

import '../../../../../src/styles/style.dart';

class SelectButton extends StatelessWidget {
  final bool status;
  final String text;
  final VoidCallback onTap;
  const SelectButton({
    Key? key,
    required this.status,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: Dimens.size50,
        width: size.width,
        child: Stack(
          children: [
            Container(
              height: Dimens.size50,
              width: size.width,
              color: status ? MyColors.colorButton : const Color(0xffF2F2F2),
              child: Center(
                child: Text(
                  text,
                  style: status
                      ? theme.textTheme.styleButtonEnable()
                      : theme.textTheme.styleButtonDisable(),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 2,
                color: status ? theme.backgroundColor : const Color(0xffCCCCCC),
              ),
            )
          ],
        ),
      ),
    );
  }
}
