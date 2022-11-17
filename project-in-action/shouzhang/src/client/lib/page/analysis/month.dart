/*
 * @Author: gui-qi
 * @Date: 2022-11-17 08:06:58
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-17 13:58:59
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MonthAnalysis extends StatelessWidget {
  const MonthAnalysis({super.key});

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = '1';
        break;
      // case 1:
      //   text = '';
      //   break;
      // case 2:
      //   text = '';
      //   break;
      // case 3:
      //   text = '';
      //   break;
      // case 4:
      //   text = '';
      //   break;
      // case 5:
      //   text = '';
      //   break;
      case 6:
        text = '7';
        break;
      // case 7:
      //   text = '8';
      //   break;
      // case 8:
      //   text = '9';
      //   break;
      // case 9:
      //   text = '10';
      //   break;
      // case 10:
      //   text = '11';
      //   break;
      // case 11:
      //   text = '12';
      //   break;
      // case 12:
      //   text = '12';
      //   break;
      case 13:
        text = '14';
        break;
      // case 14:
      //   text = '14';
      //   break;
      // case 15:
      //   text = '15';
      //   break;
      // case 16:
      //   text = '16';
      //   break;
      // case 17:
      //   text = '17';
      //   break;
      // case 18:
      //   text = '18';
      //   break;
      // case 19:
      //   text = '19';
      //   break;
      case 20:
        text = '21';
        break;
      // case 21:
      //   text = '21';
      //   break;
      // case 22:
      //   text = '22';
      //   break;
      // case 23:
      //   text = '23';
      //   break;
      // case 24:
      //   text = '24';
      //   break;
      // case 25:
      //   text = '25';
      //   break;
      // case 26:
      //   text = '26';
      //   break;
      case 27:
        text = '28';
        break;
      // case 28:
      //   text = '28';
      //   break;
      // case 29:
      //   text = '29';
      //   break;
      // case 30:
      //   text = '31';
      //   break;
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
    const style = TextStyle(color: Colors.green, fontSize: 12);
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text('${value.toInt()}', style: style),
    );
  }

  static const _dateTextStyle = TextStyle(
    fontSize: 10,
    color: Colors.black,
    fontWeight: FontWeight.normal,
  );

  @override
  Widget build(BuildContext context) {
    const cutOffYValue = 5.0;

    return AspectRatio(
      aspectRatio: 2.4,
      child: Padding(
        padding: const EdgeInsets.only(left: 2, right: 5, top: 15),
        child: LineChart(
          LineChartData(
            borderData: FlBorderData(
              show: false,
            ),
            gridData: FlGridData(show: false),
            lineTouchData: LineTouchData(enabled: false),
            lineBarsData: [
              LineChartBarData(
                spots: const [
                  FlSpot(0, 4),
                  FlSpot(1, 3.5),
                  FlSpot(2, 4.5),
                  FlSpot(3, 1),
                  FlSpot(4, 4),
                  FlSpot(5, 6),
                  FlSpot(6, 6.5),
                  FlSpot(7, 6),
                  FlSpot(8, 4),
                  FlSpot(9, 6),
                  FlSpot(10, 6),
                  FlSpot(11, 7),
                  FlSpot(12, 4),
                  FlSpot(13, 3.5),
                  FlSpot(14, 4.5),
                  FlSpot(15, 1),
                  FlSpot(16, 4),
                  FlSpot(17, 6),
                  FlSpot(18, 6.5),
                  FlSpot(19, 6),
                  FlSpot(20, 4),
                  FlSpot(21, 6),
                  FlSpot(22, 6),
                  FlSpot(23, 7),
                  FlSpot(24, 4),
                  FlSpot(25, 3.5),
                  FlSpot(26, 4.5),
                  FlSpot(27, 1),
                  FlSpot(28, 4),
                  FlSpot(29, 6),
                  FlSpot(30, 6.5),
                ],
                isCurved: true,
                barWidth: 2,
                color: Colors.blueAccent,
                belowBarData: BarAreaData(
                  show: true,
                  color: Colors.redAccent.withOpacity(0.4),
                  cutOffY: cutOffYValue,
                  applyCutOffY: true,
                ),
                aboveBarData: BarAreaData(
                  show: true,
                  color: Colors.greenAccent.withOpacity(0.6),
                  cutOffY: cutOffYValue,
                  applyCutOffY: true,
                ),
                dotData: FlDotData(
                  show: false,
                ),
              ),
            ],
            minY: 0,
            titlesData: FlTitlesData(
              show: true,
              topTitles: AxisTitles(axisNameWidget: const Text(
                  '2022/11',
                  style: _dateTextStyle,
                ),
                sideTitles: SideTitles(
                  showTitles: false,
                  reservedSize: 18,
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
                  reservedSize: 18,
                  interval: 1,
                  getTitlesWidget: bottomTitleWidgets,
                ),
              ),
              leftTitles: AxisTitles(
                axisNameSize: 20,
                // axisNameWidget: const Padding(
                //   padding: EdgeInsets.only(bottom: 8),
                //   child: Text('Value'),
                // ),
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  reservedSize: 40,
                  getTitlesWidget: leftTitleWidgets,
                ),
              ),
            ),
            // gridData: FlGridData(
            //   show: true,
            //   drawVerticalLine: false,
            //   horizontalInterval: 1,
            //   checkToShowHorizontalLine: (double value) {
            //     return value == 1 || value == 6 || value == 4 || value == 5;
            //   },
            // ),
          ),
        ),
      ),
    );
  }
}
