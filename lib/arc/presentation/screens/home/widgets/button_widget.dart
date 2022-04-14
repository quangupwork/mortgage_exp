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
            onTap: () => launch("tel://0800226226"),
            text: 'Call Now',
            icon: ImageAssetPath.icCall,
          ),
        ),
        const SizedBox(width: Dimens.size4),
        Expanded(
          child: CustomButton(
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
            text: 'Email Now',
            icon: ImageAssetPath.icEmail,
          ),
        ),
      ],
    );
  }
}
