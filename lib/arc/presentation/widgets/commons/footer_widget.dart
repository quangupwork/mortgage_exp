import 'package:flutter/material.dart';
import 'package:mortgage_exp/arc/presentation/widgets/commons/bottom_space.dart';

import '../../../../src/styles/style.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Disclaimer',
                              style: Theme.of(context).textTheme.headline5),
                          content: Text(
                            'Whilst every effort has been made to ensure the accuracy of the calculators the results should be used as an indication only. They are not a quote or a pre qualification for the home loan. The calculators are not intended to be a substitue for professional financial advice',
                            style: theme.textTheme.bodyMedium,
                          ),
                          actions: <Widget>[
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('OK',
                                    style: theme.textTheme.bodyMedium)),
                          ],
                        );
                      });
                },
                child: Text("Disclaimer", style: theme.textTheme.subtitle2)),
            GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Disclosure',
                              style: Theme.of(context).textTheme.headline5),
                          content: Text(
                            'A disclosure statement relating to the advisers associated with this app are available on request and free of charge',
                            style: theme.textTheme.bodyMedium,
                          ),
                          actions: <Widget>[
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('OK',
                                    style: theme.textTheme.bodyMedium)),
                          ],
                        );
                      });
                },
                child: Text("Disclosure", style: theme.textTheme.subtitle2)),
          ],
        ),
        const BottomSpace()
      ],
    );
  }
}
