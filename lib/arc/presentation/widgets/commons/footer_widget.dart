import 'package:flutter/material.dart';
import 'package:mortgage_exp/src/extensions/extension.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../src/styles/style.dart';

class FooterWidget extends StatelessWidget {
  final bool hasPadding;
  final bool hasURL;
  const FooterWidget({
    Key? key,
    this.hasPadding = false,
  })  : hasURL = false,
        super(key: key);
  const FooterWidget.withURL({
    Key? key,
    this.hasPadding = false,
  })  : hasURL = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 350 ? true : false;
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: hasPadding
          ? EdgeInsets.symmetric(
              horizontal: isSmall ? Dimens.size20 : Dimens.size40)
          : EdgeInsets.zero,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () =>
                      _openLink('https://www.mortgage-express.co.nz/legal'),
                  child: FittedBox(
                    child: Text(
                      "Terms and Conditions",
                      style: theme.textTheme.s15w400(),
                    ),
                  )),
              GestureDetector(
                  onTap: () => _openLink(
                      'https://www.mortgage-express.co.nz/privacy-statement'),
                  child: FittedBox(
                    child: Text(
                      "Privacy Statement",
                      style: theme.textTheme.s15w400(),
                    ),
                  )),
            ],
          ),
          if (hasURL) const SizedBox(height: Dimens.size10),
          if (hasURL)
            GestureDetector(
                onTap: () => _openLink('https://www.mortgage-express.co.nz'),
                child: Text(
                  "www.mortgage-express.co.nz",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.s15w400(),
                )),
          SizedBox(
              height: MediaQuery.of(context).viewPadding.bottom == 0
                  ? 10
                  : MediaQuery.of(context).viewPadding.bottom),
        ],
      ),
    );
  }

  Future<void> _openLink(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not launch $url";
    }
  }
}
