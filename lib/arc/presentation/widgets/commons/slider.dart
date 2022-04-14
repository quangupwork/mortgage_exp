import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

import '../../../../../src/styles/style.dart';

class SliderCustom extends StatelessWidget {
  final List<double> values;
  final Function(int, dynamic, dynamic)? onDragging;
  final FlutterSliderStep step;
  final double max;
  final double min;
  const SliderCustom({
    Key? key,
    required this.values,
    required this.onDragging,
    required this.step,
    required this.min,
    required this.max,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterSlider(
      handlerHeight: 20,
      values: values,
      max: max,
      min: min,
      step: step,
      tooltip: FlutterSliderTooltip(disabled: true),
      jump: true,
      selectByTap: true,
      onDragging: onDragging,
      trackBar: const FlutterSliderTrackBar(
          activeTrackBarHeight: 2,
          activeTrackBar: BoxDecoration(color: Color(0xff8b745d))),
      handler: FlutterSliderHandler(
        decoration: const BoxDecoration(),
        child: Container(
          height: Dimens.size20,
          width: Dimens.size20,
          decoration: BoxDecoration(
              color: const Color(0xff8b745d),
              borderRadius: BorderRadius.circular(Dimens.size25)),
          padding: const EdgeInsets.all(Dimens.size2),
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimens.size25))),
        ),
      ),
    );
  }
}
