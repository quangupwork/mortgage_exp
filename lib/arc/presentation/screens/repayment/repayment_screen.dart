import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:intl/intl.dart';
import 'package:mortgage_exp/arc/presentation/widgets/commons/common.dart';
import 'package:mortgage_exp/arc/presentation/widgets/commons/custom_app_bar.dart';
import 'package:mortgage_exp/src/constants.dart';
import 'package:mortgage_exp/src/extensions/extension.dart';
import 'package:mortgage_exp/src/extensions/global_key.dart';
import 'package:mortgage_exp/src/preferences/app_preference.dart';
import 'package:mortgage_exp/src/styles/dimens.dart';
import 'package:mortgage_exp/src/utilities/utilities.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../../injector.dart';
import '../../../../src/helper/convert_helper.dart';
import '../../widgets/commons/custom_textfield.dart';
import '../../widgets/commons/footer_widget.dart';
import '../../widgets/commons/select_button.dart';
import '../../widgets/commons/slider.dart';

class RepaymentScreen extends StatefulWidget {
  const RepaymentScreen({Key? key}) : super(key: key);

  @override
  State<RepaymentScreen> createState() => _RepaymentScreenState();
}

class _RepaymentScreenState extends State<RepaymentScreen> {
  final appPreference = AppDependencies.injector.get<AppPreference>();
  final formatter = NumberFormat('\$###,###');
  final formatNumber = NumberFormat('###,###');
  final formatDouble = NumberFormat('#.##');
  bool isWeekly = true;
  bool isFortnightly = false;
  bool isMonthly = false;
  bool principleInterest = true;
  bool interestOnly = false;
  List<double> loadAmountValue = [0];
  bool inValidAmount = false;
  double loadAmountMax = 2000000;
  double loadAmountMin = 0;
  List<double> interestRateValue = [2];
  bool inValidInterest = false;
  double loadInterestMax = 6.5;
  double loadInterestMin = 0.5;
  List<double> loadTermValue = [30];
  bool inValidTerm = false;
  double loadTermMax = 30;
  double loadTermMin = 10;
  final loadAmountController = TextEditingController();
  final interesetRateController = TextEditingController();
  final loadTermController = TextEditingController();
  final loadAmountNode = FocusNode();
  final interesetRateNode = FocusNode();
  final loadTermNode = FocusNode();
  int payFreq = 12;
  double intWithout = 0;
  double totalIntWithout = 0;
  double totalIntWith = 0;
  double intWith = 0;

  double repaymentInterestOnly = 0;
  double repayment = 0;
  late TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = <TargetFocus>[];

