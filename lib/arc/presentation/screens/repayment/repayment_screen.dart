import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:intl/intl.dart';
import 'package:mortgage_exp/arc/presentation/widgets/commons/common.dart';
import 'package:mortgage_exp/arc/presentation/widgets/commons/custom_app_bar.dart';
import 'package:mortgage_exp/src/constants.dart';
import 'package:mortgage_exp/src/extensions/extension.dart';
import 'package:mortgage_exp/src/preferences/app_preference.dart';
import 'package:mortgage_exp/src/styles/dimens.dart';
import 'package:mortgage_exp/src/utilities/showtoast.dart';

import '../../../../injector.dart';
import '../../../../src/base_widget_state/base_widget_state.dart';
import '../../../../src/bloc/base.dart';
import '../../../../src/helper/convert_helper.dart';
import '../../blocs/blocs.dart';
import '../../widgets/commons/custom_textfield.dart';
import '../../widgets/commons/footer_widget.dart';
import '../../widgets/commons/select_button.dart';
import '../../widgets/commons/slider.dart';

class RepaymentScreen extends StatefulWidget {
  const RepaymentScreen({Key? key}) : super(key: key);

  @override
  State<RepaymentScreen> createState() => _RepaymentScreenState();
}

class _RepaymentScreenState extends IStateful<RepaymentBloc, RepaymentScreen> {
  final appPreference = AppDependencies.injector.get<AppPreference>();
  final formatter = NumberFormat('\$###,###');
  final formatNumber = NumberFormat('###,###');
  final formatDouble = NumberFormat('#.##');
  final loadAmountController = TextEditingController();
  final interesetRateController = TextEditingController();
  final loadTermController = TextEditingController();
  final loadAmountNode = FocusNode();
  final interesetRateNode = FocusNode();
  final loadTermNode = FocusNode();
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
  int payFreq = 12;
  double intWithout = 0;
  double totalIntWithout = 0;
  double totalIntWith = 0;
  double intWith = 0;
  double repaymentInterestOnly = 0;
  double repayment = 0;
  int count = 1;

  @override
  void initState() {
    super.initState();
    bloc.add(InitRepaymentEvent());
    initTextField();
  }

  @override
  void listener(BuildContext context, IBaseState state) async {
    super.listener(context, state);
    if (state is RepaymentLoaded) {
      isWeekly = state.isWeekly ?? false;
      isFortnightly = state.isFortnightly ?? false;
      isMonthly = state.isMonthly ?? false;
      principleInterest = state.principleInterest ?? false;
      interestOnly = state.interestOnly ?? false;
      loadAmountValue = state.loadAmountValue ?? [0];
      inValidAmount = state.inValidAmount ?? false;
      loadAmountMax = state.loadAmountMax ?? 0;
      loadAmountMin = state.loadAmountMin ?? 0;
      interestRateValue = state.interestRateValue ?? [0];
      inValidInterest = state.inValidInterest ?? false;
      loadInterestMax = state.loadInterestMax ?? 0;
      loadInterestMin = state.loadInterestMin ?? 0;
      loadTermValue = state.loadTermValue ?? [0];
      inValidTerm = state.inValidTerm ?? false;
      loadTermMax = state.loadTermMax ?? 0;
      loadTermMin = state.loadTermMin ?? 0;
      payFreq = state.payFreq ?? 0;
      intWithout = state.intWithout ?? 0;

      totalIntWithout = state.totalIntWithout ?? 0;
      totalIntWith = state.totalIntWith ?? 0;
      intWith = state.intWith ?? 0;
      repaymentInterestOnly = state.repaymentInterestOnly ?? 0;
      repayment = state.repayment ?? 0;
      if (totalIntWith.isNaN) {
        totalIntWith = 0;
      }
      if (repayment.isNaN) {
        repayment = 0;
      }

      loadAmountController.text = ConvertHelper.formartNumber(
          state.loadAmountValue?[0].toString() ?? '0');

      if (count < 3) {
        interesetRateController.text = ConvertHelper.formartNumber(
            state.interestRateValue?[0].toString() ?? '0');
        loadTermController.text = ConvertHelper.formartNumber(
            state.loadTermValue?[0].toString() ?? '0');
        count++;
      }
      // if ((double.tryParse(interesetRateController.text) ?? 0) < 0.5) {
      //   interesetRateController.text = loadInterestMin.toString();
      //   interestRateValue[0] = loadInterestMin;
      //   appPreference.setInterestRate(loadInterestMin.toString());
      // }

      loadAmountController.selection = TextSelection.fromPosition(
          TextPosition(offset: loadAmountController.text.length));
      interesetRateController.selection = TextSelection.fromPosition(
          TextPosition(offset: interesetRateController.text.length));
      loadTermController.selection = TextSelection.fromPosition(
          TextPosition(offset: loadTermController.text.length));
    }
  }

