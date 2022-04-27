import 'dart:math';

import '../../../../src/bloc/base.dart';
import '../../../../src/helper/convert_helper.dart';
import '../../widgets/commons/dialog.dart';
import '../blocs.dart';
import 'dart:math' as math;

class ExtraBloc extends IBaseBloc {
  bool isWeekly = true;
  bool isFortnightly = false;
  bool isMonthly = false;
  bool principleInterest = true;
  bool interestOnly = false;
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
  double intWithout = 0;
  double totalIntWithout = 0;
  double totalIntWith = 0;
  double intWith = 0;
  double repaymentInterestOnly = 0;
  double repayment = 0;
  double total = 0;
  String time = '';
  @override
  void registerEvents() {
    registerEvent<InitExtraEvent>(
        (event) => _initRepayment(event as InitExtraEvent));
    registerEvent<ExtraChangeFrequencyEvent>(
        (event) => _changeRequency(event as ExtraChangeFrequencyEvent));
    registerEvent<ExtraChangeTypeEvent>(
        (event) => _changeType(event as ExtraChangeTypeEvent));
    registerEvent<ExtraCaculateEvent>(
        (event) => _caculate(event as ExtraCaculateEvent));
    registerEvent<ExtraProgressChangeEvent>(
        (event) => _onProgress(event as ExtraProgressChangeEvent));
    registerEvent<ExtraInitTextFieldEvent>(
        (event) => _initTextField(event as ExtraInitTextFieldEvent));
  }

  Stream<IBaseState> _initTextField(ExtraInitTextFieldEvent event) async* {
    final currentState = state as ExtraLoaded;
    final amount = await appPreference.loadAmount ?? '500,000';
    final repaymentString = await appPreference.extraRepayment ?? '250';
    final interest = await appPreference.interestRate ?? '2';
    final term = await appPreference.loanTerm ?? '30';
    final weekly = await appPreference.isWeekly ?? false;
    final fortnightly = await appPreference.isFortnightly ?? false;
    final monthly = await appPreference.isMonthly ?? false;

    loadAmountValue[0] = double.parse(amount.replaceAll(',', ''));
    interestRateValue[0] = double.parse(interest);
    loadTermValue[0] = double.parse(term);
    repaymentValue[0] = double.parse(repaymentString.replaceAll(',', ''));
    isWeekly = weekly;
    isFortnightly = fortnightly;
    isMonthly = monthly;

    if (!weekly && !fortnightly && !monthly) {
      isMonthly = true;
    }
    yield currentState.copyWith(
        total: total,
        time: time,
        repaymentValue: repaymentValue,
        inValidRepayment: inValidRepayment,
        repaymentMax: repaymentMax,
        repaymentMin: repaymentMin,
        isWeekly: isWeekly,
        isFortnightly: isFortnightly,
        isMonthly: isMonthly,
        principleInterest: principleInterest,
        interestOnly: interestOnly,
        loadAmountValue: loadAmountValue,
        inValidAmount: inValidAmount,
        loadAmountMax: loadAmountMax,
        loadAmountMin: loadAmountMin,
        interestRateValue: interestRateValue,
        inValidInterest: inValidInterest,
        loadInterestMax: loadInterestMax,
        loadInterestMin: loadInterestMin,
        loadTermValue: loadTermValue,
        inValidTerm: inValidTerm,
        loadTermMax: loadTermMax,
        loadTermMin: loadTermMin,
        payFreq: payFreq,
        intWithout: intWithout,
        totalIntWithout: totalIntWithout,
        totalIntWith: totalIntWith,
        intWith: intWith,
        repaymentInterestOnly: repaymentInterestOnly,
        repayment: repayment);
  }

  Stream<IBaseState> _onProgress(ExtraProgressChangeEvent event) async* {
    final currentState = state as ExtraLoaded;
    if (event.key == '1') {
      loadAmountValue[0] = event.lowerValue;
      await appPreference.setLoadAmount(
          ConvertHelper.formartNumber(event.lowerValue.toStringAsFixed(0)));
      inValidAmount = false;
    } else if (event.key == '2') {
      interestRateValue[0] = event.lowerValue;
      await appPreference.setInterestRate(
          ConvertHelper.formartNumber(event.lowerValue.toStringAsFixed(1)));
      inValidInterest = false;
    } else if (event.key == '3') {
      loadTermValue[0] = event.lowerValue;
      await appPreference.setLoanTerm(
          ConvertHelper.formartNumber(event.lowerValue.toStringAsFixed(0)));
      inValidTerm = false;
    }
    yield currentState.copyWith(
      loadAmountValue: loadAmountValue,
      inValidAmount: inValidAmount,
      interestRateValue: interestRateValue,
      inValidInterest: inValidInterest,
      loadTermValue: loadTermValue,
      inValidTerm: inValidTerm,
    );
  }

