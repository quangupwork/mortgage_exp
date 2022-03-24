import 'package:flutter/material.dart';
import 'package:mortgage_exp/src/styles/colors.dart';
import 'package:mortgage_exp/src/styles/dimens.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final ShapeBorder shapeBorder;
  const ShimmerWidget.rectangular({
    Key? key,
    this.width = double.infinity,
    this.height = Dimens.size10,
    this.shapeBorder = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(Dimens.size10),
      ),
    ),
  }) : super(key: key);

  const ShimmerWidget.cirular(
      {Key? key,
      @required this.width,
      @required this.height,
      this.shapeBorder = const CircleBorder()})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: MyColors.gray1,
      highlightColor: MyColors.gray2,
      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(
          color: Colors.grey[400],
          shape: shapeBorder,
        ),
      ),
    );
  }
}
