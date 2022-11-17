/*
 * @Author: gui-qi
 * @Date: 2022-11-17 08:06:58
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-17 12:40:14
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/service/analysis_service.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TodayAnalysis extends StatelessWidget {
  int i = 0;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: CircularPercentIndicator(
        radius: 50.0,
        lineWidth: 13.0,
        animation: true,
        percent: 0.9,
        center: const Text("100%"),
        progressColor: Colors.green,
        footer: const Text(
          "今日消费指标",
          style: TextStyle(fontWeight: FontWeight.w100, fontSize: 14.0),
        ),
        circularStrokeCap: CircularStrokeCap.round,
      )),
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
