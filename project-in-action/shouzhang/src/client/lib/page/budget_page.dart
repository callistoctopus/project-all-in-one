/*
 * @Author: gui-qi
 * @Date: 2022-10-29 01:37:32
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-04 18:11:12
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
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
                        children: <Widget>[
                          SizedBox(
                              width: constraints.maxWidth / 2 - 20,
                              child: ListView.builder(
                                  itemCount: outList.length,
                                  itemBuilder: (context, i) {
                                    return InputWithTest(
                                      text: outList[i]!.reason,
                                      oldBudget: outList[i]!.amount.toString(),
                                    );
                                  })),
                          SizedBox(
                              width: constraints.maxWidth / 2 -20,
                              child: ListView.builder(
                                  itemCount: inList.length,
                                  itemBuilder: (context, i) {
                                    return InputWithTest(
                                      text: inList[i]!.reason,
                                      oldBudget: inList[i]!.amount.toString(),
                                    );
                                  })),
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
    return Row(
      children: <Widget>[
        Expanded(
            flex: 3,
            child: Text(
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
                widget.text)),
        Expanded(
          flex: 3,
          child: TextField(
            textAlign: TextAlign.justify,
            textAlignVertical: TextAlignVertical.center,
            cursorHeight: 25,
            decoration: InputDecoration(
              prefixText: "￥",
              border: const UnderlineInputBorder(),
              hintText: widget.oldBudget,
            ),
            onChanged: (String text) {
              money = text;
            },
          ),
        ),
      ],
    );
  }
}
