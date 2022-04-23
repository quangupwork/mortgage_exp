import 'package:flutter/material.dart';
import 'package:mortgage_exp/src/styles/style.dart';

class CustomTextfield extends StatelessWidget {
  final double? paddingHor;
  final double? paddingVer;
  final double? textfieldHeight;
  final bool? obscureText;
  final String? hindText;
  final Color? color;
  final bool? enabled;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final VoidCallback? showHideVoid;
  final TextEditingController? controller;
  final Function(String)? onChange;
  final String? preIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  const CustomTextfield({
    Key? key,
    this.paddingHor,
    this.paddingVer,
    this.textfieldHeight,
    this.obscureText,
    this.hindText,
    this.color,
    this.enabled = true,
    this.textInputAction,
    this.keyboardType,
    this.showHideVoid,
    this.controller,
    this.onChange,
    this.preIcon,
    this.suffixIcon,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: paddingHor ?? Dimens.size25,
          vertical: paddingVer ?? Dimens.size7),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).dividerColor,
        ),
        child: TextFormField(
          validator: validator,
          controller: controller,
          keyboardType: keyboardType ?? TextInputType.text,
          cursorColor: Colors.white,
          onChanged: onChange,
          enabled: enabled,
          textAlignVertical: TextAlignVertical.center,
          textInputAction: textInputAction ?? TextInputAction.next,
          obscureText: obscureText ?? false,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            errorStyle: theme.textTheme.bodyText1,
            hintStyle: theme.textTheme.bodyText1,
            prefix: const Text("\u0024"),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(Dimens.size10),
          ),
        ),
      ),
    );
  }
}
