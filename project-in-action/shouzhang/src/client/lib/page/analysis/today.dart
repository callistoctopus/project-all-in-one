/*
 * @Author: gui-qi
 * @Date: 2022-11-17 08:06:58
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-20 14:15:37
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/service/analysis_service.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TodayAnalysis extends StatelessWidget {
  int i = 0;
  double p = 0.0;

  Future<double> persent() async {
    double p = 0.0;
    Future<double> t = AnalysisService().getTodayTotalPay();

    await t.then((value) {
      p = (value / value).toDouble();
      if (p == null) p = 0.0;
    });
    return p;
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: FutureBuilder(
              future: persent(),
              builder: (context, value) {
                if (value.hasData) {
                  p = value.data!;
                }
                return CircularPercentIndicator(
                  radius: 45.0,
                  lineWidth: 13.0,
                  animation: true,
                  percent: p,
                  center: Text("${p * 100}%"),
                  progressColor: Colors.green,
                  circularStrokeCap: CircularStrokeCap.round,
                );
              })),
      Expanded(
          flex: 1,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            FutureBuilder(
                future: AnalysisService().getTodayTotalPay(),
                builder: (context, value) {
                  if (value.hasData) {
                    return Text("今日消费: ${value.data}");
                  }
                  return const Text("无数据");
                }),
            FutureBuilder(
                future: AnalysisService().getTodayTotalPay(),
                builder: (context, value) {
                  if (value.hasData) {
                    return Text("今日预算: ${value.data}");
                  }
                  return const Text("无数据");
                }),
          ]))
    ]);
  }
}
