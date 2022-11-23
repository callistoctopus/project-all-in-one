/*
 * @Author: gui-qi
 * @Date: 2022-10-29 01:37:32
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-23 10:57:03
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/page/component/custom_chart.dart';
import 'package:client/config/route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({super.key});

  @override
  State<StatefulWidget> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ListView(children: <Widget>[
      CustomChart(
          title: "预算储备",
          link: "管理",
          callback: () {
            context.go(ROUTE.BUDGET);
          },
          child: const SizedBox()),
      const Divider(
        color: Colors.grey,
        thickness: 0,
        height: 1,
      ),
    ])));
  }
}
