import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:mortgage_exp/arc/presentation/widgets/commons/common.dart';
import 'package:mortgage_exp/src/config/my_theme.dart';
import 'package:mortgage_exp/src/config/route_keys.dart';

import '../../../../injector.dart';
import '../../../../src/constants.dart';
import '../../../../src/styles/style.dart';
import '../../../../src/utilities/navigator_service.dart';
import 'widgets/item_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final navigator = AppDependencies.injector.get<NavigationService>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.size40),
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: Dimens.size20),
          Center(
            child: Image.asset(ImageAssetPath.icLogo,
                height: Dimens.size200, width: Dimens.size200),
          ),
          ItemMenu(
            icon: ImageAssetPath.icBorrowing,
            title: "Borrowing Power",
            subTitle: "Know how much you can borrow",
            onTap: () {},
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
            icon: ImageAssetPath.icBorrowing,
            title: "Borrowing Power",
            subTitle: "Know how much you can borrow",
            onTap: () {},
          ),
          SizedBox(height: size.height / 14),
          ItemMenu(
            icon: ImageAssetPath.icAbout,
            title: "About Us",
            subTitle: "Supporting finance advice providers",
            onTap: () {},
          ),
          const SizedBox(height: Dimens.size12),
          ItemMenu(
            icon: ImageAssetPath.icFindAdviser,
            title: "Find an Adviser",
            subTitle: "Finance, Mortgage and Insurance advice",
            onTap: () {},
          ),
          SizedBox(height: size.height / 12),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onTap: () {},
                  text: 'Call Now',
                  icon: ImageAssetPath.icCall,
                ),
              ),
              const SizedBox(width: Dimens.size4),
              Expanded(
                child: CustomButton(
                  onTap: () {},
                  text: 'Email Now',
                  icon: ImageAssetPath.icEmail,
                ),
              ),
            ],
          ),
          SizedBox(height: size.height / 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Disclaimer", style: theme.textTheme.subtitle2),
              Text("Privacy", style: theme.textTheme.subtitle2),
              Text("Disclosure", style: theme.textTheme.subtitle2),
            ],
          ),
          const SizedBox(height: Dimens.size14),
          Text("www.mortgage-express.co.nz",
              textAlign: TextAlign.center, style: theme.textTheme.subtitle2),
          const SizedBox(height: Dimens.size10),
        ],
      ),
    );
  }
}
