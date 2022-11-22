/*
 * @Author: gui-qi
 * @Date: 2022-11-21 05:28:46
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-22 01:48:22
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/page/component/common_component.dart';
import 'package:flutter/material.dart';

class Assets extends StatefulWidget {
  const Assets({super.key});

  @override
  State<StatefulWidget> createState() => _AssetsState();
}

class _AssetsState extends State<Assets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: ListView(children: <Widget>[
          COMMON_COMPONENT.chart("资产状态", "盘账", () {}, const SizedBox(),
              height: 120),
          const Divider(
            color: Colors.grey,
            thickness: 0,
            height: 1,
          ),
        ])));
  }
}
