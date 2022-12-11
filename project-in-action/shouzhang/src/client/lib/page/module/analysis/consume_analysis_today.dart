/*
 * @Author: gui-qi
 * @Date: 2022-11-17 08:06:58
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-12-11 18:55:54
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/data/dao/budget_dao.dart';
import 'package:client/data/service/consume_analysis_service.dart';
import 'package:client/units/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TodayAnalysis extends StatelessWidget {
  TodayAnalysis({super.key});

  final Future<double> todayConsume =
      ConsumeAnalysisService().getTodayTotalCunsume();
  final Future<double> todayBudget = BudgetDao.getTodayBudget();

  Future<double> persent() async {
    double c = 0.0;
    double d = 0.0;

    await todayConsume.then((value) {
      c = value;
    });

    await todayBudget.then((value) {
      d = value;
    });

    if (d == 0) {
      return 0.0;
    }

    double ret = (c / d).toDouble();

    return ret;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Expanded(
              flex: 1,
              child: FutureBuilder(
                  future: persent(),
                  builder: (context, value) {
                    if (value.hasData) {
                      return _CONPOMENT.circle(value.data!, "本年结余");
                    }
                    return const Text("无数据");
                  })),
          Expanded(
              flex: 1,
              child: FutureBuilder(
                  future: persent(),
                  builder: (context, value) {
                    if (value.hasData) {
                      return _CONPOMENT.circle(value.data!, "本月结余");
                    }
                    return const Text("无数据");
                  })),
          Expanded(
              flex: 1,
              child: FutureBuilder(
                  future: persent(),
                  builder: (context, value) {
                    if (value.hasData) {
                      return _CONPOMENT.circle(value.data!, "本日结余");
                    }
                    return const Text("无数据");
                  })),
        ]));
  }
}

class _CONPOMENT {
  static Widget circle(double value, String title) {
    return Column(children: [
      CircularPercentIndicator(
        radius: 50.0,
        lineWidth: 11.0,
        animation: true,
        animationDuration: 1700,
        percent: value > 1 ? 1 : value,
        center: Text("¥${CommonUtils.formatNum(value, 2) * 100}"),
        progressColor:
            value <= 1 ? const Color(0xFF009999) : const Color(0xFFFF0000),
        circularStrokeCap: CircularStrokeCap.round,
      ),
      Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(title,
              style: const TextStyle(color: Color(0xFFCCCCCC), fontSize: 11)))
    ]);
  }
}
