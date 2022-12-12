/*
 * @Author: gui-qi
 * @Date: 2022-11-17 08:06:58
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-12-12 22:12:45
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

  double todayConsume = 0;
  double todayBudget = 0;
  double monthConsume = 0;
  double monthBudget = 0;
  double yearConsume = 0;
  double yearBudget = 0;

  final Future<double> currentDayConsume =
      ConsumeAnalysisService().getTodayTotalCunsume();
  final Future<double> currentDayBudget = BudgetDao.getTodayBudget();
  final Future<double> currentMonthConsume =
      ConsumeAnalysisService().getCurrentMonthTotalCunsume();
  final Future<double> currentMonthBudget = BudgetDao.getCurrentMonthBudget();
  final Future<double> currentYearConsume =
      ConsumeAnalysisService().getCurrentYearTotalCunsume();
  final Future<double> currentYearBudget = BudgetDao.getCurrentYearBudget();

  Future<int> persent() async {
    await currentDayConsume.then((value) {
      todayConsume = value;
    });

    await currentDayBudget.then((value) {
      todayBudget = value;
    });

    await currentMonthConsume.then((value) {
      monthConsume = value;
    });

    await currentMonthBudget.then((value) {
      monthBudget = value;
    });

    await currentYearConsume.then((value) {
      monthBudget = value;
    });

    await currentYearBudget.then((value) {
      yearBudget = value;
    });

    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
        child: FutureBuilder(
            future: persent(),
            builder: (context, value) {
              if (value.hasData) {
                return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          flex: 1,
                          child: _CONPOMENT.circle(
                              ((yearBudget - monthBudget) / yearBudget)
                                  .toDouble(),
                              yearBudget - monthBudget,
                              "本年结余")),
                      Expanded(
                          flex: 1,
                          child: _CONPOMENT.circle(
                              ((monthBudget - monthConsume) / monthBudget)
                                  .toDouble(),
                              monthBudget - monthConsume,
                              "本月结余")),
                      Expanded(
                          flex: 1,
                          child: _CONPOMENT.circle(
                              ((todayBudget - todayConsume) / todayBudget)
                                  .toDouble(),
                              todayBudget - todayConsume,
                              "本日结余")),
                    ]);
              }
              return const Text("无数据");
            }));
  }
}

class _CONPOMENT {
  static Widget circle(double persent, double value, String title) {
    return Column(children: [
      CircularPercentIndicator(
        radius: 50.0,
        lineWidth: 11.0,
        animation: true,
        animationDuration: 1700,
        percent: persent < 0 ? 0.01 : persent,
        center: Text("¥${CommonUtils.formatNum(value, 2)}"),
        progressColor:
            value > 0.3 ? const Color(0xFF009999) : const Color(0xFFFF0000),
        circularStrokeCap: CircularStrokeCap.round,
      ),
      Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(title,
              style: const TextStyle(color: Color(0xFFCCCCCC), fontSize: 11)))
    ]);
  }
}

class _CircleData {
  double persent = 0;
  double consume = 0;
  double budget = 0;
}