  @override
  Widget buildContent(BuildContext context, {IBaseState? state}) {
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.primaryColor,
      appBar: CustomAppBar.withLeading(title: "Repayments"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: Dimens.size40),
              children: [
                const SizedBox(height: Dimens.size30),
                Text(
                  "Loan amount",
                  style: theme.primaryTextTheme.bodyText2,
                ),
                const SizedBox(height: Dimens.size8),
                Row(
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
                                      0;
                                  if (number == 0) {
                                    loadAmountController.text = '0';
                                    inValidAmount = true;
                                  }
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
                                    } else if (number == 0) {
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
                                  loadAmountController.selection =
                                      TextSelection.fromPosition(TextPosition(
                                          offset: loadAmountController
                                              .text.length));
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
                          if (inValidAmount)
                            const SizedBox(height: Dimens.size4),
                          if (inValidAmount)
                            Text("Invalid loan account",
                                style: theme.primaryTextTheme.error())
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: Dimens.size10),
                Text(
                  "Interest rate",
                  style: theme.primaryTextTheme.bodyText2,
                ),
                const SizedBox(height: Dimens.size8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 5,
                        child: SliderCustom(
                          values: interestRateValue,
                          max: loadInterestMax < interestRateValue.first
                              ? interestRateValue.first
                              : loadInterestMax,
                          min: loadInterestMin,
                          step: const FlutterSliderStep(step: 0.1),
                          onDragging: (handlerIndex, lowerValue, upperValue) {
                            onProgress(lowerValue, '2');
                            interesetRateController.text =
                                lowerValue.toString();
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
                                  await onChangeInterestRate(value);
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
                          if (inValidInterest)
                            const SizedBox(height: Dimens.size4),
                          if (inValidInterest)
                            Text("Invalid interest rate",
                                style: theme.primaryTextTheme.error())
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Dimens.size10),
                Text(
                  "Loan term",
                  style: theme.primaryTextTheme.bodyText2,
                ),
                const SizedBox(height: Dimens.size8),
                Row(
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
                            loadTermController.text =
                                ConvertHelper.formartNumber(
                                    lowerValue.toString());
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
                                    // if (number == 0) {
                                    //   loadTermController.text = '0';
                                    // }
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
                                        style:
                                            theme.textTheme.styleTextFields(),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            if (inValidTerm)
                              const SizedBox(height: Dimens.size4),
                            if (inValidTerm)
                              Text("Invalid loan term",
                                  style: theme.primaryTextTheme.error())
                          ],
                        ))
                  ],
                ),
                const SizedBox(height: Dimens.size14),
                Text(
                  "Repayment frequency",
                  style: theme.primaryTextTheme.bodyText2,
                ),
                const SizedBox(height: Dimens.size20),
                Row(
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
                const SizedBox(height: Dimens.size20),
                Text(
                  "Repayment type",
                  style: theme.primaryTextTheme.bodyText2,
                ),
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
                const SizedBox(height: Dimens.size80),
              ],
            ),
          ),
          const FooterWidget(hasPadding: true)
        ],
      ),
    );
  }

  Future<void> onChangeInterestRate(String value) async {
    final number = double.tryParse(value) ?? 0;
    // if (number == 0) {
    //   interesetRateController.text = '0';
    // }
    if (number < 0.5 && interesetRateController.text.length > 2) {
      await Future.delayed(const Duration(milliseconds: 300));
      interestRateValue[0] = loadInterestMin;
      interesetRateController.text = '0.5';
    }

    if (number > loadInterestMax) {
      inValidInterest = false;
      interestRateValue[0] = number;

      // interesetRateController.text =
      //     loadInterestMax.toString();
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

    await appPreference.setInterestRate(interestRateValue[0].toString());
    interesetRateController.selection = TextSelection.fromPosition(
        TextPosition(offset: interesetRateController.text.length));
    calculate();
  }

  Future<void> onRepaymentType(String key) async {
    bloc.add(ChangeTypeEvent(key: key));
    bloc.add(CaculateEvent(
      loadAmount: loadAmountController.text,
      interestRate: interesetRateController.text,
      loadTerm: loadTermController.text,
    ));
  }

  Future<void> initTextField() async {
    bloc.add(InitTextFieldEvent());
    await Future.delayed(const Duration(milliseconds: 500));
    bloc.add(CaculateEvent(
      loadAmount: loadAmountController.text,
      interestRate: interesetRateController.text,
      loadTerm: loadTermController.text,
    ));
  }

  Future<void> onProgress(
    double lowerValue,
    String key,
  ) async {
    bloc.add(ProgressChangeEvent(key: key, lowerValue: lowerValue));
    bloc.add(CaculateEvent(
      loadAmount: loadAmountController.text,
      interestRate: interesetRateController.text,
      loadTerm: loadTermController.text,
    ));
  }

  Future<void> onRepaymentFrequency(String key) async {
    bloc.add(ChangeFrequencyEvent(key: key));
    bloc.add(CaculateEvent(
      loadAmount: loadAmountController.text,
      interestRate: interesetRateController.text,
      loadTerm: loadTermController.text,
    ));
  }

  Future<void> calculate() async {
    await Future.delayed(const Duration(seconds: 2));
    bloc.add(CaculateEvent(
      loadAmount: loadAmountController.text,
      interestRate: interesetRateController.text,
      loadTerm: loadTermController.text,
    ));
  }
}
