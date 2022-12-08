/*
 * @Author: gui-qi
 * @Date: 2022-10-29 01:37:32
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-12-08 23:06:25
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/page/component/custom_chart.dart';
import 'package:client/page/config/route.dart';
import 'package:client/page/module/analysis/consume_analysis_by_consumer.dart';
import 'package:client/page/module/analysis/consume_analysis_by_reason.dart';
import 'package:client/page/module/analysis/consume_analysis_week.dart';
import 'package:client/page/module/analysis/consume_analysis_month.dart';
import 'package:client/page/module/analysis/consume_analysis_today.dart';
import 'package:client/page/view/show/bill_list_page.dart';
import 'package:client/data/service/http_service.dart';
import 'package:client/units/common_const.dart';
import 'package:client/units/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConsumePage extends StatefulWidget {
  const ConsumePage({super.key});

  @override
  State<ConsumePage> createState() => _ConsumePageState();
}

class _ConsumePageState extends State<ConsumePage> {
  bool selected = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            CustomChart(title: "", height: 170, child: TodayAnalysis()),
            // const Divider(
            //   color: Colors.grey,
            //   thickness: 0,
            //   height: 1,
            // ),
            // CustomChart(
            //     title: "消费明细",
            //     link: "明细",
            //     callback: () => context.go(ROUTE.BILLS),
            //     height: 90,
            //     child: const BillListPage(
            //       shortMode: true,
            //     )),
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
            CustomChart(title: "", child: const PieChartSample2()),
            const Divider(
              color: Color(0xFFC4CBCF),
              thickness: 0,
              height: 1,
              indent: 10,
              endIndent: 10,
            ),
            CustomChart(title: "", child: ChartApp()),
            // const Divider(
            //   color: Color(0xFFC4CBCF),
            //   thickness: 0,
            //   height: 1,
            //   indent: 10,
            //   endIndent: 10,
            // ),
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
