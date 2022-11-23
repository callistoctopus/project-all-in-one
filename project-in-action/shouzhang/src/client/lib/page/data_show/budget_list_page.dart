/*
 * @Author: gui-qi
 * @Date: 2022-10-29 01:37:32
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-23 15:49:44
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'dart:ui';

import 'package:client/config/route.dart';
import 'package:client/page/component/custom_chart.dart';
import 'package:client/page/component/custom_snack_bar.dart';
import 'package:client/dao/budget_dao.dart';
import 'package:client/dao/setting_dao.dart';
import 'package:client/model/budget.dart';
import 'package:client/units/common_const.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/percent_indicator.dart';

class BudgetSettingPage extends StatefulWidget {
  BudgetSettingPage({super.key});

  List<Budget> outList = [];
  List<Budget> inList = [];

  @override
  State<BudgetSettingPage> createState() => _BudgetSettingPageState();
}

class _BudgetSettingPageState extends State<BudgetSettingPage> {
  List<Budget> fetchListBudget = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.outList.clear();
    widget.inList.clear();
    fetchListBudget = BudgetDao.fetchListBudget();
    // fetchListBudget.forEach((budget) {
    //   if (budget.type == 0 && !widget.outList.contains(budget)) {
    //     widget.outList.add(budget);
    //   }
    //   if (budget.type == 1 && !widget.outList.contains(budget)) {
    //     widget.inList.add(budget);
    //   }
    // });

    int year = SettingDao.budgetYear();

    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 20, top: 5),
          child: ListView(children: [
            CustomChart(title: "预算概览", height: 100, child: const SizedBox()),
            const Divider(
              color: Colors.grey,
              thickness: 0,
              height: 5,
            ),
            CustomChart(
                title: "预算年度",
                height: 60,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.only(
                              top: 5.0, right: 5.0, bottom: 5),
                          child: ChoiceChip(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.all(2),
                            side:
                                const BorderSide(width: 0, color: Colors.grey),
                            label: Text((2022 + index).toString()),
                            selected: year == (index + 2022),
                            onSelected: (bool selected) {
                              SettingDao.setBudgetYear(index + 2022);
                              setState(() {});
                            },
                          ));
                    })),
            const Divider(
              color: Colors.grey,
              thickness: 0,
              height: 5,
            ),
            CustomChart(
                title: "预算明细",
                link: "追加",
                callback: () {
                  context.go(ROUTE.ADD_BUDGET);
                },
                height: window.physicalSize.height - 175,
                child: ListView.builder(
                    itemCount: fetchListBudget.length,
                    itemBuilder: (context, index) {
                      return _COMPONMENT.budgetView(fetchListBudget[index]);
                    })),
          ])),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Colors.white,
        child: Text(
          ICONS.BACK,
          style: const TextStyle(color: Colors.black),
        ),
        onPressed: () => context.go(ROUTE.HOME),
      ),
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
                          budget.type == 0 ? "收" : "支",
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
                            const CircleAvatar(
                                radius: 13,
                                backgroundColor: Colors.white,
                                child: Text(
                                  "总",
                                  style: TextStyle(fontSize: 12,color: Colors.black),
                                )),
                            Text(budget.budget.toString(),
                                style: const TextStyle(fontSize: 12)),
                          ]),
                      LinearPercentIndicator(
                        animation: true,
                        lineHeight: 18.0,
                        animationDuration: 2500,
                        percent: 0.8,
                        center: const Text("80.0%"),
                        barRadius: const Radius.circular(10),
                        progressColor: Colors.green,
                      )
                    ]),
              ),
            ),
            const Expanded(
                flex: 1,
                child: Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: CircleAvatar(
                        radius: 13,
                        backgroundColor: Colors.white,
                        child: Text(
                          "余",
                          style: TextStyle(fontSize: 18,color: Colors.black),
                        )))),
            Expanded(
                flex: 1,
                child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(budget.budget.toString()))),
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