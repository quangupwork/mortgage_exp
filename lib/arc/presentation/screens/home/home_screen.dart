import 'package:flutter/material.dart';
import 'package:mortgage_exp/arc/presentation/screens/home/widgets/button_widget.dart';
import 'package:mortgage_exp/arc/presentation/widgets/commons/footer_widget.dart';
import 'package:mortgage_exp/src/config/route_keys.dart';

import '../../../../injector.dart';
import '../../../../src/constants.dart';
import '../../../../src/styles/style.dart';
import '../../../../src/utilities/navigator_service.dart';
import '../../widgets/commons/dialog.dart';
import 'widgets/item_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 350 ? true : false;

    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: isSmall ? Dimens.size20 : Dimens.size40,
              ),
              children: [
                const SizedBox(height: Dimens.size20),
                Container(
                  padding: const EdgeInsets.only(right: 4),
                  child: Center(
                    child: Image.asset(
                      ImageAssetPath.icLogo,
                      height: size.height * 0.2,
                      width: size.width / 2.5,
                    ),
                  ),
                ),
                ItemMenu(
                  icon: ImageAssetPath.icBorrowing,
                  title: "Borrowing Power",
                  subTitle: "Know how much you can borrow",
                  onTap: () => navigator.pushNamed(RouteKey.borrowingPower),
                ),
                const SizedBox(height: Dimens.size12),
                ItemMenu(
                  icon: ImageAssetPath.icRepayment,
                  title: "Repayments",
                  subTitle: "Know your repayments",
                  onTap: () => navigator.pushNamed(RouteKey.repayment),
                ),
                const SizedBox(height: Dimens.size12),
                ItemMenu(
                  icon: ImageAssetPath.icExtraRepayment,
                  title: "Extra Repayments",
                  subTitle: "Know how much you will save",
                  onTap: () => navigator.pushNamed(RouteKey.extraRepayment),
                ),
                SizedBox(height: size.height / 14),
                ItemMenu(
                  icon: ImageAssetPath.icAbout,
                  title: "About Us",
                  subTitle: "Supporting financial advice providers",
                  onTap: () => navigator.pushNamed(RouteKey.about),
                ),
                const SizedBox(height: Dimens.size12),
                ItemMenu(
                  icon: ImageAssetPath.icFindAdviser,
                  title: "Find an adviser",
                  subTitle: "Financial, Mortgage and Insurance advice",
                  onTap: () => navigator.pushNamed(RouteKey.findAnAdvicer),
                ),
                SizedBox(height: size.height / 12),
                const ButtonWidget(),
                SizedBox(height: size.height / 18),
              ],
            ),
          ),
          const FooterWidget.withURL(hasPadding: true)
        ],
      ),
    );
  }
}
