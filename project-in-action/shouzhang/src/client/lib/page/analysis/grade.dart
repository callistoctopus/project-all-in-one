/*
 * @Author: gui-qi
 * @Date: 2022-11-17 08:06:58
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-21 09:30:15
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/service/analysis_service.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
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
          child: SfRadialGauge(axes: <RadialAxis>[
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
                          Colors.white, // blue
                          Colors.green, // green
                        ],
                        stops: <double>[0.0, 1.0],
                      )),
                ],
                pointers: const <GaugePointer>[
                  NeedlePointer(
                    needleColor: Colors.black,
                    needleEndWidth: 2,
                    value: 90,
                    knobStyle: KnobStyle(color: Colors.black),
                  )
                ],
                annotations: const <GaugeAnnotation>[
                  GaugeAnnotation(
                      widget: Text('优良',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold)),
                      angle: 90,
                      positionFactor: 0.5)
                ])
          ])),
      Expanded(
          flex: 1,
          child: SfRadialGauge(axes: <RadialAxis>[
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
                          Colors.white, // blue
                          Colors.green, // green
                        ],
                        stops: <double>[0.0, 1.0],
                      )),
                ],
                pointers: const <GaugePointer>[
                  NeedlePointer(
                    needleColor: Colors.black,
                    needleEndWidth: 2,
                    value: 90,
                    knobStyle: KnobStyle(color: Colors.black),
                  )
                ],
                annotations: const <GaugeAnnotation>[
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
          child: SfRadialGauge(axes: <RadialAxis>[
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
                          Colors.white, // blue
                          Colors.red, // green
                        ],
                        stops: <double>[0.0, 1.0],
                      )),
                ],
                pointers: const <GaugePointer>[
                  NeedlePointer(
                    needleColor: Colors.black,
                    needleEndWidth: 2,
                    value: 20,
                    knobStyle: KnobStyle(color: Colors.black),
                  )
                ],
                annotations: const <GaugeAnnotation>[
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
