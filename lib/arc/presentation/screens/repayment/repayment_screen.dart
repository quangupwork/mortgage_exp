import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:mortgage_exp/arc/presentation/widgets/commons/common.dart';
import 'package:mortgage_exp/arc/presentation/widgets/commons/custom_app_bar.dart';
import 'package:mortgage_exp/src/config/my_theme.dart';
import 'package:mortgage_exp/src/constants.dart';
import 'package:mortgage_exp/src/extensions/extension.dart';
import 'package:mortgage_exp/src/styles/dimens.dart';

import '../../../../src/helper/convert_helper.dart';
import 'widgets/custom_textfield.dart';
import 'widgets/select_button.dart';
import 'widgets/slider.dart';

class RepaymentScreen extends StatefulWidget {
  const RepaymentScreen({Key? key}) : super(key: key);

  @override
  State<RepaymentScreen> createState() => _RepaymentScreenState();
}

class _RepaymentScreenState extends State<RepaymentScreen> {
  bool isWeekly = true;
  bool isFortnightly = false;
  bool isMonthly = false;
  bool isBoth = true;
  bool isInterest = false;
  final loadAmountController = TextEditingController();
  final interesetRateController = TextEditingController();
  final loadTernController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadAmountController.text = '650,000';
    interesetRateController.text = '2,5';
    loadTernController.text = '29';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      appBar: CustomAppBar.withLeading(title: "Repayments"),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.size40),
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: Dimens.size30),
          Text("Loan Account", style: theme.textTheme.bodyText1),
          const SizedBox(height: Dimens.size8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 5,
                child: SliderCustom(
                  values: const [0, 2000000],
                  step: const FlutterSliderStep(step: 1),
                  onDragging: (handlerIndex, lowerValue, upperValue) {
                    loadAmountController.text =
                        ConvertHelper.formartNumber(lowerValue.toString());
                  },
                ),
              ),
              Expanded(
                flex: 3,
                child: TextFieldCustom(
                  controller: loadAmountController,
                  prefixIcon: '\u0024',
                ),
              )
            ],
          ),
          const SizedBox(height: Dimens.size10),
          Text("Interest rate", style: theme.textTheme.bodyText1),
          const SizedBox(height: Dimens.size8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: 5,
                  child: SliderCustom(
                    values: const [3, 9],
                    step: const FlutterSliderStep(step: 0.1),
                    onDragging: (handlerIndex, lowerValue, upperValue) {
                      interesetRateController.text =
                          ConvertHelper.formartNumber(lowerValue.toString());
                    },
                  )),
              Expanded(
                flex: 3,
                child: TextFieldCustom(
                  controller: interesetRateController,
                  suffixIcon: '%',
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
          const SizedBox(height: Dimens.size10),
          Text("Loan term", style: theme.textTheme.bodyText1),
          const SizedBox(height: Dimens.size8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: 5,
                  child: SliderCustom(
                    values: const [10, 30],
                    step: const FlutterSliderStep(step: 1),
                    onDragging: (handlerIndex, lowerValue, upperValue) {
                      loadTernController.text =
                          ConvertHelper.formartNumber(lowerValue.toString());
                    },
                  )),
              Expanded(
                flex: 3,
                child: TextFieldCustom(
                  controller: loadTernController,
                  suffixIcon: 'year',
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
          const SizedBox(height: Dimens.size14),
          Text("Repayment frequency", style: theme.textTheme.bodyText1),
          const SizedBox(height: Dimens.size20),
          Row(
            children: [
              Expanded(
                child: SelectButton(
                  status: isWeekly,
                  text: 'Weekly',
                  onTap: () {
                    isWeekly = true;
                    isFortnightly = false;
                    isMonthly = false;
                    setState(() {});
                  },
                ),
              ),
              const SizedBox(width: Dimens.size1),
              Expanded(
                  child: SelectButton(
                status: isFortnightly,
                text: 'Fortnightly',
                onTap: () {
                  isWeekly = false;
                  isFortnightly = true;
                  isMonthly = false;
                  setState(() {});
                },
              )),
              const SizedBox(width: Dimens.size1),
              Expanded(
                  child: SelectButton(
                status: isMonthly,
                text: 'Monthly',
                onTap: () {
                  isWeekly = false;
                  isFortnightly = false;
                  isMonthly = true;
                  setState(() {});
                },
              ))
            ],
          ),
          const SizedBox(height: Dimens.size20),
          Text("Repayment type", style: theme.textTheme.bodyText1),
          const SizedBox(height: Dimens.size20),
          Row(
            children: [
              Expanded(
                  child: SelectButton(
                text: 'Principle & Interest',
                status: isBoth,
                onTap: () {
                  isBoth = true;
                  isInterest = false;
                  setState(() {});
                },
              )),
              const SizedBox(width: Dimens.size1),
              Expanded(
                  child: SelectButton(
                status: isInterest,
                text: 'Interest only',
                onTap: () {
                  isBoth = false;
                  isInterest = true;
                  setState(() {});
                },
              )),
            ],
          ),
          const SizedBox(height: Dimens.size30),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.size10),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xffd8d7d5))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: Dimens.size14),
                Image.asset(
                  ImageAssetPath.icYourPayment,
                  height: Dimens.size40,
                  width: Dimens.size40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("Your repayments", style: theme.textTheme.s22w800()),
                    Text("\u00244,253", style: theme.textTheme.s28bold()),
                  ],
                ),
                const SizedBox(height: Dimens.size6),
                if (isBoth)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total interest", style: theme.textTheme.s12w800()),
                      Text("\$481,172", style: theme.textTheme.s14w600()),
                    ],
                  ),
                const SizedBox(height: Dimens.size24),
              ],
            ),
          ),
          const SizedBox(height: Dimens.size14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Disclaimer", style: theme.textTheme.subtitle2),
              Text("Disclosure", style: theme.textTheme.subtitle2),
            ],
          ),
          const SizedBox(height: Dimens.size20),
        ],
      ),
    );
  }
}
