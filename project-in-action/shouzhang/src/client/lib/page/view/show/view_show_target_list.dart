/*
 * @Author: gui-qi
 * @Date: 2022-10-29 01:37:32
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-12-10 21:25:53
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'dart:ui';

import 'package:client/page/config/route.dart';
import 'package:client/page/component/custom_chart.dart';
import 'package:client/page/component/custom_snack_bar.dart';
import 'package:client/data/dao/budget_dao.dart';
import 'package:client/data/dao/setting_dao.dart';
import 'package:client/data/model/budget.dart';
import 'package:client/page/module/analysis/consume_analysis_by_reason.dart';
import 'package:client/units/common_const.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TargetListPage extends StatefulWidget {
  const TargetListPage({super.key});

  @override
  State<TargetListPage> createState() => _TargetListPageState();
}

class _TargetListPageState extends State<TargetListPage> {
  List<Budget> fetchListBudget = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fetchListBudget = BudgetDao.fetchListBudget();
    fetchListBudget.sort((a, b) {
      return a.type > b.type ? 0 : 1;
    });

    int year = SettingDao.budgetYear();

    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 20, top: 5),
          child: ListView(children: [
            CustomChart(title: "", height: 180, child: const PieChartSample2()),
            const Divider(
              color: Color(0xFFC4CBCF),
              thickness: 0,
              height: 1,
              indent: 10,
              endIndent: 10,
            ),
            CustomChart(
                title: "计划列表",
                link: "追加",
                callback: () {
                  context.go(ROUTE.ADD_TARGET);
                },
                height: window.physicalSize.height - 175,
                child: ListView.builder(
                    itemCount: fetchListBudget.length,
                    itemBuilder: (context, index) {
                      return _COMPONMENT.budgetView(fetchListBudget[index]);
                    })),
          ])),
    );
  }
}

class _COMPONMENT {
  static Widget budgetView(Budget budget) {
    return Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
                flex: 1,
                child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: CircleAvatar(
                        radius: 13,
                        backgroundColor:
                            budget.type == 0 ? Colors.red : Colors.green,
                        child: Text(
                          budget.type == 0 ? "攒" : "投",
                          style: const TextStyle(fontSize: 18),
                        )))),
            Expanded(
                flex: 1,
                child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(budget.reason))),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("总 ${budget.budget}",
                                style: const TextStyle(fontSize: 12)),
                          ]),
                      LinearPercentIndicator(
                        animation: true,
                        lineHeight: 18.0,
                        animationDuration: 800,
                        percent: (budget.budget - 0) / budget.budget,
                        center: Text(
                            "${(budget.budget - 0) / budget.budget * 100}%"),
                        barRadius: const Radius.circular(10),
                        progressColor: Colors.green,
                      )
                    ]),
              ),
            ),
            Expanded(
                flex: 3,
                child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      "达成 ${budget.budget}",
                      maxLines: 1,
                    ))),
          ],
        ));
  }
}

class InputWithTest extends StatefulWidget {
  const InputWithTest(
      {super.key,
      required this.budget,
      required this.oldBudget,
      required this.onSelected,
      required this.onDeleted});

  final Budget budget;
  final String oldBudget;
  final Function(Budget) onSelected;
  final Function(Budget) onDeleted;

  @override
  State<InputWithTest> createState() => _InputWithTestState();
}

class _InputWithTestState extends State<InputWithTest> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 15),
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: GestureDetector(
                  child: const Icon(ICONS.DELETE),
                  onTap: () {
                    widget.onDeleted(widget.budget);
                  },
                )),
            Expanded(
                flex: 4,
                child: Text(
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                    widget.budget.reason)),
            Expanded(
                flex: 5,
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    strutStyle:
                        const StrutStyle(height: 1.5, forceStrutHeight: true),
                    cursorHeight: 25,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                          left: 1, top: 1, right: 1, bottom: 1),
                      prefixText: "￥",
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              style: BorderStyle.solid,
                              color: Colors.white)),
                      hintText: widget.oldBudget,
                    ),
                    onChanged: (String text) {
                      if (double.tryParse(text) == null) {
                        CustomSnackBar().show(context, "您输入的不是数字");
                        return;
                      }
                      widget.budget.budget = double.tryParse(text) ?? 0;
                      widget.onSelected(widget.budget);
                    },
                  ),
                )),
          ],
        ));
  }
}
