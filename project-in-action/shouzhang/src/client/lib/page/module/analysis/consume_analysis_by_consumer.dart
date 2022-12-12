/*
 * @Author: gui-qi
 * @Date: 2022-11-17 08:06:58
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-12-12 07:03:28
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartApp extends StatefulWidget {
  const ChartApp({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ChartApp> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    data = [
      _ChartData('奇', 12),
      _ChartData('宝', 19),
    ];
    data.sort((a,b)=>a.y > b.y ? 1 : 0);
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SfCartesianChart(
          plotAreaBorderColor:Colors.red,
          plotAreaBorderWidth:0,
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(minimum: 0, maximum: 40, interval: 10),
            tooltipBehavior: _tooltip,
            series: <ChartSeries<_ChartData, String>>[
              BarSeries<_ChartData, String>(
                // trackBorderWidth:0,
                borderWidth:0,
                  dataSource: data,
                  width: 0.2,
                  xValueMapper: (_ChartData data, _) => data.x,
                  yValueMapper: (_ChartData data, _) => data.y,
                  dataLabelMapper:(_ChartData data, _) => data.y.toString(),
                  name: '消费',
                  color: const Color.fromRGBO(8, 142, 255, 1))
            ]));
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}