/*
 * @Author: gui-qi
 * @Date: 2022-11-17 08:06:58
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-26 15:09:17
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// void main() {
//   return runApp(_ChartApp());
// }

// class ChartApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: _MyHomePage(),
//     );
//   }
// }

class ChartApp extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  ChartApp({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ChartApp> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    data = [
      _ChartData('买菜', 12),
      _ChartData('衣服', 15),
      _ChartData('交通', 30),
      _ChartData('餐饮', 6.4),
      _ChartData('日常', 14)
    ];
    data.sort((a,b)=>a.y > b.y ? 1 : 0);
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(minimum: 0, maximum: 40, interval: 10),
            tooltipBehavior: _tooltip,
            series: <ChartSeries<_ChartData, String>>[
              BarSeries<_ChartData, String>(
                  dataSource: data,
                  xValueMapper: (_ChartData data, _) => data.x,
                  yValueMapper: (_ChartData data, _) => data.y,
                  name: 'Gold',
                  color: Color.fromRGBO(8, 142, 255, 1))
            ]));
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}