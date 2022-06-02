import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:intl/intl.dart';
import 'package:mortgage_exp/arc/presentation/blocs/blocs.dart';
import 'package:mortgage_exp/arc/presentation/widgets/commons/common.dart';
import 'package:mortgage_exp/arc/presentation/widgets/commons/custom_app_bar.dart';
import 'package:mortgage_exp/src/constants.dart';
import 'package:mortgage_exp/src/extensions/extension.dart';
import 'package:mortgage_exp/src/preferences/app_preference.dart';
import 'package:mortgage_exp/src/styles/dimens.dart';

import '../../../../injector.dart';
import '../../../../src/base_widget_state/base_widget_state.dart';
import '../../../../src/bloc/base.dart';
import '../../../../src/helper/convert_helper.dart';
import '../../widgets/commons/bottom_space.dart';
import '../../widgets/commons/custom_textfield.dart';
import '../../widgets/commons/footer_widget.dart';
import '../../widgets/commons/select_button.dart';
import '../../widgets/commons/slider.dart';

class ExtraRepaymentScreen extends StatefulWidget {
  const ExtraRepaymentScreen({Key? key}) : super(key: key);

  @override
  State<ExtraRepaymentScreen> createState() => _ExtraRepaymentScreenState();
}

class _ExtraRepaymentScreenState
    extends IStateful<ExtraBloc, ExtraRepaymentScreen> {
  final appPreference = AppDependencies.injector.get<AppPreference>();
  final formatter = NumberFormat('\$###,###');
  final formatNumber = NumberFormat('###,###');
  final formatDouble = NumberFormat('#.##');
  final loadAmountController = TextEditingController();
  final interesetRateController = TextEditingController();
  final loadTermController = TextEditingController();
  final repaymentController = TextEditingController();
  final loadAmountNode = FocusNode();
  final repaymentNode = FocusNode();
  final interesetRateNode = FocusNode();
  final loadTermNode = FocusNode();
  bool isWeekly = true;
  bool isFortnightly = false;
  bool isMonthly = false;
  List<double> repaymentValue = [250];
  bool inValidRepayment = false;
  double repaymentMax = 5000;
  double repaymentMin = 0;
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
  double total = 0;
  String time = '';

  double repaymentInterestOnly = 0;
  double repayment = 0;

  @override
  void initState() {
    super.initState();
    bloc.add(InitExtraEvent());
    initTextField();
  }

  @override
  void listener(BuildContext context, IBaseState state) async {
    super.listener(context, state);
    if (state is ExtraLoaded) {
      loadAmountController.text = ConvertHelper.formartNumber(
          state.loadAmountValue?[0].toString() ?? '0');
      interesetRateController.text = ConvertHelper.formartNumber(
          state.interestRateValue?[0].toString() ?? '0');
      loadTermController.text = ConvertHelper.formartNumber(
          state.loadTermValue?[0].toString() ?? '0');
      repaymentController.text = ConvertHelper.formartNumber(
          state.repaymentValue?[0].toString() ?? '0');
      repaymentController.selection = TextSelection.fromPosition(
          TextPosition(offset: repaymentController.text.length));
      loadAmountController.selection = TextSelection.fromPosition(
          TextPosition(offset: loadAmountController.text.length));
      interesetRateController.selection = TextSelection.fromPosition(
          TextPosition(offset: interesetRateController.text.length));
      loadTermController.selection = TextSelection.fromPosition(
          TextPosition(offset: loadTermController.text.length));
      isWeekly = state.isWeekly ?? false;
      isFortnightly = state.isFortnightly ?? false;
      isMonthly = state.isMonthly ?? false;
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
      repaymentInterestOnly = state.repaymentInterestOnly ?? 0;
      repayment = state.repayment ?? 0;
      repaymentValue = state.repaymentValue ?? [0];
      inValidRepayment = state.inValidRepayment ?? false;
      repaymentMax = state.repaymentMax ?? 0;
      repaymentMin = state.repaymentMin ?? 0;
      time = state.time ?? '';
      total = state.total ?? 0;
      if (total.isNaN) {
        total = 0;
      }
    }
  }

  @override
  Widget buildContent(BuildContext context, {IBaseState? state}) {
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.primaryColor,
      appBar: CustomAppBar.withLeading(title: "Extra Repayments"),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.size40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: Dimens.size20),
                  Text("Loan amount", style: theme.textTheme.bodyText1),
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
                                      setState(() {});
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
                                        loadAmountValue[0] = 0;
                                        inValidAmount = true;
                                        setState(() {});
                                      } else {
                                        loadAmountValue[0] = number;
                                        inValidAmount = false;
                                        setState(() {});
                                      }
                                    }
                                    await appPreference.setLoadAmount(
                                        formatNumber
                                            .format(loadAmountValue[0]));
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
                                        style:
                                            theme.textTheme.styleTextFields(),
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
                  Text("Interest rate", style: theme.textTheme.bodyText1),
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
                                    if (number == 0) {
                                      interesetRateController.text = '0';
                                    }
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
                                    interesetRateController.selection =
                                        TextSelection.fromPosition(TextPosition(
                                            offset: interesetRateController
                                                .text.length));
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
                                        style:
                                            theme.textTheme.styleTextFields(),
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
                  Text("Loan term", style: theme.textTheme.bodyText1),
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
                                      if (number == 0) {
                                        loadTermController.text = '0';
                                      }
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
                                      loadTermController.selection =
                                          TextSelection.fromPosition(
                                              TextPosition(
                                                  offset: loadTermController
                                                      .text.length));
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
                  Text("Repayment frequency", style: theme.textTheme.bodyText1),
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
                  Text("Extra Repayment", style: theme.textTheme.bodyText1),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 5,
                        child: SliderCustom(
                          values: repaymentValue,
                          max: repaymentMax,
                          min: repaymentMin,
                          step: const FlutterSliderStep(step: 1),
                          onDragging: (handlerIndex, lowerValue, upperValue) {
                            onProgress(lowerValue, '4');
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
                                  controller: repaymentController,
                                  focusNode: repaymentNode,
                                  padding: const EdgeInsets.only(
                                      left: 24, top: 10, bottom: 10),
                                  onChanged: (value) async {
                                    final number = double.tryParse(
                                            repaymentController.text
                                                .replaceAll(',', '')) ??
                                        0;
                                    if (number == 0) {
                                      repaymentController.text = '0';
                                    }
                                    if (number > repaymentMax) {
                                      inValidRepayment = true;
                                      repaymentController.text =
                                          formatNumber.format(repaymentMax);
                                      repaymentValue[0] = repaymentMax;
                                      setState(() {});
                                    } else {
                                      if (number < repaymentMin) {
                                        repaymentValue[0] = repaymentMin;
                                        inValidRepayment = true;
                                        setState(() {});
                                      } else if (number == 0) {
                                        repaymentValue[0] = 0;
                                        inValidRepayment = true;
                                        setState(() {});
                                      } else {
                                        repaymentValue[0] = number;
                                        inValidRepayment = false;
                                        setState(() {});
                                      }
                                    }
                                    await appPreference.setExtraRepayment(
                                        formatNumber.format(repaymentValue[0]));
                                    repaymentController.selection =
                                        TextSelection.fromPosition(TextPosition(
                                            offset: repaymentController
                                                .text.length));
                                    calculate();
                                  },
                                ),
                                GestureDetector(
                                  onTap: () => repaymentNode.requestFocus(),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 10, bottom: 10),
                                      child: Text(
                                        '\u0024',
                                        style:
                                            theme.textTheme.styleTextFields(),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            if (inValidRepayment)
                              const SizedBox(height: Dimens.size4),
                            if (inValidRepayment)
                              Text("Invalid extra repayment",
                                  style: theme.primaryTextTheme.error())
                          ],
                        ),
                      )
                    ],
                  ),
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
                        const SizedBox(height: Dimens.size20),
                        Image.asset(ImageAssetPath.icYourPayment,
                            color: theme.backgroundColor,
                            height: Dimens.size40,
                            width: Dimens.size30),
                        Flexible(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Flexible(
                                flex: 5,
                                child: Text(
                                  "Interest you will save",
                                  maxLines: 3,
                                  style: theme.textTheme.s22w800(),
                                ),
                              ),
                              Flexible(
                                flex: 3,
                                child: FittedBox(
                                  child: Text(formatter.format(total),
                                      maxLines: 1,
                                      style: theme.textTheme.s28bold()),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: Dimens.size6),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Time you will save",
                                  style: theme.textTheme.s12w800()),
                              Text(time, style: theme.textTheme.s14w600()),
                            ],
                          ),
                        ),
                        const SizedBox(height: Dimens.size24),
                      ],
                    ),
                  ),
                  const BottomSpace(),
                  const SizedBox(height: Dimens.size80),
                ],
              ),
            ),
          ),
          const FooterWidget(hasPadding: true)
        ],
      ),
    );
  }

  Future<void> initTextField() async {
    bloc.add(ExtraInitTextFieldEvent());
    await Future.delayed(const Duration(milliseconds: 500));
    bloc.add(ExtraCaculateEvent(
      loadAmount: loadAmountController.text,
      interestRate: interesetRateController.text,
      loadTerm: loadTermController.text,
      extra: repaymentController.text,
    ));
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
      inValidAmount = false;
      setState(() {});
    } else if (key == '2') {
      interesetRateController.text =
          ConvertHelper.formartNumber(lowerValue.toStringAsFixed(1));
      interestRateValue[0] = lowerValue;
      await appPreference.setInterestRate(
          ConvertHelper.formartNumber(lowerValue.toStringAsFixed(1)));
      inValidInterest = false;
      setState(() {});
    } else if (key == '3') {
      loadTermController.text =
          ConvertHelper.formartNumber(lowerValue.toStringAsFixed(0));
      loadTermValue[0] = lowerValue;
      await appPreference.setLoanTerm(
          ConvertHelper.formartNumber(lowerValue.toStringAsFixed(0)));
      inValidTerm = false;
      setState(() {});
    } else if (key == '4') {
      repaymentController.text =
          ConvertHelper.formartNumber(lowerValue.toStringAsFixed(0));
      repaymentValue[0] = lowerValue;
      await appPreference.setExtraRepayment(
          ConvertHelper.formartNumber(lowerValue.toStringAsFixed(0)));
      inValidRepayment = false;
      setState(() {});
    }
    calculate();
  }

  Future<void> onRepaymentFrequency(String key) async {
    bloc.add(ExtraChangeFrequencyEvent(key: key));
    bloc.add(ExtraCaculateEvent(
      loadAmount: loadAmountController.text,
      interestRate: interesetRateController.text,
      loadTerm: loadTermController.text,
      extra: repaymentController.text,
    ));
  }

  Future<void> calculate() async {
    await Future.delayed(const Duration(seconds: 2));
    bloc.add(ExtraCaculateEvent(
      loadAmount: loadAmountController.text,
      interestRate: interesetRateController.text,
      loadTerm: loadTermController.text,
      extra: repaymentController.text,
    ));
  }
}
