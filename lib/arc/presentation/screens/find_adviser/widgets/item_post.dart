import 'package:flutter/material.dart';
import 'package:mortgage_exp/arc/data/models/data_models/data_models.dart';
import 'package:mortgage_exp/src/config/route_keys.dart';
import 'package:mortgage_exp/src/extensions/extension.dart';
import 'package:mortgage_exp/src/helper/filter_conver.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../injector.dart';
import '../../../../../src/constants.dart';
import '../../../../../src/helper/html_helper.dart';
import '../../../../../src/styles/style.dart';
import '../../../../../src/utilities/utilities.dart';
import '../../../widgets/widget.dart';

class ItemPost extends StatelessWidget {
  final PostModel postModel;
  const ItemPost({
    Key? key,
    required this.postModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimens.size10, vertical: Dimens.size10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xffd8d7d5))),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: CachedImage(
                imageUrl: postModel.featuredImage ?? '',
                height: 120,
                width: size.width),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(postModel.name ?? '',
                    maxLines: 3,
                    style: theme.textTheme.s14w600().copyWith(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        )),
                const SizedBox(height: 2),
                Text("Mortgage Adviser",
                    style: theme.textTheme
                        .s16w700black()
                        .copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                _ItemInfo(
                  onTap: () => launch(
                      "tel://${HTMLHelper.parsePhoneFromHTML(postModel.postSummary ?? '')}"),
                  icon: ImageAssetPath.icCall,
                  text: HTMLHelper.parsePhoneFromHTML(
                      postModel.postSummary ?? ''),
                ),
                const SizedBox(height: 2),
                _ItemInfo(
                  onTap: () async {
                    final Uri params = Uri(
                      scheme: 'mailto',
                      path: HTMLHelper.parseEmailFromHTML(
                          postModel.postSummary ?? ''),
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
                  icon: ImageAssetPath.icEmail,
                  text: HTMLHelper.parseEmailFromHTML(
                      postModel.postSummary ?? ''),
                ),
                const SizedBox(height: 4),
                GestureDetector(
                    onTap: () {
                      final navigator =
                          AppDependencies.injector.get<NavigationService>();
                      navigator.pushNamed(
                        RouteKey.pdfView,
                        arguments: FilterConverter.filterDocument(
                            '(${postModel.name})'),
                      );
                    },
                    child: const Text('Important information',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue))),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _ItemInfo extends StatelessWidget {
  final String icon;
  final String text;
  final VoidCallback onTap;
  const _ItemInfo({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(icon,
              height: 30, width: 30, color: const Color(0xff8b745d)),
          const SizedBox(width: Dimens.size10),
          Flexible(
            child: Text(text, style: theme.textTheme.s14w700(), maxLines: 2),
          ),
        ],
      ),
    );
  }
}
