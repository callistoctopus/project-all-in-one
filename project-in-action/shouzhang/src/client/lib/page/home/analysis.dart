/*
 * @Author: gui-qi
 * @Date: 2022-10-29 01:37:32
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-21 10:19:48
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/page/analysis/grade.dart';
import 'package:client/page/component/common_component.dart';
import 'package:client/service/server_data_access_service.dart';
import 'package:client/units/common_utils.dart';
import 'package:flutter/material.dart';

class AnalysisPage extends StatefulWidget {
  const AnalysisPage({super.key});

  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(CommonUtils.now().toString().substring(0, 10)),
                _COMPONENT.verticalDivider(),
                const Text(
                  "资产:",
                  style: TextStyle(color: Colors.grey),
                ),
                const Text("良好"),
                _COMPONENT.verticalDivider(),
                const Text("消费:", style: TextStyle(color: Colors.grey)),
                const Text("良好"),
                _COMPONENT.verticalDivider(),
                const Text("风险:", style: TextStyle(color: Colors.grey)),
                const Text("低"),
              ],
            ),
            const Divider(
              color: Colors.grey,
              thickness: 0,
              height: 1,
            ),
            COMMON_COMPONENT.chart("评分", "", () {}, Grade(),
                height: 115),
            const Divider(
              color: Colors.grey,
              thickness: 0,
              height: 1,
            ),
            COMMON_COMPONENT.chart("消息", "更多", () {}, const SizedBox(),
                height: 80),
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
    );
  }
}

class _COMPONENT {
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
}
