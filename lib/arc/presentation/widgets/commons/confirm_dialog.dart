import 'package:flutter/material.dart';
import 'package:mortgage_exp/src/extensions/text_theme_extension.dart';
import 'package:mortgage_exp/src/styles/style.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String descriptions;
  final VoidCallback onTap;

  const ConfirmDialog({
    Key? key,
    required this.title,
    required this.descriptions,
    required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: theme.backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(
            height: Dimens.size20,
          ),
          Text(
            title,
            // style: theme.textTheme.s20w700green1(),
          ),
          const SizedBox(
            height: Dimens.size20,
          ),
          Text(
            descriptions,
            //  style: theme.textTheme.s15w400green1(),
          ),
          const SizedBox(
            height: Dimens.size22,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: onTap,
                  child: Text(
                    "Yes",
                    //     style: theme.textTheme.s15w400green1(),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "No",
                    //   style: theme.textTheme.s15w400green1(),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
