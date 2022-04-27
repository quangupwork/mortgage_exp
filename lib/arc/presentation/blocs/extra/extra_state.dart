import '../../../../src/bloc/base.dart';

class ExtraState extends IBaseState {}

class ExtraLoaded extends ExtraState {
  bool? isWeekly;
  bool? isFortnightly;
  bool? isMonthly;
  bool? principleInterest;
  bool? interestOnly;
  List<double>? repaymentValue;
  bool? inValidRepayment;
  double? repaymentMax;
  double? repaymentMin;
  List<double>? loadAmountValue;
  bool? inValidAmount;
  double? loadAmountMax;
  double? loadAmountMin;
  List<double>? interestRateValue;
  bool? inValidInterest;
  double? loadInterestMax;
  double? loadInterestMin;
  List<double>? loadTermValue;
  bool? inValidTerm;
  double? loadTermMax;
  double? loadTermMin;
  int? payFreq;
  double? intWithout;
  double? totalIntWithout;
  double? totalIntWith;
  double? intWith;
  double? repaymentInterestOnly;
  double? repayment;
  double? total;
  String? time;

  ExtraLoaded({
    required this.total,
    required this.time,
    required this.repaymentValue,
    required this.inValidRepayment,
    required this.repaymentMax,
    required this.repaymentMin,
    required this.isWeekly,
    required this.isFortnightly,
    required this.isMonthly,
    required this.principleInterest,
    required this.interestOnly,
    required this.loadAmountValue,
    required this.inValidAmount,
    required this.loadAmountMax,
    required this.loadAmountMin,
    required this.interestRateValue,
    required this.inValidInterest,
    required this.loadInterestMax,
    required this.loadInterestMin,
    required this.loadTermValue,
    required this.inValidTerm,
    required this.loadTermMax,
    required this.loadTermMin,
    required this.payFreq,
    required this.intWithout,
    required this.totalIntWithout,
    required this.totalIntWith,
    required this.intWith,
    required this.repaymentInterestOnly,
    required this.repayment,
  });

  ExtraLoaded copyWith({
    List<double>? repaymentValue,
    bool? inValidRepayment,
    double? repaymentMax,
    double? repaymentMin,
    bool? isWeekly,
    bool? isFortnightly,
    bool? isMonthly,
    bool? principleInterest,
    bool? interestOnly,
    List<double>? loadAmountValue,
    bool? inValidAmount,
    double? loadAmountMax,
    double? loadAmountMin,
    List<double>? interestRateValue,
    bool? inValidInterest,
    double? loadInterestMax,
    double? loadInterestMin,
    List<double>? loadTermValue,
    bool? inValidTerm,
    double? loadTermMax,
    double? loadTermMin,
    int? payFreq,
    double? intWithout,
    double? totalIntWithout,
    double? totalIntWith,
    double? intWith,
    double? repaymentInterestOnly,
    double? repayment,
    double? amount,
    double? interest,
    double? loadTerm,
    double? total,
    String? time,
  }) {
    return ExtraLoaded(
      total: total ?? this.total,
      time: time ?? this.time,
      repaymentMin: repaymentMin ?? this.repaymentMin,
      repaymentMax: repaymentMax ?? this.repaymentMax,
      inValidRepayment: inValidRepayment ?? this.inValidRepayment,
      repaymentValue: repaymentValue ?? this.repaymentValue,
      isWeekly: isWeekly ?? this.isWeekly,
      isFortnightly: isFortnightly ?? this.isFortnightly,
      isMonthly: isMonthly ?? this.isMonthly,
      principleInterest: principleInterest ?? this.principleInterest,
      interestOnly: interestOnly ?? this.interestOnly,
      loadAmountValue: loadAmountValue ?? this.loadAmountValue,
      inValidAmount: inValidAmount ?? this.inValidAmount,
      loadAmountMax: loadAmountMax ?? this.loadAmountMax,
      loadAmountMin: loadAmountMin ?? this.loadAmountMin,
      interestRateValue: interestRateValue ?? this.interestRateValue,
      inValidInterest: inValidInterest ?? this.inValidInterest,
      loadInterestMax: loadInterestMax ?? this.loadInterestMax,
      loadInterestMin: loadInterestMin ?? this.loadInterestMin,
      loadTermValue: loadTermValue ?? this.loadTermValue,
      inValidTerm: inValidTerm ?? this.inValidTerm,
      loadTermMax: loadTermMax ?? this.loadTermMax,
      loadTermMin: loadTermMin ?? this.loadTermMin,
      payFreq: payFreq ?? this.payFreq,
      intWithout: intWithout ?? this.intWithout,
      totalIntWithout: totalIntWithout ?? this.totalIntWithout,
      totalIntWith: totalIntWith ?? this.totalIntWith,
      intWith: intWith ?? this.intWith,
      repaymentInterestOnly:
          repaymentInterestOnly ?? this.repaymentInterestOnly,
      repayment: repayment ?? this.repayment,
    );
  }
}
