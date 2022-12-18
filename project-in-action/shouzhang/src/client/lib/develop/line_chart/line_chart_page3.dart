/*
 * @Author: gui-qi
 * @Date: 2022-11-14 05:48:52
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-14 05:56:21
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/develop/line_chart/samples/line_chart_sample6.dart';
import 'package:client/develop/line_chart/samples/line_chart_sample9.dart';
import 'package:flutter/material.dart';

class LineChartPage3 extends StatelessWidget {
  const LineChartPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Center(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
          children: <Widget>[
            const Text(
              'LineChart (reversed)',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 52,
            ),
            LineChartSample6(),
            const SizedBox(
              height: 52,
            ),
            const Text(
              'LineChart (positive and negative values)',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 52,
            ),
            LineChartSample9(),
          ],
        ),
      ),
    );
  }
}
