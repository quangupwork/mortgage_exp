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
    return Scaffold(
      backgroundColor: theme.primaryColor,
      appBar: CustomAppBar.withLeading(title: "About Us"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.size10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(child: Image.asset(ImageAssetPath.icLogo, height: 100)),
          const SizedBox(height: Dimens.size10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: Dimens.size40),
            padding: const EdgeInsets.symmetric(
                horizontal: Dimens.size10, vertical: Dimens.size14),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xffd8d7d5))),
            child: Text(
                "Mortgage Express Limited is engaged in the business of supporting Financial Advice Providers to access financial products, and to market and promote, their finance, mortgage and insurance broking and facilitation services.\n\nEvery Financial Advice Provider trades using the Mortgage Express brand and is authorised by the Financial Advice Provider licence held by Astute Financial Management Limited FSP641829.",
                maxLines: 50,
                textAlign: TextAlign.start,
                style: theme.textTheme.s16w700black()),
          ),
          const SizedBox(height: Dimens.size40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.size40),
            child: Text('Contact Us:',
                style: theme.textTheme
                    .s16w700black()
                    .copyWith(fontWeight: FontWeight.w700, fontSize: 16)),
          ),
          const SizedBox(height: Dimens.size14),
          _ItemContact(
              onTap: () => launch("tel://08002266226"),
              text: '08002266226 (Free phone)',
              icon: ImageAssetPath.icCall),
          const SizedBox(height: Dimens.size10),
          _ItemContact(
              onTap: () async {
                final Uri params = Uri(
                  scheme: 'mailto',
                  path: 'mortgages@mortgage-express.co.nz',
                  query:
                      'subject=Regarding My Home Loan&body=Hi\n\nI would like to discuss my home loan options. Below are my contact details\n\nName:\nMobile Number\nBest Time To Contact:\n\nPlease get in touch\n\nRegards', //add subject and body here
                );
                final url = params.toString();
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
              text: 'mortgages@mortgage-express.co.nz',
              icon: ImageAssetPath.icEmail),
          const Spacer(),
          const FooterWidget(hasPadding: true)
        ]),
      ),
    );
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.size40),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: Dimens.size45,
          padding: const EdgeInsets.symmetric(horizontal: Dimens.size10),
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(color: Color.fromRGBO(50, 55, 64, 1)),
          child: Row(
            children: [
              Image.asset(icon, height: 30, width: 30, color: Colors.white),
              const SizedBox(width: 10),
              Flexible(
                child: FittedBox(
                  child: Text(text,
                      style: Theme.of(context).textTheme.s16w700white()),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
