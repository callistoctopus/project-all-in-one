/*
 * @Author: gui-qi
 * @Date: 2022-11-17 08:06:58
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-12-01 01:05:21
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/data/service/consume_analysis_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MonthAnalysis extends StatelessWidget {
  MonthAnalysis({super.key});

  final Future<List<double>> monthConsume =
      ConsumeAnalysisService().getCurrentMonthEveryDayCunsume();

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = '1日';
        break;
      case 6:
        text = '7日';
        break;
      case 13:
        text = '14日';
        break;
      case 20:
        text = '21日';
        break;
      case 27:
        text = '28日';
        break;
      default:
        return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: _dateTextStyle),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.black87, fontSize: 12);
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text('${value.toInt()}', style: style),
    );
  }

  static const _dateTextStyle = TextStyle(
    fontSize: 10,
    color: Colors.black87,
    fontWeight: FontWeight.normal,
  );

  @override
  Widget build(BuildContext context) {
    return Center(
        child: AspectRatio(
      aspectRatio: 2.6,
      child: Padding(
        padding: const EdgeInsets.only(left: 5, top: 8, bottom: 6),
        child: FutureBuilder(
            future: monthConsume,
            builder: (context, snapData) {
              if (snapData.hasData) {
                double interval = 0.0;
                snapData.data!.forEach((element) {
                  if (element > interval) interval = element;
                });
                interval = interval > 0 ? interval / 5 : 10;
                return LineChart(LineChartData(
                  borderData: FlBorderData(
                    show: false,
                  ),
                  gridData: FlGridData(show: false),
                  lineTouchData: LineTouchData(enabled: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, snapData.data![0]),
                        FlSpot(1, snapData.data![1]),
                        FlSpot(2, snapData.data![2]),
                        FlSpot(3, snapData.data![3]),
                        FlSpot(4, snapData.data![4]),
                        FlSpot(5, snapData.data![5]),
                        FlSpot(6, snapData.data![6]),
                        FlSpot(7, snapData.data![7]),
                        FlSpot(8, snapData.data![8]),
                        FlSpot(9, snapData.data![9]),
                        FlSpot(10, snapData.data![10]),
                        FlSpot(11, snapData.data![11]),
                        FlSpot(12, snapData.data![12]),
                        FlSpot(13, snapData.data![13]),
                        FlSpot(14, snapData.data![14]),
                        FlSpot(15, snapData.data![15]),
                        FlSpot(16, snapData.data![16]),
                        FlSpot(17, snapData.data![17]),
                        FlSpot(18, snapData.data![18]),
                        FlSpot(19, snapData.data![19]),
                        FlSpot(20, snapData.data![20]),
                        FlSpot(21, snapData.data![21]),
                        FlSpot(22, snapData.data![22]),
                        FlSpot(23, snapData.data![23]),
                        FlSpot(24, snapData.data![24]),
                        FlSpot(25, snapData.data![25]),
                        FlSpot(26, snapData.data![26]),
                        FlSpot(27, snapData.data![27]),
                        FlSpot(28, snapData.data![28]),
                        FlSpot(29, snapData.data![29]),
                        FlSpot(30, snapData.data![30]),
                      ],
                      isCurved: true,
                      curveSmoothness: 0.4,
                      preventCurveOverShooting: true,
                      preventCurveOvershootingThreshold: 0.3,
                      barWidth: 2,
                      color: Colors.blueAccent,
                      dotData: FlDotData(
                        show: false,
                      ),
                    ),
                  ],
                  minY: 0,
                  titlesData: FlTitlesData(
                    show: true,
                    topTitles: AxisTitles(
                      axisNameSize: 20,
                      sideTitles: SideTitles(
                        showTitles: false,
                        reservedSize: 30,
                        interval: 1,
                        getTitlesWidget: bottomTitleWidgets,
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 15,
                        interval: 1,
                        getTitlesWidget: bottomTitleWidgets,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      axisNameSize: 10,
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: interval,
                        reservedSize: 40,
                        getTitlesWidget: leftTitleWidgets,
                      ),
                    ),
                  ),
                ));
              } else {
                return const Text("无数据");
              }
            }),
      ),
    ));
  }
}
