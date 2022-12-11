/*
 * @Author: gui-qi
 * @Date: 2022-11-17 08:06:58
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-12-11 18:52:28
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/data/service/consume_analysis_service.dart';
import 'package:client/units/common_utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class WeekAnalysis extends StatefulWidget {
  const WeekAnalysis({super.key});

  @override
  State<StatefulWidget> createState() => WeekAnalysisState();
}

class WeekAnalysisState extends State<WeekAnalysis> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: AspectRatio(
            aspectRatio: 2,
            child: FutureBuilder(
              future: ConsumeAnalysisService().getCurrentMonthEveryDayCunsume(),
              builder: (context, snapData) {
                if (snapData.hasData) {
                  return _BarChart(values: snapData.data!);
                }
                return const Text("无数据");
              },
            )));
  }
}

class _BarChart extends StatelessWidget {
  _BarChart({required this.values});

  final List<double> values;

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: values.reduce((v, e) => math.max(v, e)) * 1.2,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 2,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString() == "0"
                  ? ""
                  : rod.toY.round().toString(),
              const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.normal,
                  fontSize: 10),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xFFCCCCCC),
      fontWeight: FontWeight.normal,
      fontSize: 9,
    );

    const style1 = TextStyle(
      color: Color(0xFF000000),
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text((value.toInt() + 1).toString(),
          style: value.toInt() + 1 != CommonUtils.now().day ? style : style1),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => const LinearGradient(
        colors: [
          Color(0xFF0f59a4),
          Color(0xFF0f59a4),
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> get barGroups => List.generate(
      31,
      (index) => BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: values[index],
                gradient: _barsGradient,
              )
            ],
            showingTooltipIndicators: [0],
          ));
  // [
  //       BarChartGroupData(
  //         x: 0,
  //         barRods: [
  //           BarChartRodData(
  //             toY: values[0],
  //             gradient: _barsGradient,
  //           )
  //         ],
  //         showingTooltipIndicators: [0],
  //       ),
  //       BarChartGroupData(
  //         x: 1,
  //         barRods: [
  //           BarChartRodData(
  //             toY: values[1],
  //             gradient: _barsGradient,
  //           )
  //         ],
  //         showingTooltipIndicators: [0],
  //       ),
  //       BarChartGroupData(
  //         x: 2,
  //         barRods: [
  //           BarChartRodData(
  //             toY: values[2],
  //             gradient: _barsGradient,
  //           )
  //         ],
  //         showingTooltipIndicators: [0],
  //       ),
  //       BarChartGroupData(
  //         x: 3,
  //         barRods: [
  //           BarChartRodData(
  //             toY: values[3],
  //             gradient: _barsGradient,
  //           )
  //         ],
  //         showingTooltipIndicators: [0],
  //       ),
  //       BarChartGroupData(
  //         x: 4,
  //         barRods: [
  //           BarChartRodData(
  //             toY: values[4],
  //             gradient: _barsGradient,
  //           )
  //         ],
  //         showingTooltipIndicators: [0],
  //       ),
  //       BarChartGroupData(
  //         x: 5,
  //         barRods: [
  //           BarChartRodData(
  //             toY: values[5],
  //             gradient: _barsGradient,
  //           )
  //         ],
  //         showingTooltipIndicators: [0],
  //       ),
  //       BarChartGroupData(
  //         x: 6,
  //         barRods: [
  //           BarChartRodData(
  //             toY: values[6],
  //             gradient: _barsGradient,
  //           )
  //         ],
  //         showingTooltipIndicators: [0],
  //       ),
  //     ];
}
