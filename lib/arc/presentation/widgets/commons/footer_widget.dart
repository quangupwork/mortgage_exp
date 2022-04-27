import 'package:flutter/material.dart';
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
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: hasPadding
          ? const EdgeInsets.symmetric(horizontal: Dimens.size40)
          : EdgeInsets.zero,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: _termAndCondition,
                  child: Text("Terms and Conditions",
                      style: theme.textTheme.subtitle2)),
              GestureDetector(
                  onTap: _privacyStatement,
                  child: Text("Privacy Statement",
                      style: theme.textTheme.subtitle2)),
            ],
          ),
          if (hasURL) const SizedBox(height: Dimens.size14),
          if (hasURL)
            GestureDetector(
                onTap: _onPrivacy,
                child: Text("www.mortgage-express.co.nz",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.subtitle2)),
          const SizedBox(height: Dimens.size10),
        ],
      ),
    );
  }

  Future<void> _termAndCondition() async {
    const url = "https://www.mortgage-express.co.nz/legal";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not launch $url";
    }
  }

  Future<void> _privacyStatement() async {
    const url = "https://www.mortgage-express.co.nz/privacy-statement";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not launch $url";
    }
  }

  Future<void> _onPrivacy() async {
    const url = "https://www.mortgage-express.co.nz";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not launch $url";
    }
  }
}
