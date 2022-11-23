/*
 * @Author: gui-qi
 * @Date: 2022-11-21 05:28:46
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-22 15:00:20
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
