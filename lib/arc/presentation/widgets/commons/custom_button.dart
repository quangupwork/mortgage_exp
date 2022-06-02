import 'package:flutter/material.dart';
import 'package:mortgage_exp/src/styles/style.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final String? icon;
  final VoidCallback onTap;
  final double height;
  final double? width;
  const CustomButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.icon,
    this.height = Dimens.size45,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: Dimens.size10),
          width: width ?? MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(color: MyColors.colorButton),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon?.isNotEmpty ?? false)
                Flexible(
                  child: Image.asset(icon!,
                      height: Dimens.size34,
                      color: theme.backgroundColor,
                      width: Dimens.size34,
                      fit: BoxFit.scaleDown),
                ),
              if (icon?.isNotEmpty ?? false)
                const SizedBox(width: Dimens.size6),
              Flexible(
                flex: 3,
                child: Center(
                    child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(text!,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.button),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
