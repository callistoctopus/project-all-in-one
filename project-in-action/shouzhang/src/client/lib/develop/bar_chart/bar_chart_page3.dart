/*
 * @Author: gui-qi
 * @Date: 2022-11-14 05:48:52
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-14 06:00:54
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */

import 'package:client/develop/bar_chart/samples/bar_chart_sample3.dart';
import 'package:client/develop/bar_chart/samples/bar_chart_sample4.dart';
import 'package:client/develop/bar_chart/samples/bar_chart_sample5.dart';
import 'package:client/develop/bar_chart/samples/bar_chart_sample6.dart';
import 'package:client/develop/bar_chart/samples/bar_chart_sample7.dart';
import 'package:flutter/material.dart';

class BarChartPage3 extends StatelessWidget {
  const BarChartPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: const <Widget>[
          BarChartSample7(),
          SizedBox(
            height: 18,
          ),
          BarChartSample3(),
          SizedBox(
            height: 18,
          ),
          BarChartSample5(),
          SizedBox(
            height: 18,
          ),
          BarChartSample6(),
          SizedBox(
            height: 18,
          ),
          BarChartSample4(),
        ],
      ),
    );
  }
}
