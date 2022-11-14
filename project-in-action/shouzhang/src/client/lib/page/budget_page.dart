/*
 * @Author: gui-qi
 * @Date: 2022-10-29 01:37:32
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-14 08:28:45
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/config/route.dart';
import 'package:client/model/persistent_object/budget.dart';
import 'package:client/page/add_bill_page.dart';
import 'package:client/component/custom_float_button.dart';
import 'package:client/service/local_database_service.dart';
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
  late Future<List<Budget>> fetchListBudget;

  @override
  void initState() {
    super.initState();
    try {
      fetchListBudget = DB.fetchListBudget();
      fetchListBudget.then((value) {
        value.forEach((budget) {
          if (budget.type == 0 && !widget.outList.contains(budget)) {
            widget.outList.add(budget);
          }
          if (budget.type == 1 && !widget.outList.contains(budget)) {
            widget.inList.add(budget);
          }
        });
      });
    } on Exception {}
  }

  @override
  Widget build(BuildContext context) {


  int year = DB.budgetYear();

    Map<IconData, Function> para = {
      ICONS.BACK: () {
        context.go(ROUTE.HOME);
      },
      ICONS.SAVE: () {
        DB.saveListBudget(widget.outList);
        DB.saveListBudget(widget.inList);
        context.go(ROUTE.HOME);
      },
      ICONS.ADD: () {
        showBottomSheet(
            context: context,
            builder: (context) => SizedBox(
                  height: 380,
                  child: AddBillView(
                    onSaved: (po) {
                      setState(() {
                        Budget b = Budget(
                          const Uuid().v1(),
                          DB.currentUser(),
                          DB.budgetYear().toString(),
                          po.reason,
                          po.type,
                          po.amount,
                          po.note,
                          0,
                          DateTime.now()
                        );
                        if (po.type == 0) {
                          widget.outList.add(b);
                        } else {
                          widget.inList.add(b);
                        }
                      });
                    },
                  ),
                ));
      },
    };

    return PageWithFloatButton(
      funcIcon: para,
      child: Scaffold(
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Column(
              children: [
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
                                side: const BorderSide(
                                    width: 0,
                                    color: Colors.grey),
                                label: Text((2022 + index).toString()),
                                selected: year == (index + 2022),
                                onSelected: (bool selected) {
                                  DB.setBudgetYear(index + 2022);
                                  setState(() {
                                  });
                                },
                              ));
                        })),
                SizedBox(
                    height: 100,
                    width: constraints.maxWidth,
                    child: const Card(child: Text("概览"))),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SizedBox(
                          height: 40,
                          width: constraints.maxWidth / 2,
                          child: const Card(
                            child: Text(
                                style: TextStyle(fontSize: 15),
                                textAlign: TextAlign.center,
                                "支出"),
                          )),
                      SizedBox(
                          height: 40,
                          width: constraints.maxWidth / 2,
                          child: const Card(
                            child: Text(
                                style: TextStyle(fontSize: 15),
                                textAlign: TextAlign.center,
                                "收入"),
                          ))
                    ]),
                SizedBox(
                    height: constraints.maxHeight - 180,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: FutureBuilder<List<Budget>>(
                        future: fetchListBudget,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            snapshot.data!.forEach((budget) {
                              if (budget.type == 0 &&
                                  !widget.outList.contains(budget)) {
                                widget.outList.add(budget);
                              }
                              if (budget.type == 1 &&
                                  !widget.inList.contains(budget)) {
                                widget.inList.add(budget);
                              }
                            });

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                SizedBox(
                                    height: constraints.maxHeight,
                                    width: constraints.maxWidth / 2 - 20,
                                    child: ListView.separated(
                                      itemCount: widget.outList.length,
                                      itemBuilder: (context, i) {
                                        return InputWithTest(
                                          text: widget.outList[i].reason,
                                          oldBudget: widget.outList[i].budget
                                              .toString(),
                                              onSelected: (text) => widget.outList[i].budget = double.parse(text),
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              Divider(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    )),
                                SizedBox(
                                    width: constraints.maxWidth / 2 - 20,
                                    child: ListView.separated(
                                      itemCount: widget.inList.length,
                                      itemBuilder: (context, i) {
                                        return InputWithTest(
                                          text: widget.inList[i].reason,
                                          oldBudget: widget.inList[i].budget
                                              .toString(),
                                              onSelected: (text) => widget.inList[i].budget = double.parse(text),
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              Divider(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    )),
                              ],
                              // ),
                            );
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                          return const CircularProgressIndicator();
                        },
                      ),
                    ))
              ],
            );
          },
        ),
      ),
    );
  }
}

class InputWithTest extends StatefulWidget {
  const InputWithTest({super.key, required this.text, required this.oldBudget, required this.onSelected});

  final String text;
  final String oldBudget;
  final Function(String) onSelected;

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
                flex: 4,
                child: Text(
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                    widget.text)),
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
                      widget.onSelected(text);
                    },
                  ),
                )),
          ],
        ));
  }
}
