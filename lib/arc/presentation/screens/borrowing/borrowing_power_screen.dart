import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:mortgage_exp/arc/presentation/widgets/commons/footer_widget.dart';
import 'package:mortgage_exp/src/config/config.dart';
import 'package:mortgage_exp/src/extensions/extension.dart';
import 'package:mortgage_exp/src/helper/caculator_helper.dart';
import 'package:mortgage_exp/src/utilities/showtoast.dart';

import '../../../../injector.dart';
import '../../../../src/helper/convert_helper.dart';
import '../../../../src/preferences/app_preference.dart';
import '../../../../src/styles/style.dart';
import '../../../../src/utilities/utilities.dart';
import '../../widgets/commons/custom_app_bar.dart';
import '../../widgets/commons/custom_textfield.dart';
import '../../widgets/commons/select_button.dart';
import '../../widgets/commons/slider.dart';
import 'widgets/button_next.dart';
import 'widgets/item_tab.dart';
import 'dart:math' as math;

class BorrowingPowerScreen extends StatefulWidget {
  const BorrowingPowerScreen({Key? key}) : super(key: key);

  @override
  State<BorrowingPowerScreen> createState() => _BorrowingPowerScreenState();
}

class _BorrowingPowerScreenState extends State<BorrowingPowerScreen> {
  final navigator = AppDependencies.injector.get<NavigationService>();
  final appPreference = AppDependencies.injector.get<AppPreference>();
  final formatter = NumberFormat('###,###');
  final formatterPercent = NumberFormat('#.##');
  final controller = PageController(keepPage: false);
  bool isLoad = true;
  bool isIncome = false;
  bool isExpense = false;
  List<double> interestRateValue = [2.2];
  bool inValidInterest = false;
  double loadInterestMax = 6.5;
  double loadInterestMin = 0.5;
  List<double> loadTermValue = [30];
  bool inValidTerm = false;
  double loadTermMax = 30;
  double loadTermMin = 10;
  List<double> earnTaxValue = [5000];
  bool inValidEarnTax = false;
  double earnTaxMax = 25000;
  double earnTaxMin = 0;
  bool earnWeekly = true;
  bool earnFortnightly = false;
  bool earnMonthly = false;
  int payFreqEarn = 12;
  List<double> nextTaxValue = [5000];
  bool inValidNextTax = false;
  double nextTaxMax = 25000;
  double nextTaxMin = 0;
  bool nextWeekly = true;
  bool nextFortnightly = false;
  bool nextMonthly = false;
  int payFreqNext = 12;
  List<double> incomeValue = [200];
  bool inValidIncome = false;
  double incomeMax = 100000;
  double incomeMin = 0;
  bool incomeWeekly = true;
  bool incomeFortnightly = false;
  bool incomeMonthly = false;
  int payFreqIncome = 12;
  List<double> carLoanValue = [300];
  bool inValidCarLoan = false;
  double carLoanMax = 20000;
  double carLoanMin = 0;
  bool carWeekly = true;
  bool carFortnightly = false;
  bool carMonthly = false;
  int payFreqCar = 12;
  List<double> otherLoanValue = [0];
  bool inValidOtherLoan = false;
  double otherLoanMax = 20000;
  double otherLoanMin = 0;
  bool otherWeekly = true;
  bool otherFortnightly = false;
  bool otherMonthly = false;
  int payFreqOther = 12;
  List<double> creditValue = [10000];
  bool inValidCredit = false;
  double creditMax = 100000;
  double creditMin = 0;
  List<double> dependantValue = [2];
  bool inValidDependant = false;
  double dependantMax = 5;
  double dependantMin = 0;
  bool justMe = true;
  bool twoUs = false;

  final interesetRateController = TextEditingController();
  final loadTermController = TextEditingController();
  final earnTaxController = TextEditingController();
  final nextTaxController = TextEditingController();
  final incomeController = TextEditingController();
  final carLoanController = TextEditingController();
  final otherLoanController = TextEditingController();
  final creditController = TextEditingController();
  final dependantController = TextEditingController();

