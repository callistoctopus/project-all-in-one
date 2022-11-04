/*
 * @Author: gui-qi
 * @Date: 2022-10-29 01:37:32
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-04 19:28:10
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'dart:ui';

import 'package:client/model/budget.dart';
import 'package:client/page/add_financial_reason_page.dart';
import 'package:client/component/custom_float_button.dart';
import 'package:client/service/data_access_service.dart';
import 'package:client/units/common_const.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class BudgetSettingPage extends StatefulWidget {
  const BudgetSettingPage({super.key});

  @override
  State<BudgetSettingPage> createState() => _BudgetSettingPageState();
}

class _BudgetSettingPageState extends State<BudgetSettingPage> {
  late Future<List<Budget>> fetchListBudget;

  @override
  void initState() {
    super.initState();
    try {
      fetchListBudget = DataAccessService.fetchListBudget();
    } on Exception {}
  }

  @override
  Widget build(BuildContext context) {
    Map<IconData, Function> para = {
      CommonConst.ICONS['BACK']!: () {
        Navigator.pop(context);
      },
      CommonConst.ICONS['SAVE']!: () {
        Navigator.pop(context);
      },
      CommonConst.ICONS['ADD']!: () {
        showBottomSheet(
            context: context,
            builder: (context) => const SizedBox(
                  height: 380,
                  child: AddFinancialReasonPage(),
                ));
      },
      CommonConst.ICONS['FILTER']!: () {
        showBottomSheet(
            context: context,
            builder: (context) => const SizedBox(
                  height: 380,
                  child: AddFinancialReasonPage(),
                ));
      },
    };

    return PageWithFloatButton(
        funcIcon: para,
        child: Scaffold(
          body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Padding(
                padding: const EdgeInsets.only(top: 15),
                child: FutureBuilder<List<Budget>>(
                  future: fetchListBudget,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Budget?> outList = [];
                      List<Budget?> inList = [];

                      snapshot.data!.forEach((budget) {
                        if (budget.type == 0) outList.add(budget);
                        if (budget.type == 1) inList.add(budget);
                      });

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          SizedBox(
                              width: constraints.maxWidth / 2 -20,
                              child: ListView.separated(
                                itemCount: outList.length,
                                itemBuilder: (context, i) {
                                  if(i == 0){
                                    return const Text("支出");
                                  }
                                  return InputWithTest(
                                    text: outList[i-1]!.reason,
                                    oldBudget: outList[i-1]!.amount.toString(),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const Divider(),
                              )),
                          SizedBox(
                              width: constraints.maxWidth / 2 -20,
                              child: ListView.separated(
                                itemCount: inList.length,
                                itemBuilder: (context, i) {

                                  if(i == 0){
                                    return const Text("收入");
                                  }

                                  return InputWithTest(
                                    text: inList[i-1]!.reason,
                                    oldBudget: inList[i-1]!.amount.toString(),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const Divider(),
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
              );
            },
          ),
        ));
  }
}

class InputWithTest extends StatefulWidget {
  const InputWithTest({super.key, required this.text, required this.oldBudget});

  final String text;
  final String oldBudget;

  @override
  State<InputWithTest> createState() => _InputWithTestState();
}

class _InputWithTestState extends State<InputWithTest> {
  var money = "";
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(right: 15),child: Row(
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
                strutStyle: const StrutStyle(height: 1.5,forceStrutHeight:true),
                cursorHeight: 25,
                decoration: InputDecoration(
                  contentPadding:const EdgeInsets.only(left: 1,top: 1, right: 1,bottom: 1),
                  prefixText: "￥",
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(width: 0,style: BorderStyle.solid)),
                  hintText: widget.oldBudget,
                ),
                onChanged: (String text) {
                  money = text;
                },
              ),
            )),
      ],
    ));
  }
}
