/*
 * @Author: gui-qi
 * @Date: 2022-10-29 01:37:32
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-04 02:28:23
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/model/budget.dart';
import 'package:client/page/add_financial_reason_page.dart';
import 'package:client/component/custom_float_button.dart';
import 'package:client/service/data_access_service.dart';
import 'package:flutter/material.dart';

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
      Icons.cancel: () {
        Navigator.pop(context);
      },
      Icons.save: () {
        Navigator.pop(context);
      },
    };

    fun() {
      showBottomSheet(
          context: context,
          builder: (context) => const SizedBox(
                height: 380,
                child: AddFinancialReasonPage(),
              ));
    }

    return PageWithFloatButton(
        funcIcon: para,
        child: Scaffold(
          body: FutureBuilder<List<Budget>>(
            future: fetchListBudget,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.length + 1,
                    itemBuilder: (context, i) {
                      if (i == snapshot.data!.length) {
                        return TextButton(
                            onPressed: fun, child: const Text("追加"));
                      }

                      return InputWithTest(
                        text: snapshot.data![i].reason,
                        oldBudget: snapshot.data![i].amount.toString(),
                      );
                    });
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
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
        SizedBox(
            width: 100,
            child: Text(
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
                widget.text)),
        SizedBox(
          width: 140.0,
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
