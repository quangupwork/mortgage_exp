import '../../../../src/bloc/base.dart';
import '../../../../src/helper/convert_helper.dart';
import '../../widgets/commons/dialog.dart';
import '../blocs.dart';
import 'dart:math' as math;

class RepaymentBloc extends IBaseBloc {
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

  @override
  void registerEvents() {
    registerEvent<InitRepaymentEvent>(
        (event) => _initRepayment(event as InitRepaymentEvent));
    registerEvent<ChangeFrequencyEvent>(
        (event) => _changeRequency(event as ChangeFrequencyEvent));
    registerEvent<ChangeTypeEvent>(
        (event) => _changeType(event as ChangeTypeEvent));
    registerEvent<CaculateEvent>((event) => _caculate(event as CaculateEvent));
    registerEvent<ProgressChangeEvent>(
        (event) => _onProgress(event as ProgressChangeEvent));
    registerEvent<InitTextFieldEvent>(
        (event) => _initTextField(event as InitTextFieldEvent));
  }

  Stream<IBaseState> _initTextField(InitTextFieldEvent event) async* {
    final currentState = state as RepaymentLoaded;
    final amount = await appPreference.loadAmount ?? '500,000';
    final interest = await appPreference.interestRate ?? '2';
    final term = await appPreference.loanTerm ?? '30';
    final weekly = await appPreference.isWeekly ?? false;
    final fortnightly = await appPreference.isFortnightly ?? false;
    final monthly = await appPreference.isMonthly ?? false;
    final principle = await appPreference.principleInterest ?? false;
    final only = await appPreference.interestOnly ?? false;

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
    yield currentState.copyWith(
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

  Stream<IBaseState> _onProgress(ProgressChangeEvent event) async* {
    final currentState = state as RepaymentLoaded;
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

  Stream<IBaseState> _changeType(ChangeTypeEvent event) async* {
    final currentState = state as RepaymentLoaded;
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

  Stream<IBaseState> _caculate(CaculateEvent event) async* {
    final currentState = state as RepaymentLoaded;
    int amount = int.parse(event.loadAmount.replaceAll(',', ''));
    int loanTerm = int.parse(event.loadTerm);
    double intRate = double.parse(event.interestRate);

    double r = (intRate / (payFreq * 100));
    double n = (loanTerm * payFreq).ceilToDouble();
    double _r = (1 + r);
    num _rn = math.pow(_r, n);

    intWith = amount * (r * (_rn / (_rn - 1)));
    intWithout = r * amount;

    totalIntWithout = intWithout * n;
    totalIntWith = ((intWith - intWithout) * n) + totalIntWithout - amount;
    repayment = principleInterest ? intWith : intWithout;
    yield currentState.copyWith(
      intWith: intWith,
      intWithout: intWithout,
      totalIntWithout: totalIntWithout,
      totalIntWith: totalIntWith,
      repayment: repayment,
    );
  }

  Stream<IBaseState> _changeRequency(ChangeFrequencyEvent event) async* {
    final currentState = state as RepaymentLoaded;
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

  Stream<IBaseState> _initRepayment(InitRepaymentEvent event) async* {
    yield RepaymentLoaded(
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
