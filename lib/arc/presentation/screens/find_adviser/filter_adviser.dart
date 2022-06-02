import 'package:flutter/material.dart';
import 'package:mortgage_exp/src/constants.dart';
import 'package:mortgage_exp/src/extensions/extension.dart';
import 'package:mortgage_exp/src/styles/dimens.dart';

import '../../../../src/helper/filter_conver.dart';
import '../../widgets/widget.dart';

class FilterAdviserScreen extends StatefulWidget {
  final int selectedValue;
  const FilterAdviserScreen({
    Key? key,
    required this.selectedValue,
  }) : super(key: key);

  @override
  State<FilterAdviserScreen> createState() => _FilterAdviserScreenState();
}

class _FilterAdviserScreenState extends State<FilterAdviserScreen> {
  final List<int> itemCategory = Constants.categoryIDS;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: theme.primaryColor,
      appBar: CustomAppBar.withLeading(title: "State/Territory"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          // Container(
          //   height: 40,
          //   padding: const EdgeInsets.symmetric(horizontal: Dimens.size10),
          //   margin: EdgeInsets.symmetric(horizontal: size.width / 7),
          //   decoration: const BoxDecoration(color: Colors.white),
          //   child: Align(
          //     alignment: Alignment.centerLeft,
          //     child: Text("Select State/Territory",
          //         style: theme.textTheme
          //             .s16w700black()
          //             .copyWith(fontWeight: FontWeight.w700)),
          //   ),
          // ),
          Flexible(
              child: ListView.builder(
                  itemCount: itemCategory.length,
                  itemBuilder: (context, index) => ItemSelected(
                      text: FilterConverter.filterConvert(itemCategory[index]),
                      id: itemCategory[index],
                      isSelected: itemCategory[index] == widget.selectedValue,
                      isSepared: index % 2 == 0)))
        ],
      ),
    );
  }
}

class ItemSelected extends StatelessWidget {
  final int id;
  final String text;
  final bool isSelected;
  final bool isSepared;
  const ItemSelected({
    Key? key,
    required this.id,
    required this.text,
    required this.isSepared,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(id.toString()),
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: Dimens.size10),
        margin: EdgeInsets.symmetric(horizontal: size.width / 7),
        color: isSepared ? Colors.grey[300] : Colors.white,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 20,
              child: Text(text,
                  style: theme.textTheme
                      .s16w700black()
                      .copyWith(fontWeight: FontWeight.w700)),
            ),
            const Spacer(),
            if (isSelected)
              Image.asset(
                ImageAssetPath.icCheck,
                color: theme.backgroundColor,
                height: 20,
              ),
          ],
        ),
      ),
    );
  }
}
