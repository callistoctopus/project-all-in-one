/*
 * @Author: gui-qi
 * @Date: 2022-11-12 15:41:16
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-14 06:04:59
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/develop/AnimatedListPage.dart';
import 'package:client/develop/absorb_pointer_page.dart';
import 'package:client/develop/dismissible_page.dart';
import 'package:client/develop/fl_chart.dart';
import 'package:client/develop/ink_well_page.dart';
import 'package:client/develop/wrap_page.dart';
import 'package:flutter/material.dart';

class DevSamplePage extends StatelessWidget {
  const DevSamplePage({super.key});

  @override
  Widget build(Object context) {
    return PageView(
      controller: PageController(initialPage: 1),
      children: const [
        WarpPage(),
        InkWellPage(),
        DismissiblePage(),
        AbsorbPointerPage(),
        AnimatedListSample(),
        MyApp()
      ],
    );
  }
}
