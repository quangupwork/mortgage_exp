import '../../src/constants.dart';

import 'base_preference.dart';

class AppPreference extends BasePreference {
  Future<String?> get loadAmount async =>
      await getLocal(PreferenceKeys.loadAmount);

  Future setLoadAmount(String? value) async =>
      await setLocal(PreferenceKeys.loadAmount, value);

  Future<String?> get interestRate async =>
      await getLocal(PreferenceKeys.interestRate);

  Future setInterestRate(String? value) async =>
      await setLocal(PreferenceKeys.interestRate, value);

  Future<String?> get loanTerm async => await getLocal(PreferenceKeys.loanTerm);

  Future setLoanTerm(String? value) async =>
      await setLocal(PreferenceKeys.loanTerm, value);

  Future<bool?> get isWeekly async => await getBool(PreferenceKeys.isWeekly);

  Future setWeekly(bool? value) async =>
      await setBool(PreferenceKeys.isWeekly, value);

  Future<bool?> get isFortnightly async =>
      await getBool(PreferenceKeys.isFortnightly);

  Future setFortnightly(bool? value) async =>
      await setBool(PreferenceKeys.isFortnightly, value);

  Future<bool?> get isMonthly async => await getBool(PreferenceKeys.isMonthly);

  Future setMonthly(bool? value) async =>
      await setBool(PreferenceKeys.isMonthly, value);

  Future<bool?> get principleInterest async =>
      await getBool(PreferenceKeys.principleInterest);

  Future setPrincipleInterest(bool? value) async =>
      await setBool(PreferenceKeys.isMonthly, value);

  Future<bool?> get interestOnly async =>
      await getBool(PreferenceKeys.interestOnly);

  Future setInterestOnly(bool? value) async =>
      await setBool(PreferenceKeys.interestOnly, value);

  Future<bool?> get firstRepayment async =>
      await getBool(PreferenceKeys.firstRepayment);

  Future setFirstRepayment(bool? value) async =>
      await setBool(PreferenceKeys.firstRepayment, value);
}
