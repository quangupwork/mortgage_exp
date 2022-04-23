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

  Future<String?> get earnTax async => await getLocal(PreferenceKeys.earnTax);

  Future setEarnTax(String? value) async =>
      await setLocal(PreferenceKeys.earnTax, value);

  Future<String?> get nextTax async => await getLocal(PreferenceKeys.nextTax);

  Future setNextTax(String? value) async =>
      await setLocal(PreferenceKeys.nextTax, value);

  Future<String?> get income async => await getLocal(PreferenceKeys.income);

  Future setIncome(String? value) async =>
      await setLocal(PreferenceKeys.income, value);

  Future<String?> get dependant async =>
      await getLocal(PreferenceKeys.dependant);

  Future setDependant(String? value) async =>
      await setLocal(PreferenceKeys.dependant, value);

  Future<String?> get carLoan async => await getLocal(PreferenceKeys.carLoan);

  Future setCarLoan(String? value) async =>
      await setLocal(PreferenceKeys.carLoan, value);

  Future<String?> get credit async => await getLocal(PreferenceKeys.credit);

  Future setCredit(String? value) async =>
      await setLocal(PreferenceKeys.credit, value);
  Future<String?> get otherLoan async =>
      await getLocal(PreferenceKeys.otherLoan);

  Future setOtherLoan(String? value) async =>
      await setLocal(PreferenceKeys.otherLoan, value);

  Future<String?> get extraRepayment async =>
      await getLocal(PreferenceKeys.extraRepayment);

  Future setExtraRepayment(String? value) async =>
      await setLocal(PreferenceKeys.extraRepayment, value);

  Future<bool?> get isWeekly async => await getBool(PreferenceKeys.isWeekly);

  Future setWeekly(bool? value) async =>
      await setBool(PreferenceKeys.isWeekly, value);

  Future<bool?> get earnWeekly async =>
      await getBool(PreferenceKeys.earnWeekly);

  Future setEarnWeekly(bool? value) async =>
      await setBool(PreferenceKeys.earnWeekly, value);

  Future<bool?> get earnFortnightly async =>
      await getBool(PreferenceKeys.earnFortnightly);

  Future setEarnFortnightly(bool? value) async =>
      await setBool(PreferenceKeys.earnFortnightly, value);

  Future<bool?> get earnMonthly async =>
      await getBool(PreferenceKeys.earnMonthly);

  Future setEarnMonthly(bool? value) async =>
      await setBool(PreferenceKeys.earnMonthly, value);

  Future<bool?> get nextWeekly async =>
      await getBool(PreferenceKeys.nextWeekly);

  Future setNextWeekly(bool? value) async =>
      await setBool(PreferenceKeys.nextWeekly, value);

  Future<bool?> get nextFortnightly async =>
      await getBool(PreferenceKeys.nextFortnightly);

  Future setNextFortnightly(bool? value) async =>
      await setBool(PreferenceKeys.nextFortnightly, value);

  Future<bool?> get nextMonthly async =>
      await getBool(PreferenceKeys.nextMonthly);

  Future setNextMonthly(bool? value) async =>
      await setBool(PreferenceKeys.nextMonthly, value);

  Future<bool?> get carWeekly async => await getBool(PreferenceKeys.carWeekly);

  Future setCarWeekly(bool? value) async =>
      await setBool(PreferenceKeys.carWeekly, value);

  Future<bool?> get carFortnightly async =>
      await getBool(PreferenceKeys.carFortnightly);

  Future setCarFortnightly(bool? value) async =>
      await setBool(PreferenceKeys.carFortnightly, value);

  Future<bool?> get carMonthly async =>
      await getBool(PreferenceKeys.carMonthly);

  Future setCarMonthly(bool? value) async =>
      await setBool(PreferenceKeys.carMonthly, value);

  Future<bool?> get otherWeekly async =>
      await getBool(PreferenceKeys.otherWeekly);

  Future setOtherWeekly(bool? value) async =>
      await setBool(PreferenceKeys.otherWeekly, value);

  Future<bool?> get otherFortnightly async =>
      await getBool(PreferenceKeys.otherFortnightly);

  Future setOtherFortnightly(bool? value) async =>
      await setBool(PreferenceKeys.otherFortnightly, value);

  Future<bool?> get otherMonthly async =>
      await getBool(PreferenceKeys.otherMonthly);

  Future setOtherMonthly(bool? value) async =>
      await setBool(PreferenceKeys.otherMonthly, value);

  Future<bool?> get incomeWeekly async =>
      await getBool(PreferenceKeys.incomeWeekly);

  Future setIncomeWeekly(bool? value) async =>
      await setBool(PreferenceKeys.incomeWeekly, value);

  Future<bool?> get incomeFortnightly async =>
      await getBool(PreferenceKeys.incomeFortnightly);

  Future setIncomeFortnightly(bool? value) async =>
      await setBool(PreferenceKeys.incomeFortnightly, value);

  Future<bool?> get incomeMonthly async =>
      await getBool(PreferenceKeys.incomeMonthly);

  Future setIncomeMonthly(bool? value) async =>
      await setBool(PreferenceKeys.incomeMonthly, value);

  Future<bool?> get justMe async => await getBool(PreferenceKeys.justMe);

  Future setJustMe(bool? value) async =>
      await setBool(PreferenceKeys.justMe, value);

  Future<bool?> get isFortnightly async => await getBool(PreferenceKeys.twoUs);

  Future setFortnightly(bool? value) async =>
      await setBool(PreferenceKeys.twoUs, value);

  Future<bool?> get twoUs async => await getBool(PreferenceKeys.twoUs);

  Future setTwoUs(bool? value) async =>
      await setBool(PreferenceKeys.twoUs, value);

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

  Future<List<String>?> get saveFilter async =>
      await getListString(PreferenceKeys.saveFilter);

  Future setSaveFilter(List<String>? value) async =>
      await setListString(PreferenceKeys.saveFilter, value);

  Future<List<String>?> get savePost async =>
      await getListString(PreferenceKeys.savePost);

  Future setSavePost(List<String>? value) async =>
      await setListString(PreferenceKeys.savePost, value);

  Future<List<String>?> get saveDocument async =>
      await getListString(PreferenceKeys.saveDocument);

  Future setSaveDocument(List<String>? value) async =>
      await setListString(PreferenceKeys.saveDocument, value);
}
