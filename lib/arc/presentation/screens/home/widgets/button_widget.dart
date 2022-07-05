import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../src/constants.dart';
import '../../../../../src/styles/style.dart';
import '../../../widgets/commons/custom_button.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            onTap: () => launchCaller(Constants.phone),
            text: 'Call Now',
            icon: ImageAssetPath.icCall,
          ),
        ),
        const SizedBox(width: Dimens.size4),
        Expanded(
          child: CustomButton(
            onTap: () => makeEmail(Constants.email),
            text: 'Email Now',
            icon: ImageAssetPath.icEmail,
          ),
        ),
      ],
    );
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
}
