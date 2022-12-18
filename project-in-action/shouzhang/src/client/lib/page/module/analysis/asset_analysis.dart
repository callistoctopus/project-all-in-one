/*
 * @Author: gui-qi
 * @Date: 2022-11-17 08:06:58
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-12-01 10:30:58
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:at_gauges/at_gauges.dart';
import 'package:client/data/service/consume_analysis_service.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Grade extends StatelessWidget {
  int i = 0;
  double p = 0.0;

  Future<double> persent() async {
    double p = 0.0;
    Future<double> t = ConsumeAnalysisService().getTodayTotalCunsume();

    await t.then((value) {
      p = (value / value).toDouble();
    });
    return p;
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: const [
     Expanded(
          flex: 1,
          child: ScaleRadialGauge(
            maxValue: 100,
            actualValue: 90,
            // Optional Parameters
            minValue: 0,
            size: 400,
            title: Text('资产指数'),
            titlePosition: TitlePosition.top,
            pointerColor: Colors.blue,
            needleColor: Colors.blue,
            decimalPlaces: 0,
            isAnimate: true,
            animationDuration: 2000,
            unit: TextSpan(text: '分', style: TextStyle(fontSize: 10)),
          )),
      Expanded(
          flex: 1,
          child: ScaleRadialGauge(
            maxValue: 100,
            actualValue: 65,
            // Optional Parameters
            minValue: 0,
            size: 400,
            title: Text('消费指数'),
            titlePosition: TitlePosition.top,
            pointerColor: Colors.blue,
            needleColor: Colors.blue,
            decimalPlaces: 0,
            isAnimate: true,
            animationDuration: 2000,
            unit: TextSpan(text: '分', style: TextStyle(fontSize: 10)),
          )),
      Expanded(
          flex: 1,
          child: ScaleRadialGauge(
            maxValue: 100,
            actualValue: 85,
            // Optional Parameters
            minValue: 0,
            size: 400,
            title: Text('风险指数'),
            titlePosition: TitlePosition.top,
            pointerColor: Colors.blue,
            needleColor: Colors.blue,
            decimalPlaces: 0,
            isAnimate: true,
            animationDuration: 1500,
            unit: TextSpan(text: '分', style: TextStyle(fontSize: 10)),
          )),
    ]);
  }
}
