/*
 * @Author: gui-qi
 * @Date: 2022-11-14 05:48:52
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-14 05:49:47
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/develop/radar_chart/samples/radar_chart_sample1.dart';
import 'package:flutter/material.dart';

class RadarChartPage extends StatelessWidget {
  const RadarChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xff231f49),
      child: ListView(
        children: const [
          RadarChartSample1(),
        ],
      ),
    );
  }
}
