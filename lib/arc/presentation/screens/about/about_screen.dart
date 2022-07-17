import 'package:flutter/material.dart';
import 'package:mortgage_exp/arc/presentation/widgets/commons/footer_widget.dart';
import 'package:mortgage_exp/src/constants.dart';
import 'package:mortgage_exp/src/extensions/extension.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../src/styles/style.dart';
import '../../widgets/widget.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 350 ? true : false;
    return Scaffold(
      backgroundColor: theme.primaryColor,
      appBar: CustomAppBar.withLeading(title: "About Us"),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: [
                const SizedBox(height: Dimens.size20),
                Center(
                    child: Image.asset(
                  ImageAssetPath.icLogo,
                  height: size.height * 0.1,
                  width: size.width / 2.5,
                )),
                const SizedBox(height: Dimens.size20),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: isSmall ? Dimens.size20 : Dimens.size40),
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.size10, vertical: Dimens.size14),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xffd8d7d5))),
                  child: Text(
                      """Mortgage Express branded mortgage advisers have been helping borrowers get finance to buy first homes, downsize or upsize existing homes, and grow property investment portfolios for over 20 years.

Our team works hard to match up your property goals with a mortgage to suit, providing a one-stop financial service that covers home loans and insurance for home, contents, vehicle and life.

With access to a panel of more than 30 bank and non-bank lenders, we offer more choice and more lending options, managing the mortgage process from pre-approval to settlement.""",
                      maxLines: 50,
                      textAlign: TextAlign.start,
                      style: theme.textTheme.s16w700black()),
                ),
                const SizedBox(height: Dimens.size40),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: isSmall ? Dimens.size20 : Dimens.size40),
                  child: Text('Contact Us:',
                      style: theme.textTheme
                          .s16w700black()
                          .copyWith(fontWeight: FontWeight.w700, fontSize: 16)),
                ),
                const SizedBox(height: Dimens.size14),
                _ItemContact(
                  icon: ImageAssetPath.icCall,
                  onTap: () => launchCaller(Constants.phone),
                  text: '${Constants.phone} (Free phone)',
                ),
                const SizedBox(height: Dimens.size10),
                _ItemContact(
                  icon: ImageAssetPath.icEmail,
                  onTap: () => makeEmail(Constants.email),
                  text: Constants.email,
                ),
                const SizedBox(height: Dimens.size40),
              ],
            ),
          ),
          const FooterWidget(hasPadding: true)
        ],
      ),
    );
  }

  Future<void> makeEmail(String email) async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: encodeQueryParameters(<String, String>{
        'subject': 'Regarding My Home Loan',
        'body':
            'Hi\n\nI would like to discuss my home loan options. Below are my contact details\n\nName:\nMobile Number\nBest Time To Contact:\n\nPlease get in touch\n\nRegards',
      }),
    );
    launchUrl(emailLaunchUri);
  }

  Future<bool> launchCaller(String? number) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: number,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
      return true;
    }
    return false;
  }
}

class _ItemContact extends StatelessWidget {
  final String text;
  final String icon;
  final VoidCallback onTap;
  const _ItemContact({
    Key? key,
    required this.text,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 350 ? true : false;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: isSmall ? Dimens.size20 : Dimens.size40),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: Dimens.size45,
          padding: const EdgeInsets.symmetric(horizontal: Dimens.size10),
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(color: MyColors.colorButton),
          child: Row(
            children: [
              Image.asset(icon,
                  height: Dimens.size34,
                  color: theme.backgroundColor,
                  width: Dimens.size34,
                  fit: BoxFit.scaleDown),
              const SizedBox(width: 10),
              FittedBox(
                child: Text(text,
                    style: Theme.of(context).textTheme.s16w700white()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
