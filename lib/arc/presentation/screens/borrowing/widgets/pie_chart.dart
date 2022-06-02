import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mortgage_exp/src/extensions/extension.dart';
import 'package:mortgage_exp/src/styles/dimens.dart';

class ChartWidget extends StatefulWidget {
  final double monthlyIncome;
  final double otherRepayment;
  final double livingExpreses;
  final double remaining;
  final double mortgageRepayment;
  const ChartWidget({
    Key? key,
    required this.monthlyIncome,
    required this.otherRepayment,
    required this.livingExpreses,
    required this.remaining,
    required this.mortgageRepayment,
  }) : super(key: key);

  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 200,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xffd8d7d5))),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimens.size10, vertical: 10),
          child: Row(
            children: [
              Text("Based on", style: theme.textTheme.s16w700()),
              const Spacer(),
              Text("Monthly income", style: theme.textTheme.s16w800()),
              const SizedBox(width: Dimens.size10),
              Text("\$${widget.monthlyIncome.toInt()}",
                  style: theme.textTheme.s16w800()),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: PieChart(
                  PieChartData(
                      pieTouchData: PieTouchData(touchCallback:
                          (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                        });
                      }),
                      borderData: FlBorderData(show: false),
                      sectionsSpace: 2,
                      centerSpaceRadius: 0,
                      sections: showingSections()),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Indicator(
                      color: const Color(0xff0370bc),
                      text: "Mortgage repayment ",
                      value: '\$${widget.mortgageRepayment.toInt()}',
                      isSquare: true,
                    ),
                    const SizedBox(height: 4),
                    Indicator(
                      color: const Color(0xff2e3292),
                      text: 'Other repayments',
                      value: '\$${widget.otherRepayment.toInt()}',
                      isSquare: true,
                    ),
                    const SizedBox(height: 4),
                    Indicator(
                      color: const Color(0xff29abe2),
                      text: 'Living expenses',
                      value: '\$${widget.livingExpreses.toInt()}',
                      isSquare: true,
                    ),
                    const SizedBox(height: 4),
                    Indicator(
                      color: const Color(0xfffcad17),
                      text: 'Remaining',
                      value: '\$${widget.remaining.toInt()}',
                      isSquare: true,
                    ),
                    const SizedBox(height: 18),
                  ],
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }

  List<PieChartSectionData> showingSections() {
    final otherRepayment =
        (widget.monthlyIncome / widget.otherRepayment).toDouble();
    final mortgageRepayment =
        (widget.monthlyIncome / widget.mortgageRepayment).toDouble();
    final livingExpreses =
        (widget.monthlyIncome / widget.livingExpreses).toDouble();
    final remaining = (widget.monthlyIncome / widget.remaining).toDouble();
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0370bc),
            value: mortgageRepayment.isInfinite ? 0 : mortgageRepayment,
            title: '',
            radius: radius,
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xff2e3292),
            value: otherRepayment.isInfinite ? 0 : otherRepayment,
            title: '',
            radius: radius,
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff29abe2),
            value: livingExpreses.isInfinite ? 0 : livingExpreses,
            title: '',
            radius: radius,
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xfffcad17),
            value: remaining.isInfinite ? 0 : remaining,
            title: '',
            radius: radius,
          );
        default:
          throw Error();
      }
    });
  }
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final String value;
  final bool isSquare;
  final double size;
  final Color textColor;

  const Indicator({
    Key? key,
    required this.color,
    required this.text,
    required this.value,
    required this.isSquare,
    this.size = 6,
    this.textColor = const Color(0xff505050),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
                shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
                color: color)),
        const SizedBox(width: 4),
        Expanded(
          flex: 6,
          child: Text(text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.s16w800()),
        ),
        Expanded(
          flex: 3,
          child: Text(value, maxLines: 2, style: theme.textTheme.s16w800()),
        )
      ],
    );
  }
}

extension ColorExtension on Color {
  /// Convert the color to a darken color based on the [percent]
  Color darken([int percent = 40]) {
    assert(1 <= percent && percent <= 100);
    final value = 1 - percent / 100;
    return Color.fromARGB(alpha, (red * value).round(), (green * value).round(),
        (blue * value).round());
  }
}