  final dependantNode = FocusNode();
  final creditNode = FocusNode();
  final otherLoanNode = FocusNode();
  final carLoanNode = FocusNode();
  final incomeNode = FocusNode();
  final nextTaxNode = FocusNode();
  final earnTaxNode = FocusNode();
  final interesetRateNode = FocusNode();
  final loadTermNode = FocusNode();
  int currentPage = 0;
  Future<void> onChangeTab(int key, bool isAnimated) async {
    if (key == 0) {
      currentPage = key;
      isLoad = true;
      isIncome = false;
      isExpense = false;
      if (isAnimated) {
        controller.animateToPage(0,
            duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      } else {
        controller.jumpToPage(0);
      }

      setState(() {});
    }
    if (key == 1) {
      currentPage = key;
      isLoad = false;
      isIncome = true;
      isExpense = false;
      if (isAnimated) {
        controller.animateToPage(1,
            duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      } else {
        controller.jumpToPage(1);
      }
      setState(() {});
    }
    if (key == 2) {
      currentPage = key;
      if (isAnimated) {
        controller.animateToPage(2,
            duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      } else {
        controller.jumpToPage(2);
      }

      isLoad = false;
      isIncome = false;
      isExpense = true;
      setState(() {});
    }
  }

  Future<void> changeLoanType(String key) async {
    if (key == '1') {
      justMe = true;
      twoUs = false;
      setState(() {});
    }
    if (key == '2') {
      justMe = false;
      twoUs = true;
      setState(() {});
    }
    await appPreference.setJustMe(justMe);
    await appPreference.setTwoUs(twoUs);
  }

  Future<void> onProgress(
    double lowerValue,
    String key,
  ) async {
    if (key == 'interest_rate') {
      interesetRateController.text =
          ConvertHelper.formartNumber(lowerValue.toStringAsFixed(2));
      interestRateValue[0] = lowerValue;
      await appPreference.setInterestRate(
          ConvertHelper.formartNumber(lowerValue.toStringAsFixed(2)));
    }
    if (key == 'load_term') {
      loadTermController.text =
          ConvertHelper.formartNumber(lowerValue.toStringAsFixed(0));
      loadTermValue[0] = lowerValue;
      await appPreference.setLoanTerm(
          ConvertHelper.formartNumber(lowerValue.toStringAsFixed(0)));
    }
    if (key == 'earn_tax') {
      earnTaxController.text =
          ConvertHelper.formartNumber(lowerValue.toStringAsFixed(0));
      earnTaxValue[0] = lowerValue;
      await appPreference.setEarnTax(
          ConvertHelper.formartNumber(lowerValue.toStringAsFixed(0)));
    }
    if (key == 'next_tax') {
      nextTaxController.text =
          ConvertHelper.formartNumber(lowerValue.toStringAsFixed(0));
      nextTaxValue[0] = lowerValue;
      await appPreference.setNextTax(
          ConvertHelper.formartNumber(lowerValue.toStringAsFixed(0)));
    }
    if (key == 'income') {
      incomeController.text =
          ConvertHelper.formartNumber(lowerValue.toStringAsFixed(0));
      incomeValue[0] = lowerValue;
      await appPreference.setIncome(
          ConvertHelper.formartNumber(lowerValue.toStringAsFixed(0)));
    }
    if (key == 'car_loan') {
      carLoanController.text =
          ConvertHelper.formartNumber(lowerValue.toStringAsFixed(0));
      carLoanValue[0] = lowerValue;
      await appPreference.setCarLoan(
          ConvertHelper.formartNumber(lowerValue.toStringAsFixed(0)));
    }
    if (key == 'other_loan') {
      otherLoanController.text =
          ConvertHelper.formartNumber(lowerValue.toStringAsFixed(0));
      otherLoanValue[0] = lowerValue;
      await appPreference.setOtherLoan(
          ConvertHelper.formartNumber(lowerValue.toStringAsFixed(0)));
    }
    if (key == 'credit') {
      creditController.text =
          ConvertHelper.formartNumber(lowerValue.toStringAsFixed(0));
      creditValue[0] = lowerValue;
      await appPreference.setCredit(
          ConvertHelper.formartNumber(lowerValue.toStringAsFixed(0)));
    }
    if (key == 'dependant') {
      dependantController.text =
          ConvertHelper.formartNumber(lowerValue.toStringAsFixed(0));
      dependantValue[0] = lowerValue;
      await appPreference.setDependant(
          ConvertHelper.formartNumber(lowerValue.toStringAsFixed(0)));
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initTextField();
  }

  Future<void> onChangeType(String key) async {
    if (key == 'earn_tax_week') {
      // if (earnWeekly) {
      //   earnWeekly = false;
      //   earnFortnightly = false;
      //   earnMonthly = false;
      //   payFreqEarn = 1;
      //   earnTaxMax = 1000000;
      // } else {
      earnWeekly = true;
      earnFortnightly = false;
      earnMonthly = false;
      payFreqEarn = 52;
      earnTaxMax = 25000;
      // }
      if (earnTaxValue[0] > earnTaxMax) {
        earnTaxValue[0] = earnTaxMax;
      }
      await appPreference.setEarnWeekly(earnWeekly);
      await appPreference.setEarnFortnightly(earnFortnightly);
      await appPreference.setEarnMonthly(earnMonthly);
      setState(() {});
    }
    if (key == 'earn_tax_fortnight') {
      // if (earnFortnightly) {
      //   earnWeekly = false;
      //   earnFortnightly = false;
      //   earnMonthly = false;
      //   payFreqEarn = 1;
      //   earnTaxMax = 1000000;
      // } else {
      earnWeekly = false;
      earnFortnightly = true;
      earnMonthly = false;
      payFreqEarn = 26;
      earnTaxMax = 50000;
      // }
      if (earnTaxValue[0] > earnTaxMax) {
        earnTaxValue[0] = earnTaxMax;
      }
      await appPreference.setEarnWeekly(earnWeekly);
      await appPreference.setEarnFortnightly(earnFortnightly);
      await appPreference.setEarnMonthly(earnMonthly);
      setState(() {});
    }
    if (key == 'earn_tax_month') {
      // if (earnMonthly) {
      //   earnWeekly = false;
      //   earnFortnightly = false;
      //   earnMonthly = false;
      //   payFreqEarn = 1;
      //   earnTaxMax = 1000000;
      // } else {
      earnWeekly = false;
      earnFortnightly = false;
      earnMonthly = true;
      payFreqEarn = 12;
      earnTaxMax = 100000;
      // }
      if (earnTaxValue[0] > earnTaxMax) {
        inValidEarnTax = true;
      }
      await appPreference.setEarnWeekly(earnWeekly);
      await appPreference.setEarnFortnightly(earnFortnightly);
      await appPreference.setEarnMonthly(earnMonthly);
      setState(() {});
    }
    if (key == 'next_tax_week') {
      // if (nextWeekly) {
      //   nextWeekly = false;
      //   nextFortnightly = false;
      //   nextMonthly = false;
      //   payFreqNext = 1;
      //   nextTaxMax = 1000000;
      // } else {
      nextWeekly = true;
      nextFortnightly = false;
      nextMonthly = false;
      payFreqNext = 52;
      nextTaxMax = 25000;
      //}
      if (nextTaxValue[0] > nextTaxMax) {
        nextTaxValue[0] = nextTaxMax;
      }
      await appPreference.setNextWeekly(nextWeekly);
      await appPreference.setNextFortnightly(nextFortnightly);
      await appPreference.setNextMonthly(nextMonthly);
      setState(() {});
    }
    if (key == 'next_tax_fortnight') {
      // if (nextFortnightly) {
      //   nextWeekly = false;
      //   nextFortnightly = false;
      //   nextMonthly = false;
      //   payFreqNext = 1;
      //   nextTaxMax = 1000000;
      // } else {
      nextWeekly = false;
      nextFortnightly = true;
      nextMonthly = false;
      payFreqNext = 26;
      nextTaxMax = 50000;
      //  }
      if (nextTaxValue[0] > nextTaxMax) {
        nextTaxValue[0] = nextTaxMax;
      }
      await appPreference.setNextWeekly(nextWeekly);
      await appPreference.setNextFortnightly(nextFortnightly);
      await appPreference.setNextMonthly(nextMonthly);
      setState(() {});
    }
    if (key == 'next_tax_month') {
      // if (nextMonthly) {
      //   nextWeekly = false;
      //   nextFortnightly = false;
      //   nextMonthly = true;
      //   payFreqNext = 1;
      //   nextTaxMax = 1000000;
      // } else {
      nextWeekly = false;
      nextFortnightly = false;
      nextMonthly = true;
      payFreqNext = 12;
      nextTaxMax = 100000;
      //}
      if (nextTaxValue[0] > nextTaxMax) {
        nextTaxValue[0] = nextTaxMax;
      }
      await appPreference.setNextWeekly(nextWeekly);
      await appPreference.setNextFortnightly(nextFortnightly);
      await appPreference.setNextMonthly(nextMonthly);
      setState(() {});
    }
    if (key == 'income_week') {
      // if (incomeWeekly) {
      //   incomeWeekly = false;
      //   incomeFortnightly = false;
      //   incomeMonthly = false;
      //   payFreqIncome = 1;
      //   incomeMax = 1000000;
      // } else {
      incomeWeekly = true;
      incomeFortnightly = false;
      incomeMonthly = false;
      payFreqIncome = 52;
      incomeMax = 25000;
      //  }
      if (incomeValue[0] > incomeMax) {
        incomeValue[0] = incomeMax;
      }
      await appPreference.setIncomeWeekly(incomeWeekly);
      await appPreference.setIncomeFortnightly(incomeFortnightly);
      await appPreference.setIncomeMonthly(incomeMonthly);
      setState(() {});
    }
    if (key == 'income_fortnight') {
      // if (incomeFortnightly) {
      //   incomeWeekly = false;
      //   incomeFortnightly = false;
      //   incomeMonthly = false;
      //   payFreqIncome = 1;
      //   incomeMax = 1000000;
      // } else {
      incomeWeekly = false;
      incomeFortnightly = true;
      incomeMonthly = false;
      payFreqIncome = 26;
      incomeMax = 50000;
      //}
      if (incomeValue[0] > incomeMax) {
        incomeValue[0] = incomeMax;
      }
      await appPreference.setIncomeWeekly(incomeWeekly);
      await appPreference.setIncomeFortnightly(incomeFortnightly);
      await appPreference.setIncomeMonthly(incomeMonthly);
      setState(() {});
    }
    if (key == 'income_month') {
      // if (incomeMonthly) {
      //   incomeWeekly = false;
      //   incomeFortnightly = false;
      //   incomeMonthly = false;
      //   payFreqIncome = 1;
      //   incomeMax = 1000000;
      // } else {
      incomeWeekly = false;
      incomeFortnightly = false;
      incomeMonthly = true;
      payFreqIncome = 12;
      incomeMax = 100000;
      // }
      if (incomeValue[0] > incomeMax) {
        incomeValue[0] = incomeMax;
      }
      await appPreference.setIncomeWeekly(incomeWeekly);
      await appPreference.setIncomeFortnightly(incomeFortnightly);
      await appPreference.setIncomeMonthly(incomeMonthly);
      setState(() {});
    }
    if (key == 'car_week') {
      // if (carWeekly) {
      //   carWeekly = false;
      //   carFortnightly = false;
      //   carMonthly = false;
      //   payFreqCar = 1;
      //   carLoanMax = 20000;
      // } else {
      carWeekly = true;
      carFortnightly = false;
      carMonthly = false;
      payFreqCar = 52;
      carLoanMax = 500;
      //}
      if (carLoanValue[0] > carLoanMax) {
        carLoanValue[0] = carLoanMax;
      }
      await appPreference.setCarWeekly(carWeekly);
      await appPreference.setCarFortnightly(carFortnightly);
      await appPreference.setCarMonthly(carMonthly);
      setState(() {});
    }
    if (key == 'car_fortnight') {
      // if (carFortnightly) {
      //   carWeekly = false;
      //   carFortnightly = false;
      //   carMonthly = false;
      //   payFreqCar = 1;
      //   carLoanMax = 20000;
      // } else {
      carWeekly = false;
      carFortnightly = true;
      carMonthly = false;
      payFreqCar = 26;
      carLoanMax = 1000;
      //  }
      if (carLoanValue[0] > carLoanMax) {
        carLoanValue[0] = carLoanMax;
      }
      await appPreference.setCarWeekly(carWeekly);
      await appPreference.setCarFortnightly(carFortnightly);
      await appPreference.setCarMonthly(carMonthly);
      setState(() {});
    }
    if (key == 'car_month') {
      // if (carMonthly) {
      //   carWeekly = false;
      //   carFortnightly = false;
      //   carMonthly = false;
      //   payFreqCar = 1;
      //   carLoanMax = 20000;
      // } else {
      carWeekly = false;
      carFortnightly = false;
      carMonthly = true;
      payFreqCar = 12;
      carLoanMax = 2000;
      // }
      if (carLoanValue[0] > carLoanMax) {
        carLoanValue[0] = carLoanMax;
      }
      await appPreference.setCarWeekly(carWeekly);
      await appPreference.setCarFortnightly(carFortnightly);
      await appPreference.setCarMonthly(carMonthly);
      setState(() {});
    }
    if (key == 'other_week') {
      // if (otherWeekly) {
      //   otherWeekly = false;
      //   otherFortnightly = false;
      //   otherMonthly = false;
      //   payFreqOther = 1;
      //   otherLoanMax = 20000;
      // } else {
      otherWeekly = true;
      otherFortnightly = false;
      otherMonthly = false;
      payFreqOther = 52;
      otherLoanMax = 500;
      // }
      if (otherLoanValue[0] > otherLoanMax) {
        otherLoanValue[0] = otherLoanMax;
      }
      await appPreference.setOtherWeekly(otherWeekly);
      await appPreference.setOtherFortnightly(otherFortnightly);
      await appPreference.setOtherMonthly(otherMonthly);
      setState(() {});
    }
    if (key == 'other_fortnight') {
      // if (otherFortnightly) {
      //   otherWeekly = false;
      //   otherFortnightly = false;
      //   otherMonthly = false;
      //   payFreqOther = 1;
      //   otherLoanMax = 20000;
      // } else {
      otherWeekly = false;
      otherFortnightly = true;
      otherMonthly = false;
      payFreqOther = 26;
      otherLoanMax = 1000;
      // }
      if (otherLoanValue[0] > otherLoanMax) {
        otherLoanValue[0] = otherLoanMax;
      }
      await appPreference.setOtherWeekly(otherWeekly);
      await appPreference.setOtherFortnightly(otherFortnightly);
      await appPreference.setOtherMonthly(otherMonthly);
      setState(() {});
    }
    if (key == 'other_month') {
      // if (otherMonthly) {
      //   otherWeekly = false;
      //   otherFortnightly = false;
      //   otherMonthly = false;
      //   payFreqOther = 1;
      //   otherLoanMax = 20000;
      // } else {
      otherWeekly = false;
      otherFortnightly = false;
      otherMonthly = true;
      payFreqOther = 12;
      otherLoanMax = 2000;
      //}
      if (otherLoanValue[0] > otherLoanMax) {
        otherLoanValue[0] = otherLoanMax;
      }

      await appPreference.setOtherWeekly(otherWeekly);
      await appPreference.setOtherFortnightly(otherFortnightly);
      await appPreference.setOtherMonthly(otherMonthly);
      setState(() {});
    }
  }

  Future<void> initTextField() async {
    final interest = await appPreference.interestRate ??
        formatterPercent.format(interestRateValue[0]);
    final term =
        await appPreference.loanTerm ?? formatter.format(loadTermValue[0]);
    final earnTax =
        await appPreference.earnTax ?? formatter.format(earnTaxValue[0]);
    final nextTax =
        await appPreference.nextTax ?? formatter.format(nextTaxValue[0]);
    final income =
        await appPreference.income ?? formatter.format(incomeValue[0]);
    final carLoan =
        await appPreference.carLoan ?? formatter.format(carLoanValue[0]);
    final otherLoan =
        await appPreference.otherLoan ?? formatter.format(otherLoanValue[0]);
    final credit =
        await appPreference.credit ?? formatter.format(creditValue[0]);
    final dependant =
        await appPreference.dependant ?? formatter.format(dependantValue[0]);
    final just = await appPreference.justMe ?? false;
    final two = await appPreference.twoUs ?? false;
    final earnWeek = await appPreference.earnWeekly ?? false;
    final earnMonth = await appPreference.earnMonthly ?? false;
    final earnFortnight = await appPreference.earnFortnightly ?? false;
    final nextWeek = await appPreference.nextWeekly ?? false;
    final nextMonth = await appPreference.nextMonthly ?? false;
    final nextFortnight = await appPreference.nextFortnightly ?? false;
    final incomeWeek = await appPreference.incomeWeekly ?? false;
    final incomeMonth = await appPreference.incomeMonthly ?? false;
    final incomeFortnight = await appPreference.incomeFortnightly ?? false;
    final carWeek = await appPreference.carWeekly ?? false;
    final carMonth = await appPreference.carMonthly ?? false;
    final carFortnight = await appPreference.carFortnightly ?? false;
    final otherWeek = await appPreference.otherWeekly ?? false;
    final otherMonth = await appPreference.otherMonthly ?? false;
    final otherFortnight = await appPreference.otherFortnightly ?? false;
    interesetRateController.text = interest;
    interestRateValue[0] = double.parse(interest);
    loadTermController.text = term;
    loadTermValue[0] = double.parse(term.replaceAll(',', ''));
    earnTaxController.text = earnTax;
    earnTaxValue[0] = double.parse(earnTax.replaceAll(',', ''));
    nextTaxController.text = nextTax;
    nextTaxValue[0] = double.parse(nextTax.replaceAll(',', ''));
    incomeController.text = income;
    incomeValue[0] = double.parse(income.replaceAll(',', ''));
    carLoanController.text = carLoan;
    carLoanValue[0] = double.parse(carLoan.replaceAll(',', ''));
    otherLoanController.text = otherLoan;
    otherLoanValue[0] = double.parse(otherLoan.replaceAll(',', ''));
    creditController.text = credit;
    creditValue[0] = double.parse(credit.replaceAll(',', ''));
    dependantController.text = dependant;
    dependantValue[0] = double.parse(dependant.replaceAll(',', ''));
    justMe = just;
    twoUs = two;
    earnFortnightly = earnFortnight;
    earnMonthly = earnMonth;
    earnWeekly = earnWeek;
    nextFortnightly = nextFortnight;
    nextMonthly = nextMonth;
    nextWeekly = nextWeek;
    incomeFortnightly = incomeFortnight;
    incomeMonthly = incomeMonth;
    incomeWeekly = incomeWeek;
    carFortnightly = carFortnight;
    carMonthly = carMonth;
    carWeekly = carWeek;
    otherFortnightly = otherFortnight;
    otherMonthly = otherMonth;
    otherWeekly = otherWeek;
    if (!justMe && !twoUs) {
      justMe = true;
    }
    if (!earnWeekly && !earnMonthly && !earnFortnight) {
      earnMonthly = true;
      payFreqEarn = 12;
    }
    if (!incomeWeekly && !incomeMonthly && !incomeFortnight) {
      incomeMonthly = true;
      payFreqIncome = 12;
    }
    if (!nextWeekly && !nextMonthly && !nextFortnightly) {
      nextMonthly = true;
      payFreqNext = 12;
    }
    if (!carWeekly && !carMonthly && !carFortnightly) {
      carMonthly = true;
      payFreqCar = 12;
    }
    if (!otherWeekly && !otherMonthly && !otherFortnightly) {
      otherMonthly = true;
      payFreqOther = 12;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: theme.primaryColor,
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar.withLeading(title: "Borrowing Power"),
      body: Column(
        children: [
          Container(
            color: const Color(0xff434c57),
            padding: const EdgeInsets.symmetric(horizontal: Dimens.size40),
            child: Row(
              children: [
                Expanded(
                    child: ItemTab(
                  text: 'Loan \ndetails',
                  status: isLoad,
                  onTap: () => onChangeTab(0, false),
                )),
                Container(width: 1, height: Dimens.size20, color: Colors.white),
                Expanded(
                    child: ItemTab(
                  text: 'Income \ndetails',
                  onTap: () => onChangeTab(1, false),
                  status: isIncome,
                )),
                Container(width: 1, height: Dimens.size20, color: Colors.white),
                Expanded(
                    child: ItemTab(
                  text: 'Expense \ndetails',
                  onTap: () => onChangeTab(2, false),
                  status: isExpense,
                )),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller,
              onPageChanged: (index) => onChangeTab(index, true),
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: Dimens.size40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: Dimens.size30),
                      Text("Interest rate", style: theme.textTheme.bodyText1),
                      const SizedBox(height: Dimens.size8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              flex: 5,
                              child: SliderCustom(
                                values: interestRateValue,
                                max: loadInterestMax,
                                min: loadInterestMin,
                                step: const FlutterSliderStep(step: 0.1),
                                onDragging:
                                    (handlerIndex, lowerValue, upperValue) {
                                  onProgress(lowerValue, 'interest_rate');
                                },
                              )),
                          const SizedBox(width: Dimens.size4),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    TextFieldCustom(
                                      focusNode: interesetRateNode,
                                      controller: interesetRateController,
                                      suffixIcon: '%',
                                      textAlign: TextAlign.center,
                                      padding: const EdgeInsets.only(
                                          left: 24, top: 10, bottom: 10),
                                      onChanged: (value) async {
                                        final number = double.tryParse(
                                                interesetRateController.text) ??
                                            0;
                                        if (number > loadInterestMax) {
                                          inValidInterest = true;
                                          interestRateValue[0] =
                                              loadInterestMax;
                                          interesetRateController.text =
                                              loadInterestMax.toString();
                                          setState(() {});
                                        } else {
                                          if (number < loadInterestMin) {
                                            interestRateValue[0] =
                                                loadInterestMin;
                                            inValidInterest = true;
                                            setState(() {});
                                          } else {
                                            interestRateValue[0] = number;
                                            inValidInterest = false;
                                            setState(() {});
                                          }
                                        }
                                        await appPreference.setInterestRate(
                                            ConvertHelper.formartNumber(
                                                interestRateValue[0]
                                                    .toStringAsFixed(2)));
                                      },
                                    ),
                                    GestureDetector(
                                      onTap: () =>
                                          interesetRateNode.requestFocus(),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10, top: 10, bottom: 10),
                                          child: Text(
                                            '%',
                                            style: theme.textTheme
                                                .styleTextFields(),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                if (inValidInterest)
                                  const SizedBox(height: Dimens.size4),
                                if (inValidInterest)
                                  Text("Invalid number",
                                      style: theme.primaryTextTheme.error())
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: Dimens.size10),
                      Text("Loan term", style: theme.textTheme.bodyText1),
                      const SizedBox(height: Dimens.size8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              flex: 5,
                              child: SliderCustom(
                                values: loadTermValue,
                                max: loadTermMax,
                                min: loadTermMin,
                                step: const FlutterSliderStep(step: 1),
                                onDragging:
                                    (handlerIndex, lowerValue, upperValue) {
                                  onProgress(lowerValue, 'load_term');
                                },
                              )),
                          const SizedBox(width: Dimens.size4),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    TextFieldCustom(
                                      focusNode: loadTermNode,
                                      controller: loadTermController,
                                      suffixIcon: 'year',
                                      textAlign: TextAlign.center,
                                      padding: const EdgeInsets.only(
                                          left: 24, top: 10, bottom: 10),
                                      onChanged: (value) async {
                                        final number = double.tryParse(
                                                loadTermController.text
                                                    .replaceAll(',', '')) ??
                                            0;
                                        if (number > loadTermMax) {
                                          inValidTerm = true;
                                          loadTermController.text =
                                              loadTermMax.toStringAsFixed(0);
                                          loadTermValue[0] = loadTermMax;
                                          setState(() {});
                                        } else {
                                          if (number < loadTermMin) {
                                            loadTermValue[0] = loadTermMin;
                                            inValidTerm = true;
                                            setState(() {});
                                          } else {
                                            loadTermValue[0] = number;
                                            inValidTerm = false;
                                            setState(() {});
                                          }
                                        }
                                        await appPreference.setLoanTerm(
                                            ConvertHelper.formartNumber(
                                                loadTermValue[0]
                                                    .toStringAsFixed(2)));
                                      },
                                    ),
                                    GestureDetector(
                                      onTap: () => loadTermNode.requestFocus(),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10, top: 10, bottom: 10),
                                          child: Text(
                                            'year',
                                            style: theme.textTheme
                                                .styleTextFields(),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                if (inValidTerm)
                                  const SizedBox(height: Dimens.size4),
                                if (inValidTerm)
                                  Text("Invalid number",
                                      style: theme.primaryTextTheme.error())
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: Dimens.size30),
                      ButtonNext(
                        text: 'Next: Your income details',
                        onTap: () => onChangeTab(1, true),
                      ),
                      const Spacer(),
                      const FooterWidget()
                    ],
                  ),
                ),
                ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: Dimens.size40),
                  children: [
                    const SizedBox(height: Dimens.size20),
                    Text("Who is this loan for?",
                        style: theme.textTheme.bodyText1),
                    const SizedBox(height: Dimens.size10),
                    Row(
                      children: [
                        Expanded(
                          child: SelectButton(
                            status: justMe,
                            text: 'Just me',
                            onTap: () => changeLoanType('1'),
                          ),
                        ),
                        const SizedBox(width: Dimens.size1),
                        Expanded(
                            child: SelectButton(
                          status: twoUs,
                          text: 'Two of us',
                          onTap: () => changeLoanType('2'),
                        )),
                      ],
                    ),
                    const SizedBox(height: Dimens.size20),
                    Text("How much do you earn after tax?",
                        style: theme.textTheme.bodyText1),
                    const SizedBox(height: Dimens.size10),
                    Row(
                      children: [
                        Expanded(
                          child: SelectButton(
                            status: earnWeekly,
                            text: 'Weekly',
                            onTap: () async => onChangeType('earn_tax_week'),
                          ),
                        ),
                        const SizedBox(width: Dimens.size1),
                        Expanded(
                            child: SelectButton(
                          status: earnFortnightly,
                          text: 'Fortnightly',
                          onTap: () async => onChangeType('earn_tax_fortnight'),
                        )),
                        const SizedBox(width: Dimens.size1),
                        Expanded(
                            child: SelectButton(
                          status: earnMonthly,
                          text: 'Monthly',
                          onTap: () async => onChangeType('earn_tax_month'),
                        ))
                      ],
                    ),
                    const SizedBox(height: Dimens.size10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 5,
                            child: SliderCustom(
                              values: earnTaxValue,
                              max: earnTaxMax,
                              min: earnTaxMin,
                              step: const FlutterSliderStep(step: 0.1),
                              onDragging:
                                  (handlerIndex, lowerValue, upperValue) {
                                onProgress(lowerValue, 'earn_tax');
                              },
                            )),
                        const SizedBox(width: Dimens.size4),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  TextFieldCustom(
                                    focusNode: earnTaxNode,
                                    controller: earnTaxController,
                                    suffixIcon: '%',
                                    textAlign: TextAlign.center,
                                    padding: const EdgeInsets.only(
                                        left: 24, top: 10, bottom: 10),
                                    onChanged: (value) async {
                                      final number = double.tryParse(
                                              earnTaxController.text
                                                  .replaceAll(',', '')) ??
                                          0;
                                      if (number > earnTaxMax) {
                                        inValidEarnTax = true;
                                        earnTaxController.text =
                                            formatter.format(earnTaxMax);
                                        earnTaxValue[0] = earnTaxMax;
                                        setState(() {});
                                      } else {
                                        if (number < earnTaxMin) {
                                          earnTaxValue[0] = earnTaxMin;
                                          inValidEarnTax = true;
                                          setState(() {});
                                        } else {
                                          earnTaxValue[0] = number;
                                          inValidEarnTax = false;
                                          setState(() {});
                                        }
                                      }
                                      await appPreference.setEarnTax(
                                          ConvertHelper.formartNumber(
                                              earnTaxValue[0]
                                                  .toStringAsFixed(0)));
                                    },
                                  ),
                                  GestureDetector(
                                    onTap: () => earnTaxNode.requestFocus(),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10, bottom: 10),
                                        child: Text(
                                          '\u0024',
                                          style:
                                              theme.textTheme.styleTextFields(),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              if (inValidEarnTax)
                                const SizedBox(height: Dimens.size4),
                              if (inValidEarnTax)
                                Text("Invalid number",
                                    style: theme.primaryTextTheme.error())
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimens.size20),
                    if (twoUs)
                      Text("How much does other applicant earn after tax?",
                          style: theme.textTheme.bodyText1),
                    if (twoUs) const SizedBox(height: Dimens.size10),
                    if (twoUs)
                      Row(
                        children: [
                          Expanded(
                            child: SelectButton(
                              status: nextWeekly,
                              text: 'Weekly',
                              onTap: () async => onChangeType('next_tax_week'),
                            ),
                          ),
                          const SizedBox(width: Dimens.size1),
                          Expanded(
                              child: SelectButton(
                            status: nextFortnightly,
                            text: 'Fortnightly',
                            onTap: () async =>
                                onChangeType('next_tax_fortnight'),
                          )),
                          const SizedBox(width: Dimens.size1),
                          Expanded(
                              child: SelectButton(
                            status: nextMonthly,
                            text: 'Monthly',
                            onTap: () async => onChangeType('next_tax_month'),
                          ))
                        ],
                      ),
                    if (twoUs) const SizedBox(height: Dimens.size10),
                    if (twoUs)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              flex: 5,
                              child: SliderCustom(
                                values: nextTaxValue,
                                max: nextTaxMax,
                                min: nextTaxMin,
                                step: const FlutterSliderStep(step: 0.1),
                                onDragging:
                                    (handlerIndex, lowerValue, upperValue) {
                                  onProgress(lowerValue, 'next_tax');
                                },
                              )),
                          const SizedBox(width: Dimens.size4),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    TextFieldCustom(
                                      focusNode: nextTaxNode,
                                      controller: nextTaxController,
                                      suffixIcon: '%',
                                      textAlign: TextAlign.center,
                                      padding: const EdgeInsets.only(
                                          left: 24, top: 10, bottom: 10),
                                      onChanged: (value) async {
                                        final number = double.tryParse(
                                                nextTaxController.text
                                                    .replaceAll(',', '')) ??
                                            0;
                                        if (number > nextTaxMax) {
                                          inValidNextTax = true;
                                          nextTaxController.text =
                                              formatter.format(nextTaxMax);
                                          nextTaxValue[0] = nextTaxMax;
                                          setState(() {});
                                        } else {
                                          if (number < nextTaxMin) {
                                            nextTaxValue[0] = nextTaxMin;
                                            inValidNextTax = true;
                                            setState(() {});
                                          } else {
                                            nextTaxValue[0] = number;
                                            inValidNextTax = false;
                                            setState(() {});
                                          }
                                        }
                                        await appPreference.setNextTax(
                                            ConvertHelper.formartNumber(
                                                nextTaxValue[0]
                                                    .toStringAsFixed(0)));
                                      },
                                    ),
                                    GestureDetector(
                                      onTap: () => nextTaxNode.requestFocus(),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 10, bottom: 10),
                                          child: Text(
                                            '\u0024',
                                            style: theme.textTheme
                                                .styleTextFields(),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                if (inValidNextTax)
                                  const SizedBox(height: Dimens.size4),
                                if (inValidNextTax)
                                  Text("Invalid number",
                                      style: theme.primaryTextTheme.error())
                              ],
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: Dimens.size20),
                    Text("Do you have any other sources of income?",
                        style: theme.textTheme.bodyText1),
                    const SizedBox(height: Dimens.size10),
                    Row(
                      children: [
                        Expanded(
                          child: SelectButton(
                            status: incomeWeekly,
                            text: 'Weekly',
                            onTap: () async => onChangeType('income_week'),
                          ),
                        ),
                        const SizedBox(width: Dimens.size1),
                        Expanded(
                            child: SelectButton(
                          status: incomeFortnightly,
                          text: 'Fortnightly',
                          onTap: () async => onChangeType('income_fortnight'),
                        )),
                        const SizedBox(width: Dimens.size1),
                        Expanded(
                            child: SelectButton(
                          status: incomeMonthly,
                          text: 'Monthly',
                          onTap: () async => onChangeType('income_month'),
                        ))
                      ],
                    ),
                    const SizedBox(height: Dimens.size10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 5,
                            child: SliderCustom(
                              values: incomeValue,
                              max: incomeMax,
                              min: incomeMin,
                              step: const FlutterSliderStep(step: 0.1),
                              onDragging:
                                  (handlerIndex, lowerValue, upperValue) {
                                onProgress(lowerValue, 'income');
                              },
                            )),
                        const SizedBox(width: Dimens.size4),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  TextFieldCustom(
                                    focusNode: incomeNode,
                                    controller: incomeController,
                                    suffixIcon: '%',
                                    textAlign: TextAlign.center,
                                    padding: const EdgeInsets.only(
                                        left: 24, top: 10, bottom: 10),
                                    onChanged: (value) async {
                                      final number = double.tryParse(
                                              incomeController.text
                                                  .replaceAll(',', '')) ??
                                          0;
                                      if (number > incomeMax) {
                                        inValidIncome = true;
                                        incomeController.text =
                                            formatter.format(incomeMax);
                                        incomeValue[0] = incomeMax;
                                        setState(() {});
                                      } else {
                                        if (number < incomeMin) {
                                          incomeValue[0] = incomeMin;
                                          inValidIncome = true;
                                          setState(() {});
                                        } else {
                                          incomeValue[0] = number;
                                          inValidIncome = false;
                                          setState(() {});
                                        }
                                      }
                                      await appPreference.setIncome(
                                          ConvertHelper.formartNumber(
                                              incomeValue[0]
                                                  .toStringAsFixed(0)));
                                    },
                                  ),
                                  GestureDetector(
                                    onTap: () => incomeNode.requestFocus(),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10, bottom: 10),
                                        child: Text(
                                          '\u0024',
                                          style:
                                              theme.textTheme.styleTextFields(),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              if (inValidIncome)
                                const SizedBox(height: Dimens.size4),
                              if (inValidIncome)
                                Text("Invalid number",
                                    style: theme.primaryTextTheme.error())
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimens.size20),
                    ButtonNext(
                      text: 'Next: Your expense details',
                      onTap: () => onChangeTab(2, true),
                    ),
                    SizedBox(height: height * 0.055),
                    const FooterWidget()
                  ],
                ),
                ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: Dimens.size40),
                  children: [
                    const SizedBox(height: Dimens.size30),
                    Text("How much is your car loan repayment?",
                        style: theme.textTheme.bodyText1),
                    const SizedBox(height: Dimens.size10),
                    Row(
                      children: [
                        Expanded(
                          child: SelectButton(
                            status: carWeekly,
                            text: 'Weekly',
                            onTap: () async => onChangeType('car_week'),
                          ),
                        ),
                        const SizedBox(width: Dimens.size1),
                        Expanded(
                            child: SelectButton(
                          status: carFortnightly,
                          text: 'Fortnightly',
                          onTap: () async => onChangeType('car_fortnight'),
                        )),
                        const SizedBox(width: Dimens.size1),
                        Expanded(
                            child: SelectButton(
                          status: carMonthly,
                          text: 'Monthly',
                          onTap: () async => onChangeType('car_month'),
                        ))
                      ],
                    ),
                    const SizedBox(height: Dimens.size10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 5,
                            child: SliderCustom(
                              values: carLoanValue,
                              max: carLoanMax,
                              min: carLoanMin,
                              step: const FlutterSliderStep(step: 0.1),
                              onDragging:
                                  (handlerIndex, lowerValue, upperValue) {
                                onProgress(lowerValue, 'car_loan');
                              },
                            )),
                        const SizedBox(width: Dimens.size4),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  TextFieldCustom(
                                    focusNode: carLoanNode,
                                    controller: carLoanController,
                                    suffixIcon: '%',
                                    textAlign: TextAlign.center,
                                    padding: const EdgeInsets.only(
                                        left: 24, top: 10, bottom: 10),
                                    onChanged: (value) async {
                                      final number = double.tryParse(
                                              carLoanController.text
                                                  .replaceAll(',', '')) ??
                                          0;
                                      if (number > carLoanMax) {
                                        inValidCarLoan = true;
                                        carLoanController.text =
                                            formatter.format(carLoanMax);
                                        carLoanValue[0] = carLoanMax;
                                        setState(() {});
                                      } else {
                                        if (number < carLoanMin) {
                                          carLoanValue[0] = carLoanMin;
                                          inValidCarLoan = true;
                                          setState(() {});
                                        } else {
                                          carLoanValue[0] = number;
                                          inValidCarLoan = false;
                                          setState(() {});
                                        }
                                      }
                                      await appPreference.setCarLoan(
                                          ConvertHelper.formartNumber(
                                              carLoanValue[0]
                                                  .toStringAsFixed(0)));
                                    },
                                  ),
                                  GestureDetector(
                                    onTap: () => carLoanNode.requestFocus(),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10, bottom: 10),
                                        child: Text(
                                          '\u0024',
                                          style:
                                              theme.textTheme.styleTextFields(),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              if (inValidCarLoan)
                                const SizedBox(height: Dimens.size4),
                              if (inValidCarLoan)
                                Text("Invalid number",
                                    style: theme.primaryTextTheme.error())
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimens.size20),
                    Text("How much is your other loan repayments?",
                        style: theme.textTheme.bodyText1),
                    const SizedBox(height: Dimens.size10),
                    Row(
                      children: [
                        Expanded(
                          child: SelectButton(
                            status: otherWeekly,
                            text: 'Weekly',
                            onTap: () async => onChangeType('other_week'),
                          ),
                        ),
                        const SizedBox(width: Dimens.size1),
                        Expanded(
                            child: SelectButton(
                          status: otherFortnightly,
                          text: 'Fortnightly',
                          onTap: () async => onChangeType('other_fortnight'),
                        )),
                        const SizedBox(width: Dimens.size1),
                        Expanded(
                            child: SelectButton(
                          status: otherMonthly,
                          text: 'Monthly',
                          onTap: () async => onChangeType('other_month'),
                        ))
                      ],
                    ),
                    const SizedBox(height: Dimens.size10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 5,
                            child: SliderCustom(
                              values: otherLoanValue,
                              max: otherLoanMax,
                              min: otherLoanMin,
                              step: const FlutterSliderStep(step: 0.1),
                              onDragging:
                                  (handlerIndex, lowerValue, upperValue) {
                                onProgress(lowerValue, 'other_loan');
                              },
                            )),
                        const SizedBox(width: Dimens.size4),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  TextFieldCustom(
                                    focusNode: otherLoanNode,
                                    controller: otherLoanController,
                                    suffixIcon: '%',
                                    textAlign: TextAlign.center,
                                    padding: const EdgeInsets.only(
                                        left: 24, top: 10, bottom: 10),
                                    onChanged: (value) async {
                                      final number = double.tryParse(
                                              otherLoanController.text
                                                  .replaceAll(',', '')) ??
                                          0;
                                      if (number > otherLoanMax) {
                                        inValidOtherLoan = true;
                                        otherLoanController.text =
                                            formatter.format(otherLoanMax);
                                        otherLoanValue[0] = otherLoanMax;
                                        setState(() {});
                                      } else {
                                        if (number < otherLoanMin) {
                                          otherLoanValue[0] = otherLoanMin;
                                          inValidOtherLoan = true;
                                          setState(() {});
                                        } else {
                                          otherLoanValue[0] = number;
                                          inValidOtherLoan = false;
                                          setState(() {});
                                        }
                                      }
                                      await appPreference.setOtherLoan(
                                          ConvertHelper.formartNumber(
                                              otherLoanValue[0]
                                                  .toStringAsFixed(0)));
                                    },
                                  ),
                                  GestureDetector(
                                    onTap: () => otherLoanNode.requestFocus(),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10, bottom: 10),
                                        child: Text(
                                          '\u0024',
                                          style:
                                              theme.textTheme.styleTextFields(),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              if (inValidOtherLoan)
                                const SizedBox(height: Dimens.size4),
                              if (inValidOtherLoan)
                                Text("Invalid number",
                                    style: theme.primaryTextTheme.error())
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimens.size20),
                    Text("What’s your credit card limit?",
                        style: theme.textTheme.bodyText1),
                    const SizedBox(height: Dimens.size8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 5,
                            child: SliderCustom(
                              values: creditValue,
                              max: creditMax,
                              min: creditMin,
                              step: const FlutterSliderStep(step: 0.1),
                              onDragging:
                                  (handlerIndex, lowerValue, upperValue) {
                                onProgress(lowerValue, 'credit');
                              },
                            )),
                        const SizedBox(width: Dimens.size4),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  TextFieldCustom(
                                    focusNode: creditNode,
                                    controller: creditController,
                                    suffixIcon: '%',
                                    textAlign: TextAlign.center,
                                    padding: const EdgeInsets.only(
                                        left: 24, top: 10, bottom: 10),
                                    onChanged: (value) async {
                                      final number = double.tryParse(
                                              creditController.text
                                                  .replaceAll(',', '')) ??
                                          0;
                                      if (number > creditMax) {
                                        inValidCredit = true;
                                        creditController.text =
                                            formatter.format(creditMax);
                                        creditValue[0] = creditMax;
                                        setState(() {});
                                      } else {
                                        if (number < creditMin) {
                                          creditValue[0] = creditMin;
                                          inValidCredit = true;
                                          setState(() {});
                                        } else {
                                          creditValue[0] = number;
                                          inValidCredit = false;
                                          setState(() {});
                                        }
                                      }
                                      await appPreference.setCredit(
                                          ConvertHelper.formartNumber(
                                              creditValue[0]
                                                  .toStringAsFixed(0)));
                                    },
                                  ),
                                  GestureDetector(
                                    onTap: () => creditNode.requestFocus(),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10, bottom: 10),
                                        child: Text(
                                          '\u0024',
                                          style:
                                              theme.textTheme.styleTextFields(),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              if (inValidCredit)
                                const SizedBox(height: Dimens.size4),
                              if (inValidCredit)
                                Text("Invalid number",
                                    style: theme.primaryTextTheme.error())
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimens.size20),
                    Text("How many dependants do you financially support?",
                        style: theme.textTheme.bodyText1),
                    const SizedBox(height: Dimens.size8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 5,
                            child: SliderCustom(
                              values: dependantValue,
                              max: dependantMax,
                              min: dependantMin,
                              step: const FlutterSliderStep(step: 0.1),
                              onDragging:
                                  (handlerIndex, lowerValue, upperValue) {
                                onProgress(lowerValue, 'dependant');
                              },
                            )),
                        const SizedBox(width: Dimens.size4),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFieldCustom(
                                focusNode: dependantNode,
                                controller: dependantController,
                                suffixIcon: '%',
                                textAlign: TextAlign.center,
                                padding: const EdgeInsets.only(
                                    left: 24, top: 10, bottom: 10),
                                onChanged: (value) async {
                                  final number = double.tryParse(
                                          dependantController.text
                                              .replaceAll(',', '')) ??
                                      0;
                                  if (number > dependantMax) {
                                    inValidDependant = true;
                                    dependantController.text = '5';
                                    dependantValue[0] = dependantMax;
                                    setState(() {});
                                  } else {
                                    if (number < dependantMin) {
                                      dependantValue[0] = dependantMin;
                                      inValidDependant = true;
                                      setState(() {});
                                    } else {
                                      dependantValue[0] = number;
                                      inValidDependant = false;
                                      setState(() {});
                                    }
                                  }
                                },
                              ),
                              if (inValidDependant)
                                const SizedBox(height: Dimens.size4),
                              if (inValidDependant)
                                Text("Invalid number",
                                    style: theme.primaryTextTheme.error())
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimens.size30),
                    ButtonNext.noIcon(
                      text: 'Calculate',
                      onTap: () {
                        openCalculate();
                      },
                    ),
                    SizedBox(height: height * 0.075),
                    const FooterWidget()
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> openCalculate() async {
    bool isSingle = justMe ? true : false;

    int dependants = int.parse(dependantController.text);
    int loanTerm = int.parse(loadTermController.text);
    double interestRate = double.parse(interesetRateController.text);
    int netSalary = int.parse(earnTaxController.text.replaceAll(',', ''));
    int netSalary2 = int.parse(nextTaxController.text.replaceAll(',', ''));
    int netIncome = int.parse(incomeController.text.replaceAll(',', ''));
    int carLoanRepay = int.parse(carLoanController.text.replaceAll(',', ''));
    int creditCardRepay = int.parse(creditController.text.replaceAll(',', ''));
    int otherPay = int.parse(otherLoanController.text.replaceAll(',', ''));
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

    double n = loanTerm * 12;
    double r = interestRate / (100 * 12);
    double _r = 1 + r;
    num _rn = math.pow(_r, n);

    int totalIncome = (netSalary * netSalPeriod) +
        (netSalary2 * netSalPeriod2) +
        (netIncome * netIncomePeriod); // net Income
    double expenditures = (carLoanRepay * carLoanRepayPeriod) +
        (homeRepay * 12) +
        (creditCardRepay * 12 * 0.03) +
        (otherPay * otherPayPeriod) +
        annualExpence; // total expences
    double checkBorrow = (totalIncome / 1.1) - expenditures;

    double loanAmount;
    double monthlyRepay;

    if (checkBorrow < 0) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Not Eligible For Loan',
                  style: Theme.of(context).textTheme.headline5),
              content: Text(
                'You cannot take a loan',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              actions: <Widget>[
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('OK',
                        style: Theme.of(context).textTheme.bodyMedium)),
              ],
            );
          });
      return;
    } else {
      double dispensableMonthlyIncome = checkBorrow / 12;
      loanAmount = dispensableMonthlyIncome / ((r * _rn) / (_rn - 1));
      monthlyRepay = (loanAmount * (r * (_rn / (_rn - 1))));
    }

    double monthlyIncomeInt = totalIncome / 12;

    double otherRep = ((carLoanRepay * carLoanRepayPeriod) / 12.0) +
        ((otherPay * otherPayPeriod) / 12) +
        (creditCardRepay * 0.03);

    double remainings = monthlyIncomeInt - (monthlyIncomeInt / 1.1);
    if (remainings < 0) {
      remainings = 0;
    }

    double totalMonthlyExpense = (annualExpence / 12) + otherRep;
    double livingExpreses = annualExpence / 12;
    double mortgageRepayment = (monthlyIncomeInt / 1.1) - totalMonthlyExpense;
    navigator.pushNamed(
      RouteKey.yourBorrowingPower,
      arguments: {
        "canBorrow": loanAmount,
        "livingExpreses": livingExpreses,
        "monthlyIncome": monthlyIncomeInt,
        "otherRepayment": otherRep,
        "mortgageRepayment": mortgageRepayment,
        "remaining": remainings,
      },
    );
  }
}
