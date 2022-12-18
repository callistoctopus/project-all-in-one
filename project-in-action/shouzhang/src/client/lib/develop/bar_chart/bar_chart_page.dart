/*
 * @Author: gui-qi
 * @Date: 2022-11-14 05:48:52
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-14 06:00:18
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */

import 'package:client/develop/bar_chart/samples/bar_chart_sample1.dart';
import 'package:flutter/material.dart';

class BarChartPage extends StatelessWidget {
  const BarChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Color(0xff232040),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(28),
          child: BarChartSample1(),
        ),
      ),
    );
  }
}
