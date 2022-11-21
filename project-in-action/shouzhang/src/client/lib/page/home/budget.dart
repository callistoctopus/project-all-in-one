/*
 * @Author: gui-qi
 * @Date: 2022-10-29 01:37:32
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-21 05:26:46
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/page/component/custom_snack_bar.dart';
import 'package:client/config/route.dart';
import 'package:client/dao/budget_dao.dart';
import 'package:client/dao/setting_dao.dart';
import 'package:client/model/budget.dart';
import 'package:client/page/data_model/ParamStore.dart';
import 'package:client/page/data_show/edit_bill_page.dart';
import 'package:client/page/component/custom_float_button.dart';
import 'package:client/units/common_const.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

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
    fetchListBudget.forEach((budget) {
      if (budget.type == 0 && !widget.outList.contains(budget)) {
        widget.outList.add(budget);
      }
      if (budget.type == 1 && !widget.outList.contains(budget)) {
        widget.inList.add(budget);
      }
    });

    int year = SettingDao.budgetYear();

    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Column(children: [
            SizedBox(
                height: 40,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.only(
                              top: 5.0, right: 10.0, bottom: 5),
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
              indent: 20,
              endIndent: 20,
              height: 5,
            ),
            Container(
                alignment: Alignment.topCenter,
                height: 100,
                width: constraints.maxWidth,
                child: const Text("概览")),
            const Divider(
              color: Colors.grey,
              thickness: 0,
              indent: 20,
              endIndent: 20,
              height: 5,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    height: 20,
                    width: constraints.maxWidth / 2,
                    child:
                        GestureDetector(onTap: () {}, child: const Text("支出")),
                  ),
                  const SizedBox(
                      height: 20,
                      child: VerticalDivider(
                        color: Colors.grey,
                        thickness: 1,
                        width: 0,
                        indent: 2,
                        endIndent: 2,
                      )),
                  Container(
                    alignment: Alignment.center,
                    height: 20,
                    width: constraints.maxWidth / 2,
                    child:
                        GestureDetector(onTap: () {}, child: const Text("收入")),
                  )
                ]),
            SizedBox(
                height: constraints.maxHeight - 190,
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SizedBox(
                          height: constraints.maxHeight,
                          width: constraints.maxWidth / 2 - 20,
                          child: ListView.separated(
                            itemCount: widget.outList.length,
                            itemBuilder: (context, i) {
                              return InputWithTest(
                                  budget: widget.outList[i],
                                  oldBudget:
                                      widget.outList[i].budget.toString(),
                                  onSelected: (budget) {
                                    BudgetDao.updateBudget(budget);
                                    setState(() {});
                                  },
                                  onDeleted: (budget) {
                                    BudgetDao.deleteBudget(budget);
                                    setState(() {});
                                  });
                            },
                            separatorBuilder:
                                (BuildContext context, int index) => Divider(
                              color: Theme.of(context).primaryColor,
                            ),
                          )),
                      const SizedBox(
                          child: VerticalDivider(
                        color: Colors.grey,
                        thickness: 1,
                        width: 0,
                        indent: 2,
                        endIndent: 2,
                      )),
                      SizedBox(
                          width: constraints.maxWidth / 2 - 20,
                          child: ListView.separated(
                            itemCount: widget.inList.length,
                            itemBuilder: (context, i) {
                              return InputWithTest(
                                budget: widget.inList[i],
                                oldBudget: widget.inList[i].budget.toString(),
                                onSelected: (budget) {
                                  BudgetDao.updateBudget(budget);
                                  setState(() {});
                                },
                                onDeleted: (budget) {
                                  BudgetDao.deleteBudget(budget);
                                  setState(() {});
                                },
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) => Divider(
                              color: Theme.of(context).primaryColor,
                            ),
                          )),
                    ],
                  ),
                ))
          ]);
        },
      ),
    );
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