  GlobalKey keyButton = GlobalKey();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      final checkFirst = await appPreference.firstRepayment ?? true;
      if (checkFirst) {
        showTutorial();
        await appPreference.setFirstRepayment(false);
      }
    });
    initTextField();
  }

  void showTutorial() {
    initTargets();
    tutorialCoachMark = TutorialCoachMark(
      context,
      targets: targets,
      colorShadow: Colors.red,
      // textSkip: "SKIP",
      paddingFocus: 10,
      opacityShadow: 0.8,
      onFinish: () {
        LoggerUtils.d("finish");
      },
      onClickTarget: (target) {
        LoggerUtils.d('onClickTarget: $target');
      },
      onClickOverlay: (target) {
        LoggerUtils.d('onClickOverlay: $target');
      },
      onSkip: () {
        LoggerUtils.d("skip");
      },
    )..show();
  }

  void initTargets() {
    targets.clear();

    targets.add(
      TargetFocus(
        identify: "Target 1",
        // keyTarget: keyButton,
        color: Colors.grey,
        shape: ShapeLightFocus.RRect,
        targetPosition: TargetPosition(
            Size(MediaQuery.of(context).size.width - 60, 20),
            Offset(30, (keyButton.globalPaintBounds?.top ?? 0) + 10)),
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      "The values can be entered \nusing the slider or the text box",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: Colors.white)),
                  const SizedBox(height: Dimens.size30),
                  Text(
                      "If you find the slider to sensitive, we \nsuggest to the use the text to to \nenter the values.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: Colors.white)),
                  const SizedBox(height: Dimens.size80),
                  ElevatedButton(
                    onPressed: () {
                      controller.next();
                    },
                    child: Text("OK GOT IT",
                        style: Theme.of(context).textTheme.bodyText1),
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.primaryColor,
      appBar: CustomAppBar.withLeading(title: "Repayments"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.size40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: Dimens.size30),
            Text("Loan amount", style: theme.textTheme.bodyText1),
            const SizedBox(height: Dimens.size8),
            Row(
              key: keyButton,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: SliderCustom(
                    values: loadAmountValue,
                    max: loadAmountMax,
                    min: loadAmountMin,
                    step: const FlutterSliderStep(step: 1),
                    onDragging: (handlerIndex, lowerValue, upperValue) {
                      onProgress(lowerValue, '1');
                    },
                  ),
                ),
                const SizedBox(width: Dimens.size4),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          TextFieldCustom(
                            controller: loadAmountController,
                            focusNode: loadAmountNode,
                            padding: const EdgeInsets.only(
                                left: 24, top: 10, bottom: 10),
                            onChanged: (value) async {
                              final number = double.tryParse(
                                      loadAmountController.text
                                          .replaceAll(',', '')) ??
                                  -1;
                              if (number > loadAmountMax) {
                                inValidAmount = true;
                                loadAmountValue[0] = loadAmountMax;
                                loadAmountController.text = '2,000,000';
                                setState(() {});
                              } else {
                                if (number < loadAmountMin) {
                                  loadAmountValue[0] = loadAmountMin;
                                  inValidAmount = true;
                                  setState(() {});
                                } else {
                                  loadAmountValue[0] = number;
                                  inValidAmount = false;
                                  setState(() {});
                                }
                              }
                              await appPreference.setLoadAmount(
                                  formatNumber.format(loadAmountValue[0]));
                              calculate();
                            },
                          ),
                          GestureDetector(
                            onTap: () => loadAmountNode.requestFocus(),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 10, bottom: 10),
                                child: Text(
                                  '\u0024',
                                  style: theme.textTheme.styleTextFields(),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      if (inValidAmount) const SizedBox(height: Dimens.size4),
                      if (inValidAmount)
                        Text("Invalid loan account",
                            style: theme.primaryTextTheme.error())
                    ],
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
                      values: interestRateValue,
                      max: loadInterestMax,
                      min: loadInterestMin,
                      step: const FlutterSliderStep(step: 0.1),
                      onDragging: (handlerIndex, lowerValue, upperValue) {
                        onProgress(lowerValue, '2');
                      },
                    )),
                const SizedBox(width: Dimens.size4),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          TextFieldCustom(
                            isLeft: true,
                            focusNode: interesetRateNode,
                            controller: interesetRateController,
                            suffixIcon: '%',
                            textAlign: TextAlign.center,
                            padding: const EdgeInsets.only(
                                left: 24, top: 10, bottom: 10),
                            onChanged: (value) async {
                              final number = double.tryParse(
                                      interesetRateController.text) ??
                                  0;
                              if (number > loadInterestMax) {
                                inValidInterest = true;
                                interestRateValue[0] = loadInterestMax;
                                interesetRateController.text =
                                    loadInterestMax.toString();
                                setState(() {});
                              } else {
                                if (number < loadInterestMin) {
                                  interestRateValue[0] = loadInterestMin;
                                  inValidInterest = true;
                                  setState(() {});
                                } else {
                                  interestRateValue[0] = number;
                                  inValidInterest = false;
                                  setState(() {});
                                }
                              }
                              await appPreference.setInterestRate(
                                  interestRateValue[0].toString());
                              calculate();
                            },
                          ),
                          GestureDetector(
                            onTap: () => interesetRateNode.requestFocus(),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 10, top: 10, bottom: 10),
                                child: Text(
                                  '%',
                                  style: theme.textTheme.styleTextFields(),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      if (inValidInterest) const SizedBox(height: Dimens.size4),
                      if (inValidInterest)
                        Text("Invalid interest rate",
                            style: theme.primaryTextTheme.error())
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: Dimens.size10),
            Text("Loan term", style: theme.textTheme.bodyText1),
            const SizedBox(height: Dimens.size8),
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 5,
                      child: SliderCustom(
                        values: loadTermValue,
                        max: loadTermMax,
                        min: loadTermMin,
                        step: const FlutterSliderStep(step: 1),
                        onDragging: (handlerIndex, lowerValue, upperValue) {
                          onProgress(lowerValue, '3');
                        },
                      )),
                  const SizedBox(width: Dimens.size4),
                  Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              TextFieldCustom(
                                isLeft: true,
                                focusNode: loadTermNode,
                                controller: loadTermController,
                                suffixIcon: 'year',
                                textAlign: TextAlign.center,
                                padding: const EdgeInsets.only(
                                    left: 24, top: 10, bottom: 10),
                                onChanged: (value) async {
                                  final number = double.tryParse(
                                          loadTermController.text
                                              .replaceAll(',', '')) ??
                                      0;
                                  if (number > loadTermMax) {
                                    inValidTerm = true;
                                    loadTermController.text =
                                        loadTermMax.toStringAsFixed(0);
                                    loadTermValue[0] = loadTermMax;
                                    setState(() {});
                                  } else {
                                    if (number < loadTermMin) {
                                      loadTermValue[0] = loadTermMin;
                                      // loadTermController.text =
                                      //     loadTermMin.toStringAsFixed(0);
                                      inValidTerm = true;
                                      setState(() {});
                                    } else {
                                      loadTermValue[0] = number;
                                      inValidTerm = false;
                                      setState(() {});
                                    }
                                  }
                                  await appPreference.setLoanTerm(
                                      loadTermValue[0].toStringAsFixed(0));
                                  calculate();
                                },
                              ),
                              GestureDetector(
                                onTap: () => loadTermNode.requestFocus(),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, top: 10, bottom: 10),
                                    child: Text(
                                      'year',
                                      style: theme.textTheme.styleTextFields(),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          if (inValidTerm) const SizedBox(height: Dimens.size4),
                          if (inValidTerm)
                            Text("Invalid loan term",
                                style: theme.primaryTextTheme.error())
                        ],
                      ))
                ],
              ),
            ),
            const SizedBox(height: Dimens.size14),
            Text("Repayment frequency", style: theme.textTheme.bodyText1),
            const SizedBox(height: Dimens.size20),
            Flexible(
              child: Row(
                children: [
                  Expanded(
                    child: SelectButton(
                      status: isWeekly,
                      text: 'Weekly',
                      onTap: () async => onRepaymentFrequency('1'),
                    ),
                  ),
                  const SizedBox(width: Dimens.size1),
                  Expanded(
                      child: SelectButton(
                    status: isFortnightly,
                    text: 'Fortnightly',
                    onTap: () async => onRepaymentFrequency('2'),
                  )),
                  const SizedBox(width: Dimens.size1),
                  Expanded(
                      child: SelectButton(
                    status: isMonthly,
                    text: 'Monthly',
                    onTap: () async => onRepaymentFrequency('3'),
                  ))
                ],
              ),
            ),
            const SizedBox(height: Dimens.size20),
            Text("Repayment type", style: theme.textTheme.bodyText1),
            const SizedBox(height: Dimens.size20),
            Row(
              children: [
                Expanded(
                    child: SelectButton(
                  text: 'Principle & Interest',
                  status: principleInterest,
                  onTap: () async => onRepaymentType('1'),
                )),
                const SizedBox(width: Dimens.size1),
                Expanded(
                    child: SelectButton(
                  status: interestOnly,
                  text: 'Interest only',
                  onTap: () async => onRepaymentType('2'),
                )),
              ],
            ),
            const SizedBox(height: Dimens.size30),
            Flexible(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.size10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: const Color(0xffd8d7d5))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: Dimens.size14),
                    Image.asset(ImageAssetPath.icYourPayment,
                        height: Dimens.size40, width: Dimens.size30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Your repayments",
                            style: theme.textTheme.s22w800()),
                        Text(formatter.format(repayment),
                            style: theme.textTheme.s28bold()),
                      ],
                    ),
                    const SizedBox(height: Dimens.size6),
                    principleInterest
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total interest",
                                  style: theme.textTheme.s12w800()),
                              Text(formatter.format(totalIntWith),
                                  style: theme.textTheme.s14w600()),
                            ],
                          )
                        : const Text(''),
                    const SizedBox(height: Dimens.size24),
                  ],
                ),
              ),
            ),
            const Spacer(),
            const FooterWidget()
          ],
        ),
      ),
    );
  }

  Future<void> onRepaymentType(String key) async {
    if (key == '1') {
      principleInterest = true;
      interestOnly = false;
    } else if (key == '2') {
      principleInterest = false;
      interestOnly = true;
    }
    await appPreference.setPrincipleInterest(principleInterest);
    await appPreference.setInterestOnly(interestOnly);
    calculate();
    setState(() {});
  }

  Future<void> initTextField() async {
    final amount = await appPreference.loadAmount ?? '500,000';
    final interest = await appPreference.interestRate ?? '2';
    final term = await appPreference.loanTerm ?? '30';
    final weekly = await appPreference.isWeekly ?? false;
    final fortnightly = await appPreference.isFortnightly ?? false;
    final monthly = await appPreference.isMonthly ?? false;
    final principle = await appPreference.principleInterest ?? false;
    final only = await appPreference.interestOnly ?? false;

    loadAmountController.text = amount;
    interesetRateController.text = interest;
    loadTermController.text = term;
    loadAmountValue[0] = double.parse(amount.replaceAll(',', ''));
    interestRateValue[0] = double.parse(interest);
    loadTermValue[0] = double.parse(term);
    isWeekly = weekly;
    isFortnightly = fortnightly;
    isMonthly = monthly;
    principleInterest = principle;
    interestOnly = only;

    if (!weekly && !fortnightly && !monthly) {
      isMonthly = true;
    }
    if (!principle && !only) {
      principleInterest = true;
    }

    setState(() {});
    calculate();
  }

  Future<void> onProgress(
    double lowerValue,
    String key,
  ) async {
    if (key == '1') {
      loadAmountController.text =
          ConvertHelper.formartNumber(lowerValue.toStringAsFixed(0));
      loadAmountValue[0] = lowerValue;
      await appPreference.setLoadAmount(
          ConvertHelper.formartNumber(lowerValue.toStringAsFixed(0)));
    } else if (key == '2') {
      interesetRateController.text =
          ConvertHelper.formartNumber(lowerValue.toStringAsFixed(1));
      interestRateValue[0] = lowerValue;
      await appPreference.setInterestRate(
          ConvertHelper.formartNumber(lowerValue.toStringAsFixed(1)));
    } else if (key == '3') {
      loadTermController.text =
          ConvertHelper.formartNumber(lowerValue.toStringAsFixed(0));
      loadTermValue[0] = lowerValue;
      await appPreference.setLoanTerm(
          ConvertHelper.formartNumber(lowerValue.toStringAsFixed(0)));
    }
    calculate();
  }

  Future<void> onRepaymentFrequency(String key) async {
    if (key == '1') {
      isWeekly = true;
      isFortnightly = false;
      isMonthly = false;
      payFreq = 52;
    } else if (key == '2') {
      isWeekly = false;
      isFortnightly = true;
      isMonthly = false;
      payFreq = 26;
    } else if (key == '3') {
      isWeekly = false;
      isFortnightly = false;
      isMonthly = true;
      payFreq = 12;
    }
    await appPreference.setWeekly(isWeekly);
    await appPreference.setFortnightly(isFortnightly);
    await appPreference.setMonthly(isMonthly);
    calculate();
  }

  Future<void> calculate() async {
    if (isWeekly) {
      onRepaymentFrequency('1');
    }
    if (isFortnightly) {
      onRepaymentFrequency('2');
    }
    if (isMonthly) {
      onRepaymentFrequency('3');
    }
    int amount = int.parse(loadAmountController.text.replaceAll(',', ''));
    int loanTerm = int.parse(loadTermController.text);
    double intRate = double.parse(interesetRateController.text);

    double r = (intRate / (payFreq * 100));
    double n = (loanTerm * payFreq).ceilToDouble();
    double _r = (1 + r);
    num _rn = math.pow(_r, n);

    intWith = amount * (r * (_rn / (_rn - 1)));
    intWithout = r * amount;

    totalIntWithout = intWithout * n;
    totalIntWith = ((intWith - intWithout) * n) + totalIntWithout - amount;
    repayment = principleInterest ? intWith : intWithout;

    setState(() {});
  }
}
