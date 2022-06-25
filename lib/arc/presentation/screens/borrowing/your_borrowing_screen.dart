import 'package:flutter/material.dart';
import 'package:mortgage_exp/arc/presentation/screens/borrowing/widgets/pie_chart.dart';
import 'package:mortgage_exp/arc/presentation/widgets/commons/footer_widget.dart';
import 'package:mortgage_exp/src/extensions/extension.dart';

import '../../../../src/constants.dart';
import '../../../../src/styles/style.dart';
import '../../widgets/commons/custom_app_bar.dart';
import '../home/widgets/button_widget.dart';

class YourBorrowingScreen extends StatefulWidget {
  final double canBorrow;
  final double monthlyIncome;
  final double otherRepayment;
  final double livingExpreses;
  final double remaining;
  final double mortgageRepayment;
  const YourBorrowingScreen({
    Key? key,
    required this.canBorrow,
    required this.monthlyIncome,
    required this.otherRepayment,
    required this.livingExpreses,
    required this.remaining,
    required this.mortgageRepayment,
  }) : super(key: key);

  @override
  State<YourBorrowingScreen> createState() => _YourBorrowingScreenState();
}

class _YourBorrowingScreenState extends State<YourBorrowingScreen> {
  final formatter = NumberFormat('\$###,###');
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        backgroundColor: theme.primaryColor,
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar.withLeading(title: "Your Borrowing Power"),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.size40),
                children: [
                  const SizedBox(height: Dimens.size14),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: Dimens.size10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: const Color(0xffd8d7d5))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: Dimens.size14),
                        Image.asset(ImageAssetPath.icYourPayment,
                            color: theme.backgroundColor,
                            height: Dimens.size40,
                            width: Dimens.size30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Flexible(
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: Text("You can borrow up to",
                                    style: theme.textTheme.s22w800().copyWith(
                                          fontWeight: FontWeight.bold,
                                        )),
                              ),
                            ),
                            Flexible(
                              child: Text(formatter.format(widget.canBorrow),
                                  style: theme.textTheme
                                      .s28bold()
                                      .copyWith(fontWeight: FontWeight.w800)),
                            ),
                          ],
                        ),
                        const SizedBox(height: Dimens.size24),
                      ],
                    ),
                  ),
                  const SizedBox(height: Dimens.size14),
                  ChartWidget(
                    remaining: widget.remaining,
                    livingExpreses: widget.livingExpreses,
                    monthlyIncome: widget.monthlyIncome,
                    mortgageRepayment: widget.mortgageRepayment,
                    otherRepayment: widget.otherRepayment,
                  ),
                  const SizedBox(height: Dimens.size14),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimens.size10, vertical: Dimens.size20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: const Color(0xffd8d7d5))),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Image.asset(ImageAssetPath.icLogo),
                        ),
                        const SizedBox(width: Dimens.size20),
                        Expanded(
                          flex: 3,
                          child: Text(
                              "Calculations are approximation only and should not be regarded as being final. The figures will vary depending upon fees, charges and calculation methodology used by the lender. To know accurately how much you can borrow please call or email us now.",
                              maxLines: 50,
                              textAlign: TextAlign.start,
                              style: theme.textTheme.s16w700black()),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: Dimens.size14),
                  const ButtonWidget(),
                  const SizedBox(height: Dimens.size80),
                ],
              ),
            ),
            const FooterWidget(hasPadding: true),
          ],
        ));
  }
}
