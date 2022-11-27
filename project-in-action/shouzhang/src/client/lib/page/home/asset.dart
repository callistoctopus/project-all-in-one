/*
 * @Author: gui-qi
 * @Date: 2022-11-21 05:28:46
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-27 06:35:44
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
      CustomChart(title: "资产状态", height: 120, child: const SizedBox()),
      const Divider(
        color: Colors.grey,
        thickness: 0,
        height: 1,
      ),
      CustomChartDynamic(
          title: "资产一览",
          link: "追加",
          callback: () {},
          child: Column(
              children: List.generate(5, (index) => _COMPONMENT.assetCart()))),
    ])));
  }
}

class _COMPONMENT {
  static assetCart() {
    return Card(
      color: Colors.grey,
      child: Container(
          height: 70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text(
                    "支付宝",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text("qi"),
                  Text("更新时间")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    "余额",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
