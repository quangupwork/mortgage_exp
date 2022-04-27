import '../../../../src/bloc/base.dart';

class ExtraEvent extends IBaseEvent {}

class InitExtraEvent extends ExtraEvent {}

class ExtraChangeFrequencyEvent extends ExtraEvent {
  String key;
  ExtraChangeFrequencyEvent({required this.key});
}

class ExtraChangeTypeEvent extends ExtraEvent {
  String key;
  ExtraChangeTypeEvent({required this.key});
}

class ExtraProgressChangeEvent extends ExtraEvent {
  String key;
  double lowerValue;
  ExtraProgressChangeEvent({
    required this.key,
    required this.lowerValue,
  });
}

class ExtraInitTextFieldEvent extends ExtraEvent {}

class ExtraCaculateEvent extends ExtraEvent {
  String loadAmount;
  String interestRate;
  String loadTerm;
  String extra;
  ExtraCaculateEvent({
    required this.loadAmount,
    required this.interestRate,
    required this.loadTerm,
    required this.extra,
  });
}
