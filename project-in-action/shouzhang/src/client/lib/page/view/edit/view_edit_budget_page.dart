/*
 * @Author: gui-qi
 * @Date: 2022-10-26 15:06:57
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-12-11 22:07:31
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/data/dao/dao.dart';
import 'package:client/data/db.dart';
import 'package:client/data/model/budget.dart';
import 'package:client/page/component/custom_button.dart';
import 'package:client/page/component/custom_chart.dart';
import 'package:client/page/component/custom_snack_bar.dart';
import 'package:client/page/config/route.dart';
import 'package:client/data/listenable/global_do.dart';
import 'package:client/page/module/financial_amount.dart';
import 'package:client/page/module/financial_duration.dart';
import 'package:client/page/module/financial_kind.dart';
import 'package:client/page/module/financial_reason.dart';
import 'package:client/page/module/financial_type.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class EditBudgetPage extends StatefulWidget {
  const EditBudgetPage({super.key, required this.editType});

  final int editType;

  @override
  State<EditBudgetPage> createState() => _EditBudgetPageState();
}

class _EditBudgetPageState extends State<EditBudgetPage> {
  saveBudget() {
    Dao.upsert<Budget>(context.read<GlobalDO>().budget, TABLE.budget);
  }

  @override
  void initState() {
    super.initState();
  }

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.editType == 0) {
      context.read<GlobalDO>().budget = null;
    }

    return 
        Scaffold(
          body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListView(
                children: <Widget>[
                  SizedBox(
                      height: 90,
                      child: Row(children: const [
                        Flexible(flex: 1, child: FinancialTypeView()),
                        Flexible(flex: 1, child: FinancialAmountView()),
                      ])),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0,
                    height: 10,
                  ),
                  CustomChartDynamic(
                    title: "",
                    child: const ModuleFinancialKind(),
                  ),

                  const Divider(
                    color: Colors.grey,
                    thickness: 0,
                    height: 10,
                  ),
                  CustomChartDynamic(
                    title: "",
                    child: const FinancialReasonView(),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0,
                    height: 12,
                  ),
                  CustomChartDynamic(
                    title: "",
                    child: const FinancialDurationView(),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ComponentButton(
                              btnName: "返回",
                              callback: () {
                                context.go(ROUTE.HOME);
                              }),
                          ComponentButton(
                              btnName: "保存",
                              callback: () {
                                if (context.read<GlobalDO>().amount == -1) {
                                  return CustomSnackBar()
                                      .show(context, "请输入金额");
                                }

                                saveBudget();
                                context.go(ROUTE.HOME);
                              })
                        ],
                      ))
                ],
              )),
        );
  }
}