  Stream<IBaseState> _changeType(ExtraChangeTypeEvent event) async* {
    final currentState = state as ExtraLoaded;
    if (event.key == '1') {
      principleInterest = true;
      interestOnly = false;
    } else if (event.key == '2') {
      principleInterest = false;
      interestOnly = true;
    }
    await appPreference.setPrincipleInterest(principleInterest);
    await appPreference.setInterestOnly(interestOnly);
    yield currentState.copyWith(
      principleInterest: principleInterest,
      interestOnly: interestOnly,
    );
  }

  Stream<IBaseState> _caculate(ExtraCaculateEvent event) async* {
    final currentState = state as ExtraLoaded;
    double amount = double.parse(event.loadAmount.replaceAll(',', ''));
    double loanTerm = double.parse(event.loadTerm);
    double intRate = double.parse(event.interestRate);
    double extContPerDay = double.parse(event.extra.replaceAll(',', ''));
    double timeSaved;
    double intSaved;
    double savedYears;
    double savedMonths;

    //CALCULATE LOGIC
    double r = intRate / (payFreq * 100);
    int n = (loanTerm * payFreq).toInt();
    double _r = (1 + r);

    num _rn = math.pow(_r, n);
    double a = amount * ((r * _rn) / (_rn - 1));

    double totalPayAmount = (a * loanTerm * payFreq);
    double payPerPeriod = totalPayAmount / n;
    double incRepay = payPerPeriod + extContPerDay;

    double nAfterExtra = (-log(1 - amount / incRepay * r) / log(_r));

    timeSaved = n - nAfterExtra;
    intSaved = (a * timeSaved) - extContPerDay * nAfterExtra;

    if (timeSaved.isNaN || timeSaved.isInfinite) {
      savedYears = 0;
      savedMonths = 0;
    } else {
      savedYears = (timeSaved / payFreq).floorToDouble();
      savedMonths = (timeSaved - savedYears * payFreq).floorToDouble();
    }
    if (timeSaved < 0) {
      savedYears = 0;
      savedMonths = 0;
    }
    if (intSaved < 0) {
      intSaved = 0;
    }

    if (savedMonths > 11) {
      savedYears += savedMonths / 12;
      savedMonths = savedMonths % 12;
    }
    if (intSaved.isNaN) {
      intSaved = 0;
    }

    total = intSaved;
    time = '${savedYears.toInt()} years ${savedMonths.toInt()} months';

    yield currentState.copyWith(
      intWith: intWith,
      intWithout: intWithout,
      totalIntWithout: totalIntWithout,
      totalIntWith: totalIntWith,
      repayment: repayment,
      total: total,
      time: time,
    );
  }

  Stream<IBaseState> _changeRequency(ExtraChangeFrequencyEvent event) async* {
    final currentState = state as ExtraLoaded;
    if (event.key == '1') {
      isWeekly = true;
      isFortnightly = false;
      isMonthly = false;
      payFreq = 52;
    } else if (event.key == '2') {
      isWeekly = false;
      isFortnightly = true;
      isMonthly = false;
      payFreq = 26;
    } else if (event.key == '3') {
      isWeekly = false;
      isFortnightly = false;
      isMonthly = true;
      payFreq = 12;
    }
    await appPreference.setWeekly(isWeekly);
    await appPreference.setFortnightly(isFortnightly);
    await appPreference.setMonthly(isMonthly);
    yield currentState.copyWith(
      isWeekly: isWeekly,
      isFortnightly: isFortnightly,
      isMonthly: isMonthly,
      payFreq: payFreq,
    );
  }

  Stream<IBaseState> _initRepayment(InitExtraEvent event) async* {
    yield ExtraLoaded(
      total: total,
      time: time,
      repaymentValue: repaymentValue,
      inValidRepayment: inValidRepayment,
      repaymentMax: repaymentMax,
      repaymentMin: repaymentMin,
      isWeekly: isWeekly,
      isFortnightly: isFortnightly,
      isMonthly: isMonthly,
      principleInterest: principleInterest,
      interestOnly: interestOnly,
      loadAmountValue: loadAmountValue,
      inValidAmount: inValidAmount,
      loadAmountMax: loadAmountMax,
      loadAmountMin: loadAmountMin,
      interestRateValue: interestRateValue,
      inValidInterest: inValidInterest,
      loadInterestMax: loadInterestMax,
      loadInterestMin: loadInterestMin,
      loadTermValue: loadTermValue,
      inValidTerm: inValidTerm,
      loadTermMax: loadTermMax,
      loadTermMin: loadTermMin,
      payFreq: payFreq,
      intWithout: intWithout,
      totalIntWithout: totalIntWithout,
      totalIntWith: totalIntWith,
      intWith: intWith,
      repaymentInterestOnly: repaymentInterestOnly,
      repayment: repayment,
    );
  }
}
