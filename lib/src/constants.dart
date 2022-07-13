import 'package:flutter/material.dart';

class Constants {
  static const String appName = 'Mortgage Express';

  static const String email = 'info@mx.co.nz';
  static const String phone = '0800 226 226';
  // Responsive
  static const kTabletBreakpoint = 650;
  static const kDesktopBreakpoint = 1100;

  static List<Locale> languages = const [
    Locale('en'),
    Locale('vi'),
  ];
  static List<int> categoryIDS = [
    3883698826, // All Regions
    4030995060, // Auckland
    4031001500, // Bay of Plenty
    3838289969, // Chinese Speaking
    3838290214, // Christchurch
    4031000525, // Hamilton, Waikato
    3838290249, // Hawkes Bay
    3883709516, // Marlborough
    3895800217, // Migrant
    4031001625, // Nelson
    3900843318, // New Plymouth
    3895800592, // Northland
    3883704076, // Tauranga
    4059967301, // Wellington
    34971721693, // Otago Advisers
    18132082503, // South Canterbury Advisers
  ];
}

class PreferenceKeys {
  static const String saveFilter = 'FILTER';
  static const String savePost = 'POST';
  static const String saveDocument = 'DOCUMENT';
  static const String loadAmount = 'LOAN_AMOUNT';
  static const String interestRate = 'INTEREST_RATE';
  static const String loanTerm = 'LOAN_TERM';
  static const String earnTax = 'EARN_TAX';
  static const String nextTax = 'NEXT_TAX';
  static const String income = 'INCOME';
  static const String justMe = 'JUST_ME';
  static const String twoUs = 'TWO_US';
  static const String dependant = 'DEPENDANT';
  static const String carLoan = 'CAR_LOAN';
  static const String credit = 'CREDIT';
  static const String otherLoan = 'OTHER_LOAN';
  static const String extraRepayment = 'EXTRA_REPAYMENT';
  static const String isWeekly = 'WEEKLY';
  static const String isFortnightly = 'FORTNIGHTLY';
  static const String isMonthly = 'MONTHLY';
  static const String isExtraWeekly = 'EXTRA_WEEKLY';
  static const String isExtraFortnightly = 'EXTRA_FORTNIGHTLY';
  static const String isExtraMonthly = 'EXTRA_MONTHLY';
  static const String earnWeekly = 'EARN_WEEKLY';
  static const String earnFortnightly = 'EARN_FORTNIGHTLY';
  static const String earnMonthly = 'EARN_MONTHLY';
  static const String nextWeekly = 'NEXT_WEEKLY';
  static const String nextFortnightly = 'NEXT_FORTNIGHTLY';
  static const String nextMonthly = 'NEXT_MONTHLY';
  static const String carWeekly = 'CAR_WEEKLY';
  static const String carFortnightly = 'CAR_FORTNIGHTLY';
  static const String carMonthly = 'CAR_MONTHLY';
  static const String otherWeekly = 'OTHER_WEEKLY';
  static const String otherFortnightly = 'OTHER_FORTNIGHTLY';
  static const String otherMonthly = 'OTHER_MONTHLY';
  static const String incomeWeekly = 'INCOME_WEEKLY';
  static const String incomeFortnightly = 'INCOME__FORTNIGHTLY';
  static const String incomeMonthly = 'INCOME__MONTHLY';
  static const String principleInterest = 'PRINCIPLE_INTEREST';
  static const String interestOnly = 'INTEREST_ONLY';
}

class ImageAssetPath {
  static const String icBack = 'assets/images/ic_back.png';
  static const String icArrow = 'assets/images/ic_arrow.png';
  static const String icAbout = 'assets/images/ic_about.png';
  static const String icCheck = 'assets/images/ic_check.png';
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
  static const String icFilter = 'assets/images/ic_filter.png';
}
