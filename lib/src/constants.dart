import 'package:flutter/material.dart';

class Constants {
  static const String appName = 'River Group';

  // Responsive
  static const kTabletBreakpoint = 650;
  static const kDesktopBreakpoint = 1100;

  static List<Locale> languages = const [
    Locale('en'),
    Locale('vi'),
  ];
}

class PreferenceKeys {
  static const String firstRepayment = 'FIRST_REPAYMENT';
  static const String loadAmount = 'LOAN_AMOUNT';
  static const String interestRate = 'INTEREST_RATE';
  static const String loanTerm = 'LOAN_TERM';
  static const String extraRepayment = 'EXTRA_REPAYMENT';
  static const String isWeekly = 'WEEKLY';
  static const String isFortnightly = 'FORTNIGHTLY';
  static const String isMonthly = 'MONTHLY';
  static const String principleInterest = 'PRINCIPLE_INTEREST';
  static const String interestOnly = 'INTEREST_ONLY';
}

class ImageAssetPath {
  static const String icBack = 'assets/images/ic_back.png';
  static const String icArrow = 'assets/images/ic_arrow.png';
  static const String icAbout = 'assets/images/ic_about.png';
  static const String icBorrowing = 'assets/images/ic_borrowing.png';
  static const String icCall = 'assets/images/ic_call.png';
  static const String icEmail = 'assets/images/ic_email.png';
  static const String icExtraRepayment = 'assets/images/ic_extra_repayment.png';
  static const String icFindAdviser = 'assets/images/ic_find_adviser.png';
  static const String icLogo = 'assets/images/ic_logo.png';
  static const String icRepayment = 'assets/images/ic_repayment.png';
  static const String icYourPayment = 'assets/images/ic_your_payment.png';
  static const String icCurrency = 'assets/images/ic_currency.png';
  static const String icPercent = 'assets/images/ic_percent.png';
}
