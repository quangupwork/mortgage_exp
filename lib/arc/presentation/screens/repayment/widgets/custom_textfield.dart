import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mortgage_exp/src/extensions/extension.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

import '../../../../../src/styles/style.dart';

class TextFieldCustom extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String prefixIcon;
  final String suffixIcon;
  final TextAlign textAlign;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  const TextFieldCustom({
    Key? key,
    required this.controller,
    this.hintText = '',
    this.prefixIcon = '',
    this.validator,
    this.suffixIcon = '',
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
        keyboardType: TextInputType.number,
        maxLines: 1,
        style: theme.textTheme.bodyText2,
        textAlignVertical: TextAlignVertical.center,
        textAlign: textAlign,
        onChanged: onChanged,
        inputFormatters: [ThousandsFormatter(allowFraction: true)],
        decoration: InputDecoration(
          filled: true,
          isDense: true,
          suffixIconConstraints: BoxConstraints(
              minWidth: suffixIcon == '' ? 0 : 10,
              minHeight: suffixIcon == '' ? 0 : 20),
          suffixIcon: suffixIcon == ''
              ? null
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: Dimens.size10),
                  child: Text(suffixIcon,
                      style: theme.textTheme.styleTextFields())),
          prefixIconConstraints: BoxConstraints(
              minWidth: prefixIcon == '' ? 0 : 10,
              minHeight: prefixIcon == '' ? 0 : 20),
          prefixIcon: prefixIcon == ''
              ? null
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: Dimens.size10),
                  child: Text(prefixIcon,
                      style: theme.textTheme.styleTextFields())),
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
              horizontal: Dimens.size10, vertical: Dimens.size10),
          hintText: hintText,
        ),
      ),
    );
  }
}
