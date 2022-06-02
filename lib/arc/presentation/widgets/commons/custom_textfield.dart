import 'package:flutter/material.dart';
import 'package:mortgage_exp/src/extensions/extension.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

import '../../../../../src/styles/style.dart';

class TextFieldCustom extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String prefixIcon;
  final String suffixIcon;
  final bool isLeft;
  final TextAlign textAlign;
  final EdgeInsets padding;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final FocusNode focusNode;
  const TextFieldCustom({
    Key? key,
    required this.controller,
    this.hintText = '',
    this.prefixIcon = '',
    this.validator,
    this.isLeft = false,
    this.suffixIcon = '',
    required this.focusNode,
    this.padding = const EdgeInsets.symmetric(
        horizontal: Dimens.size10, vertical: Dimens.size10),
    this.textAlign = TextAlign.left,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: const Color(0xffd8d7d5))),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        maxLines: 1,
        style: theme.primaryTextTheme.bodyText2,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.left,
        onChanged: onChanged,
        cursorColor: Theme.of(context).backgroundColor,
        cursorWidth: 2,
        inputFormatters: [ThousandsFormatter(allowFraction: true)],
        decoration: InputDecoration(
          filled: true,
          isDense: true,
          suffixIconConstraints: BoxConstraints(
              minWidth: isLeft ? 0 : 30, minHeight: isLeft ? 0 : 30),
          suffixIcon: isLeft
              ? Padding(
                  padding: const EdgeInsets.only(left: Dimens.size10),
                  child: Text('    ', style: theme.textTheme.styleTextFields()))
              : null,
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          fillColor: Colors.white,
          contentPadding: padding,
          hintText: hintText,
        ),
      ),
    );
  }
}
