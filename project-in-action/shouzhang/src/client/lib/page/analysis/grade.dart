/*
 * @Author: gui-qi
 * @Date: 2022-11-17 08:06:58
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-22 02:50:36
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/service/analysis_service.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Grade extends StatelessWidget {
  int i = 0;
  double p = 0.0;

  Future<double> persent() async {
    double p = 0.0;
    Future<double> t = AnalysisService().getTodayTotalPay();

    await t.then((value) {
      p = (value / value).toDouble();
    });
    return p;
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Expanded(
          flex: 1,
          child: SfRadialGauge(
            title: const GaugeTitle(text: "资产指数",textStyle: TextStyle(fontSize: 10)),
            axes: <RadialAxis>[
            RadialAxis(
                showLabels: true,
                showTicks: true,
                interval: 10,
                // minorTicksPerInterval:1,
                labelOffset: 5,
                minimum: 0,
                maximum: 100,
                axisLabelStyle:
                    const GaugeTextStyle(color: Colors.black, fontSize: 6),
                majorTickStyle: const MajorTickStyle(
                    length: 2,
                    thickness: 1,
                    lengthUnit: GaugeSizeUnit.logicalPixel),
                minorTickStyle: const MinorTickStyle(length: 1, thickness: 1),
                ranges: <GaugeRange>[
                  GaugeRange(
                    // startWidth: 7,
                    // endWidth: 7,
                      startValue: 0,
                      endValue: 100,
                      color: Colors.red,
                      gradient: const SweepGradient(
                        center: FractionalOffset.center,
                        colors: <Color>[
                          Colors.white,
                        ],
                        stops: <double>[1.0],
                      )),
                ],
                pointers: const <GaugePointer>[
                  RangePointer(
                    width: 7,
                      enableAnimation: true,
                      cornerStyle: CornerStyle.bothCurve,
                      value: 95,
                      color: Colors.green,
                      gradient: SweepGradient(
                        center: FractionalOffset.center,
                        colors: <Color>[Colors.greenAccent, Colors.green],
                        stops: <double>[0.0, 1.0],
                      ))
                ],
                annotations: const <GaugeAnnotation>[
                  GaugeAnnotation(
                      widget: Text('95',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold)),
                      angle: 90,
                      positionFactor: 0),
                  GaugeAnnotation(
                      widget: Text('良好',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold)),
                      angle: 90,
                      positionFactor: 0.5)
                ])
          ])),
      Expanded(
          flex: 1,
          child: SfRadialGauge(
            title: const GaugeTitle(text: "消费指数",textStyle: TextStyle(fontSize: 10)),
            axes: <RadialAxis>[
            RadialAxis(
                showLabels: true,
                showTicks: true,
                interval: 10,
                // minorTicksPerInterval:1,
                labelOffset: 5,
                minimum: 0,
                maximum: 100,
                axisLabelStyle:
                    const GaugeTextStyle(color: Colors.black, fontSize: 6),
                majorTickStyle: const MajorTickStyle(
                    length: 2,
                    thickness: 1,
                    lengthUnit: GaugeSizeUnit.logicalPixel),
                minorTickStyle: const MinorTickStyle(length: 1, thickness: 1),
                ranges: <GaugeRange>[
                  GaugeRange(
                      startValue: 0,
                      endValue: 100,
                      color: Colors.red,
                      gradient: const SweepGradient(
                        center: FractionalOffset.center,
                        colors: <Color>[
                          Colors.white,
                        ],
                        stops: <double>[1.0],
                      )),
                ],
                pointers: const <GaugePointer>[
                  RangePointer(
                    width: 7,
                      enableAnimation: true,
                      cornerStyle: CornerStyle.bothCurve,
                      value: 95,
                      color: Colors.green,
                      gradient: SweepGradient(
                        center: FractionalOffset.center,
                        colors: <Color>[Colors.greenAccent, Colors.green],
                        stops: <double>[0.0, 1.0],
                      ))
                ],
                annotations: const <GaugeAnnotation>[
                  GaugeAnnotation(
                      widget: Text('95',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold)),
                      angle: 90,
                      positionFactor: 0),
                  GaugeAnnotation(
                      widget: Text('良好',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold)),
                      angle: 90,
                      positionFactor: 0.5)
                ])
          ])),
      Expanded(
          flex: 1,
          child: SfRadialGauge(
            title: const GaugeTitle(text: "风险指数",textStyle: TextStyle(fontSize: 10)),
            axes: <RadialAxis>[
            RadialAxis(
                showLabels: true,
                showTicks: true,
                interval: 10,
                // minorTicksPerInterval:1,
                labelOffset: 5,
                minimum: 0,
                maximum: 100,
                axisLabelStyle:
                    const GaugeTextStyle(color: Colors.black, fontSize: 6),
                majorTickStyle: const MajorTickStyle(
                    length: 2,
                    thickness: 1,
                    lengthUnit: GaugeSizeUnit.logicalPixel),
                minorTickStyle: const MinorTickStyle(length: 1, thickness: 1),
                ranges: <GaugeRange>[
                  GaugeRange(
                      startValue: 0,
                      endValue: 100,
                      color: Colors.red,
                      gradient: const SweepGradient(
                        center: FractionalOffset.center,
                        colors: <Color>[
                          Colors.white,
                        ],
                        stops: <double>[1.0],
                      )),
                ],
                pointers: const <GaugePointer>[
                  RangePointer(
                    width: 7,
                      enableAnimation: true,
                      cornerStyle: CornerStyle.bothCurve,
                      value: 23,
                      color: Colors.green,
                      gradient: SweepGradient(
                        center: FractionalOffset.center,
                        colors: <Color>[Colors.redAccent, Colors.red],
                        stops: <double>[0.0, 1.0],
                      ))
                ],
                annotations: const <GaugeAnnotation>[
                  GaugeAnnotation(
                      widget: Text('23',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold)),
                      angle: 90,
                      positionFactor: 0),
                  GaugeAnnotation(
                      widget: Text('低',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold)),
                      angle: 90,
                      positionFactor: 0.5)
                ])
          ])),
    ]);
  }
}
