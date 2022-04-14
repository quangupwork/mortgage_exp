// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:math' as math;
import 'package:mortgage_exp/my_app.dart';
import 'package:mortgage_exp/src/helper/caculator_helper.dart';

void main() {
  List<int> openCalculate({
    required bool justMe,
    required int dependants,
    required int loanTerm,
    required double interestRate,
    required int netSalary,
    required int netSalary2,
    required int netIncome,
    required int carLoanRepay,
    required int otherPay,
    required int payFreqEarn,
    required int payFreqNext,
    required int payFreqIncome,
    required int payFreqCar,
    required int payFreqOther,
    required int creditCardRepay,
  }) {
    bool isSingle = justMe;
    int annualExpence = CaculatorHelper.getDependant(dependants, isSingle);

    int netSalPeriod = payFreqEarn;
    int netSalPeriod2;
    if (isSingle) {
      netSalary2 = 0;
      netSalPeriod2 = 0;
    } else {
      netSalPeriod2 = payFreqNext;
    }
    int netIncomePeriod = payFreqIncome;

    int carLoanRepayPeriod = payFreqCar;

    double homeRepay = 0;

    int otherPayPeriod = payFreqOther;

    double n = (loanTerm * 12).roundToDouble();
    double r = interestRate / (100 * 12);
    double _r = 1 + r;
    num _rn = math.pow(_r, n);

    int totalIncome = (netSalary * netSalPeriod) +
        (netSalary2 * netSalPeriod2) +
        (netIncome * netIncomePeriod);
    totalIncome.round();
    double expenditures = (carLoanRepay * carLoanRepayPeriod) +
        (homeRepay * 12) +
        (creditCardRepay * 12 * 0.03) +
        (otherPay * otherPayPeriod) +
        annualExpence; // total expences
    double checkBorrow = (totalIncome / 1.1) - expenditures;

    double loanAmount = 0;
    double monthlyRepay;

    if (checkBorrow < 0) {
    } else {
      double dispensableMonthlyIncome = checkBorrow / 12;

      loanAmount = dispensableMonthlyIncome / ((r * _rn) / (_rn - 1));
      loanAmount.round();
      monthlyRepay = (loanAmount * (r * (_rn / (_rn - 1))));
    }

    double monthlyIncomeInt = totalIncome / 12;

    double otherRep = ((carLoanRepay * carLoanRepayPeriod) / 12) +
        ((otherPay * otherPayPeriod) / 12) +
        (creditCardRepay * 0.03);

    double remainings = monthlyIncomeInt - (monthlyIncomeInt / 1.1);

    if (remainings < 0) {
      remainings = 0;
    }

    double totalMonthlyExpense = (annualExpence / 12) + otherRep;
    double livingExpreses = annualExpence / 12;

    double mortgageRepayment = (monthlyIncomeInt / 1.1) - totalMonthlyExpense;

    return [
      loanAmount.round(),
      monthlyIncomeInt.round(),
      mortgageRepayment.round(),
      otherRep.round(),
      livingExpreses.toInt(),
      remainings.round()
    ];
  }

  test('testCaculator', () {
    // expect(
    //     openCalculate(
    //       justMe: true,
    //       interestRate: 2,
    //       loanTerm: 28,
    //       netSalary: 8124,
    //       payFreqEarn: 12,
    //       netSalary2: 0,
    //       payFreqNext: 0,
    //       netIncome: 200,
    //       payFreqIncome: 12,
    //       carLoanRepay: 0,
    //       payFreqCar: 0,
    //       otherPay: 0,
    //       payFreqOther: 0,
    //       creditCardRepay: 10000,
    //       dependants: 2,
    //     ),
    //     [
    //       1259524,
    //       8324,
    //       4899,
    //       300,
    //       2368,
    //       757,
    //     ]);
    // expect(
    //     openCalculate(
    //       justMe: false,
    //       interestRate: 2,
    //       loanTerm: 28,
    //       netSalary: 8124,
    //       payFreqEarn: 12,
    //       netSalary2: 2000,
    //       payFreqNext: 12,
    //       netIncome: 200,
    //       payFreqIncome: 12,
    //       carLoanRepay: 0,
    //       payFreqCar: 0,
    //       otherPay: 0,
    //       payFreqOther: 0,
    //       creditCardRepay: 10000,
    //       dependants: 2,
    //     ),
    //     [
    //       1574044,
    //       10324,
    //       6122,
    //       300,
    //       2963,
    //       939,
    //     ]);
    // expect(
    //     openCalculate(
    //       justMe: false,
    //       interestRate: 2,
    //       loanTerm: 28,
    //       netSalary: 8124,
    //       payFreqEarn: 12,
    //       netSalary2: 2000,
    //       payFreqNext: 12,
    //       netIncome: 200,
    //       payFreqIncome: 12,
    //       carLoanRepay: 0,
    //       payFreqCar: 0,
    //       otherPay: 0,
    //       payFreqOther: 0,
    //       creditCardRepay: 10000,
    //       dependants: 1,
    //     ),
    //     [
    //       1698659,
    //       10324,
    //       6607,
    //       300,
    //       2478,
    //       939,
    //     ]);
    // expect(
    //     openCalculate(
    //       justMe: false,
    //       interestRate: 2,
    //       loanTerm: 28,
    //       netSalary: 8124,
    //       payFreqEarn: 12,
    //       netSalary2: 2000,
    //       payFreqNext: 12,
    //       netIncome: 200,
    //       payFreqIncome: 12,
    //       carLoanRepay: 0,
    //       payFreqCar: 0,
    //       otherPay: 0,
    //       payFreqOther: 0,
    //       creditCardRepay: 10000,
    //       dependants: 3,
    //     ),
    //     [
    //       1449407,
    //       10324,
    //       5637,
    //       300,
    //       3448,
    //       939,
    //     ]);
    expect(
        openCalculate(
          justMe: true,
          interestRate: 2,
          loanTerm: 28,
          netSalary: 8124,
          payFreqEarn: 12,
          netSalary2: 0,
          payFreqNext: 0,
          netIncome: 200,
          payFreqIncome: 12,
          carLoanRepay: 0,
          payFreqCar: 0,
          otherPay: 0,
          payFreqOther: 0,
          creditCardRepay: 10000,
          dependants: 3,
        ),
        [
          1134910,
          8324,
          4414,
          300,
          2853,
          757,
        ]);
    // expect(
    //     openCalculate(
    //       justMe: true,
    //       interestRate: 2,
    //       loanTerm: 30,
    //       netSalary: 8124,
    //       payFreqEarn: 12,
    //       netSalary2: 0,
    //       payFreqNext: 0,
    //       netIncome: 200,
    //       payFreqIncome: 12,
    //       carLoanRepay: 0,
    //       payFreqCar: 0,
    //       otherPay: 0,
    //       payFreqOther: 0,
    //       creditCardRepay: 10000,
    //       dependants: 3,
    //     ),
    //     [
    //       1194206,
    //       8324,
    //       4414,
    //       300,
    //       2853,
    //       757,
    //     ]);
    // expect(
    //     openCalculate(
    //       justMe: true,
    //       interestRate: 2.4,
    //       loanTerm: 30,
    //       netSalary: 4064,
    //       payFreqEarn: 12,
    //       netSalary2: 0,
    //       payFreqNext: 0,
    //       netIncome: 0,
    //       payFreqIncome: 0,
    //       carLoanRepay: 100,
    //       payFreqCar: 26,
    //       otherPay: 0,
    //       payFreqOther: 0,
    //       creditCardRepay: 7000,
    //       dependants: 1,
    //     ),
    //     [
    //       354912,
    //       4064,
    //       1386,
    //       427,
    //       1883,
    //       369,
    //     ]);
    // expect(
    //     openCalculate(
    //       justMe: true,
    //       interestRate: 2.4,
    //       loanTerm: 30,
    //       netSalary: 4064,
    //       payFreqEarn: 26,
    //       netSalary2: 0,
    //       payFreqNext: 0,
    //       netIncome: 0,
    //       payFreqIncome: 0,
    //       carLoanRepay: 100,
    //       payFreqCar: 26,
    //       otherPay: 0,
    //       payFreqOther: 0,
    //       creditCardRepay: 7000,
    //       dependants: 1,
    //     ),
    //     [
    //       1460275,
    //       8805,
    //       5696,
    //       427,
    //       1883,
    //       800,
    //     ]);
    expect(
        openCalculate(
          justMe: false,
          interestRate: 2.4,
          loanTerm: 30,
          netSalary: 4064,
          payFreqEarn: 12,
          netSalary2: 2000,
          payFreqNext: 12,
          netIncome: 0,
          payFreqIncome: 0,
          carLoanRepay: 100,
          payFreqCar: 26,
          otherPay: 0,
          payFreqOther: 0,
          creditCardRepay: 7000,
          dependants: 1,
        ),
        [
          668614,
          6064,
          2609,
          427,
          2478,
          551,
        ]);
  });
}
