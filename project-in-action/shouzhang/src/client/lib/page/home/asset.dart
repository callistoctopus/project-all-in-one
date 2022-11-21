/*
 * @Author: gui-qi
 * @Date: 2022-11-21 05:28:46
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-21 05:34:48
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/config/route.dart';
import 'package:client/page/component/common_component.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Assets extends StatefulWidget {
  const Assets({super.key});

  @override
  State<StatefulWidget> createState() => _AssetsState();
}

class _AssetsState extends State<Assets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ListView(children: <Widget>[
      COMMON_COMPONENT.chart("资产状态", "盘账", () {}, const SizedBox()),
      const Divider(
        color: Colors.grey,
        thickness: 0,
        indent: 20,
        endIndent: 20,
        height: 1,
      ),
      COMMON_COMPONENT.chart("预算储备", "管理", () {
        context.go(ROUTE.BUDGET);
      }, const SizedBox()),
      const Divider(
        color: Colors.grey,
        thickness: 0,
        indent: 20,
        endIndent: 20,
        height: 1,
      ),
    ])));
  }
}
