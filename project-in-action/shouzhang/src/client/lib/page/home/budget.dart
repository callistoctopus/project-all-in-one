/*
 * @Author: gui-qi
 * @Date: 2022-10-29 01:37:32
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-22 05:40:01
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/page/component/common_component.dart';
import 'package:client/config/route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Budget extends StatefulWidget {
  const Budget({super.key});

  @override
  State<StatefulWidget> createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.white,
        body: Center(
            child: ListView(children: <Widget>[
          COMMON_COMPONENT.chart("预算储备", "管理", () {
            context.go(ROUTE.BUDGET);
          }, const SizedBox()),
          const Divider(
            color: Colors.grey,
            thickness: 0,
            height: 1,
          ),
        ])));
  }
}
