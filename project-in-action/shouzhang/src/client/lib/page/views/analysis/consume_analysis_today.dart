/*
 * @Author: gui-qi
 * @Date: 2022-11-17 08:06:58
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-30 14:53:54
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/data/dao/budget_dao.dart';
import 'package:client/data/service/budget_analysis_service%20copy.dart';
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
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Expanded(
          flex: 1,
          child: FutureBuilder(
              future: persent(),
              builder: (context, value) {
                if (value.hasData) {
                  return CircularPercentIndicator(
                    radius: 40.0,
                    lineWidth: 11.0,
                    animation: true,
                    percent: value.data! > 1 ? 1 : value.data!,
                    center: Text("${value.data! * 100}%"),
                    progressColor: value.data! <= 1 ? Colors.green : Colors.red,
                    circularStrokeCap: CircularStrokeCap.round,
                  );
                }
                return const Text("无数据");
              })),
      Expanded(
          flex: 1,
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            FutureBuilder(
                future: todayConsume,
                builder: (context, value) {
                  if (value.hasData) {
                    return Text("消费: ${value.data}",
                        maxLines: 1, overflow: TextOverflow.ellipsis);
                  }
                  return const Text("无数据");
                }),
            FutureBuilder(
                future: todayBudget,
                builder: (context, value) {
                  if (value.hasData) {
                    return Text(
                        "预算: ${CommonUtils.formatNum(value.data as num, 2)}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis);
                  }
                  return const Text("无数据");
                }),
          ])),
    ]);
  }
}
