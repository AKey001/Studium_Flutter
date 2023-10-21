import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class BarChartWidget extends StatelessWidget {
  final Color color;
  final Color secondColor;
  final Color borderColor;
  final double? barWidth;
  final List<Tuple2<int, int>> data;

  const BarChartWidget({
    super.key,
    required this.color,
    required this.secondColor,
    required this.borderColor,
    required this.data,
    this.barWidth = 25,
  });

  @override
  Widget build(BuildContext context) {
    List<BarChartGroupData> groupData = [];
    data.forEachIndexed((index, element) {
      groupData.add(buildGroupData(index + 1, element.item1, element.item2));
    });

    return Container(
      padding: const EdgeInsets.only(right: 25, bottom: 20, top: 12, left: 12),
      child: AspectRatio(
        aspectRatio: 12 / 9,
        child: BarChart(
          BarChartData(
            barTouchData: barTouchData,
            titlesData: titlesData,
            borderData: borderData,
            barGroups: groupData,
            gridData: gridData,
            alignment: BarChartAlignment.spaceAround,
            maxY: data.map((e) => e.item1 + e.item2).max.toDouble() + 5,
          ),
        ),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: const EdgeInsets.only(bottom: 3),
          tooltipMargin: 0,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round() == 0 ? "" : rod.toY.round().toString(),
              const TextStyle(
                // color: AppColors.contentColorCyan,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getBottomTitles(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 1:
        text = '1';
        break;
      case 2:
        text = '2';
        break;
      case 3:
        text = '3';
        break;
      case 4:
        text = '4';
        break;
      case 5:
        text = '5';
        break;
      default:
        text = 'X';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text),
    );
  }

  Widget getLeftTitles(double value, TitleMeta meta) {
    if (value % 5 == 0) {
      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text(value.toInt().toString()),
      );
    }
    return Container();
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          axisNameSize: 25,
          axisNameWidget: const Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text('Note'),
          ),
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getBottomTitles,
          ),
        ),
        leftTitles: AxisTitles(
          axisNameSize: 25,
          axisNameWidget: const Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text('Anzahl'),
          ),
          sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: getLeftTitles),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          left: BorderSide(color: borderColor),
          top: const BorderSide(color: Colors.transparent),
          bottom: BorderSide(color: borderColor),
          right: const BorderSide(color: Colors.transparent),
        ),
      );

  FlGridData get gridData => FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 5,
        verticalInterval: 5,
      );

  BarChartGroupData buildGroupData(
      int index, int firstSection, int secondSection) {
    return BarChartGroupData(
      x: index,
      groupVertically: true,
      barRods: [
        BarChartRodData(
          toY: firstSection.toDouble(),
          color: color,
          width: barWidth,
          borderRadius: secondSection != 0
              ? BorderRadius.zero
              : const BorderRadius.vertical(
                  bottom: Radius.zero, top: Radius.circular(50)),
        ),
        BarChartRodData(
          fromY: firstSection.toDouble(),
          toY: firstSection.toDouble() + secondSection.toDouble(),
          color: secondColor,
          width: barWidth,
          borderRadius: const BorderRadius.vertical(
              bottom: Radius.zero, top: Radius.circular(50)),
        )
      ],
      showingTooltipIndicators: [1],
    );
  }
}
