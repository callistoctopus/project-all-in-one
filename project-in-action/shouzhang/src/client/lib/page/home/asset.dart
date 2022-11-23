/*
 * @Author: gui-qi
 * @Date: 2022-11-21 05:28:46
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-23 10:56:44
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/page/component/custom_chart.dart';
import 'package:flutter/material.dart';

class AssetsPage extends StatefulWidget {
  const AssetsPage({super.key});

  @override
  State<StatefulWidget> createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ListView(children: <Widget>[
      CustomChart(
          title: "资产状态",
          link: "盘账",
          callback: () {},
          height: 120,
          child: const SizedBox()),
      const Divider(
        color: Colors.grey,
        thickness: 0,
        height: 1,
      ),
    ])));
  }
}
