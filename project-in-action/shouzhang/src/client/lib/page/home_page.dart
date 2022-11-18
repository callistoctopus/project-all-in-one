/*
 * @Author: gui-qi
 * @Date: 2022-10-29 01:37:32
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-18 09:36:02
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/component/custom_float_button.dart';
import 'package:client/config/route.dart';
import 'package:client/develop/FadeTransition.dart';
import 'package:client/page/analysis/Week.dart';
import 'package:client/page/analysis/month.dart';
import 'package:client/page/analysis/today.dart';
import 'package:client/page/bill_list_page.dart';
import 'package:client/page/setting_page.dart';
import 'package:client/service/server_data_access_service.dart';
import 'package:client/units/common_const.dart';
import 'package:client/units/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool selected = false;
  @override
  void initState() {
    super.initState();
    DataAccessService.syncData();
  }

  @override
  Widget build(BuildContext context) {
    Map<dynamic, Function> para = {
      ICONS.ADD: () {
        context.go(ROUTE.ADD_BILL);
      },
    };

    return PageWithFloatButton(
      funcIcon: para,
      defaultForward: false,
      child: Center(
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(CommonUtils.now().toString().substring(0, 10)),
                const Text("杭州"),
                const Text("晴"),
                const Text("21℃"),
                const Text("状态：良好"),
                _COMPONENT.verticalDivider(),
                GestureDetector(onTap:(){context.go(ROUTE.SETTING);}, child: const Icon(Iconsax.more_square)),
              ],
            ),
            const Divider(
              color: Colors.grey,
              thickness: 0,
              indent: 20,
              endIndent: 20,
              height: 1,
            ),
            _COMPONENT.chart("今日指标", "", () {}, TodayAnalysis()),
            const Divider(
              color: Colors.grey,
              thickness: 0,
              indent: 20,
              endIndent: 20,
              height: 1,
            ),
            _COMPONENT.chart("本周消费", "", () {}, const WeekAnalysis()),
            const Divider(
              color: Colors.grey,
              thickness: 0,
              indent: 20,
              endIndent: 20,
              height: 1,
            ),
            _COMPONENT.chart("${CommonUtils.now().month}月度消费趋势", "", () {},
                const MonthAnalysis()),
            const Divider(
              color: Colors.grey,
              thickness: 0,
              indent: 20,
              endIndent: 20,
              height: 1,
            ),
            _COMPONENT.chart(
                "消费明细",
                "详细",
                () => context.go(ROUTE.BILLS),
                BillListPage(
                  shortMode: true,
                )),
            const Divider(
              color: Colors.grey,
              thickness: 0,
              indent: 20,
              endIndent: 20,
              height: 1,
            ),
            _COMPONENT.chart("参考评分", "", () {}, const SizedBox()),
            const Divider(
              color: Colors.grey,
              thickness: 0,
              indent: 20,
              endIndent: 20,
              height: 1,
            ),
            _COMPONENT.chart("预算储备", "管理", () {context.go(ROUTE.BUDGET);}, const SizedBox()),
            const Divider(
              color: Colors.grey,
              thickness: 0,
              indent: 20,
              endIndent: 20,
              height: 1,
            ),
            _COMPONENT.chart("资产状态", "盘账", () {}, const SizedBox()),
            const Divider(
              color: Colors.grey,
              thickness: 0,
              indent: 20,
              endIndent: 20,
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
            //   '消费/预算 原因，消费种类（类型）',
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
            // Text(
            //   '自动扣费',
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
            // Text(
            //   '消息提示',
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
            // Text(
            //   '设置背景图',
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
          ],
        ),
      ),
    );
  }
}

class _COMPONENT {
  static Widget menu(BuildContext context, String title, Function onEvent) {
    return Expanded(
            child: GestureDetector(
        onTap: () {
          onEvent();
        },
        child: SizedBox(
                height: 30,
                child:
                    Center(child: Text(title, textAlign: TextAlign.center)))));
  }

  static Widget verticalDivider() {
    return const SizedBox(
        height: 25,
        child: VerticalDivider(
          color: Colors.grey,
          thickness: 1,
          width: 1,
          indent: 2,
          endIndent: 2,
        ));
  }

  static Widget chart(
      String title, String link, Function callback, Widget child) {
    return SizedBox(
        height: 150,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20, top: 3, right: 20),
              height: 20,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 12),
                    ),
                    GestureDetector(
                        onTap: () => callback(),
                        child: Text(link,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.blueAccent)))
                  ])),
          SizedBox(height: 130, child: child)
        ]));
  }
}
