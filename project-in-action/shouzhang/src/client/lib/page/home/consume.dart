/*
 * @Author: gui-qi
 * @Date: 2022-10-29 01:37:32
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-22 15:03:08
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/page/component/common_component.dart';
import 'package:client/config/route.dart';
import 'package:client/page/views/analysis/Week.dart';
import 'package:client/page/views/analysis/month.dart';
import 'package:client/page/views/analysis/today.dart';
import 'package:client/page/data_show/bill_list_page.dart';
import 'package:client/service/server_data_access_service.dart';
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
    DataAccessService.syncData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            CustomChart(title: "今日指标", height: 115, child: TodayAnalysis()),
            const Divider(
              color: Colors.grey,
              thickness: 0,
              height: 1,
            ),
            CustomChart(
                title: "消费明细",
                link: "明细",
                callback: () => context.go(ROUTE.BILLS),
                height: 90,
                child: BillListPage(
                  shortMode: true,
                )),
            const Divider(
              color: Colors.grey,
              thickness: 0,
              height: 1,
            ),
            CustomChart(title: "本周消费", child: const WeekAnalysis()),
            const Divider(
              color: Colors.grey,
              thickness: 0,
              height: 1,
            ),
            CustomChart(
                title: "${CommonUtils.now().month}月度消费趋势",
                child: const MonthAnalysis()),
            const Divider(
              color: Colors.grey,
              thickness: 0,
              height: 1,
            ),
            // Text(
            //   '日别，月别，周别，年别，消费分析，建议，警告',
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
            // Text(
            //   '日别，月别，周别，年别，预算分析，建议，警告',
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
            // Text(
            //   '资产管理，盘账',
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
            // Text(
            //   '消费目标，预计达成时间',
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
            // Text(
            //   '预算，年度，',
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
            // Text(
            //   '自动扣费',
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
            // Text(
            //   '设置背景图',
            //   style: Theme.of(context).textTheme.headlineMedium,
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
        onPressed: () => context.go(ROUTE.ADD_BILL),
      ),
    );
  }
}
