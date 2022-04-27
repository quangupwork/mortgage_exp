import '../../../../src/bloc/base.dart';

class RepaymentEvent extends IBaseEvent {}

class InitRepaymentEvent extends RepaymentEvent {}

class ChangeFrequencyEvent extends RepaymentEvent {
  String key;
  ChangeFrequencyEvent({required this.key});
}

class ChangeTypeEvent extends RepaymentEvent {
  String key;
  ChangeTypeEvent({required this.key});
}

class ProgressChangeEvent extends RepaymentEvent {
  String key;
  double lowerValue;
  ProgressChangeEvent({
    required this.key,
    required this.lowerValue,
  });
}

class InitTextFieldEvent extends RepaymentEvent {}

class CaculateEvent extends RepaymentEvent {
  String loadAmount;
  String interestRate;
  String loadTerm;
  CaculateEvent({
    required this.loadAmount,
    required this.interestRate,
    required this.loadTerm,
  });
}
