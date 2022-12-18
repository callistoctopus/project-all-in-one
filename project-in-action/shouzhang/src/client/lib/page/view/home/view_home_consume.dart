/*
 * @Author: gui-qi
 * @Date: 2022-10-29 01:37:32
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-12-12 06:40:52
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/page/component/custom_chart.dart';
import 'package:client/page/config/route.dart';
import 'package:client/page/module/analysis/consume_analysis_by_reason.dart';
import 'package:client/page/module/analysis/consume_analysis_week.dart';
import 'package:client/page/module/analysis/consume_analysis_today.dart';
import 'package:client/units/common_const.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ViewConsume extends StatefulWidget {
  const ViewConsume({super.key});

  @override
  State<ViewConsume> createState() => _ViewConsumeState();
}

class _ViewConsumeState extends State<ViewConsume> {
  bool selected = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "消费概览",
          style: TextStyle(color: Color(0xFF000000)),
        ),
        actions: [
          TextButton(
            child: const Text(
              "明细",
              style: TextStyle(color: Color(0xFF000000)),
            ),
            onPressed: () => context.go(ROUTE.BILLS),
          ),
        ],
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            CustomChart(
                title: "",
                height: 170,
                callback: () => context.go(ROUTE.BILLS),
                child: TodayAnalysis()),
            const Divider(
              color: Color(0xFFC4CBCF),
              thickness: 0,
              height: 1,
              indent: 10,
              endIndent: 10,
            ),
            CustomChart(title: "", height: 210, child: const WeekAnalysis()),
            const Divider(
              color: Color(0xFFC4CBCF),
              thickness: 0,
              height: 1,
              indent: 10,
              endIndent: 10,
            ),
            // CustomChart(
            //     title: "${CommonUtils.now().month}月度消费趋势",
            //     child: MonthAnalysis()),
            // const Divider(
            //   color: Colors.grey,
            //   thickness: 0,
            //   height: 1,
            // ),
            CustomChart(title: "", height: 190, child: const PieChartSample2()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Colors.white,
        child: Text(
          ICONS.ADD,
          style: const TextStyle(color: Colors.black),
        ),
        onPressed: () {
          context.go(ROUTE.ADD_BILL);
        },
      ),
    );
  }
}
