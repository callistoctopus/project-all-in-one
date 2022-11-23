/*
 * @Author: gui-qi
 * @Date: 2022-10-26 15:06:57
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-23 11:12:32
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/page/component/custom_chart.dart';
import 'package:client/page/component/custom_float_button.dart';
import 'package:client/page/component/custom_snack_bar.dart';
import 'package:client/config/route.dart';
import 'package:client/dao/budget_dao.dart';
import 'package:client/page/data_model/global_do.dart';
import 'package:client/page/views/financial_amount.dart';
import 'package:client/page/views/financial_duration.dart';
import 'package:client/page/views/financial_note.dart';
import 'package:client/page/views/financial_reason.dart';
import 'package:client/page/views/financial_type.dart';
import 'package:client/units/common_const.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AddBudgetView extends StatefulWidget {
  const AddBudgetView({super.key, required this.editType});

  final int editType;

  @override
  State<AddBudgetView> createState() => _AddBudgetViewState();
}

class _AddBudgetViewState extends State<AddBudgetView> {
  saveBudget() {
    BudgetDao.saveBudget(context.read<GlobalDO>().budget);
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

    Map<dynamic, Function> para = {
      ICONS.BACK: () {
        context.go(ROUTE.HOME);
      },
      ICONS.SAVE: () {
        if (context.read<GlobalDO>().amount == -1) {
          return CustomSnackBar().show(context, "请输入金额");
        }

        saveBudget();
        context.go(ROUTE.HOME);
      }
    };

    return PageWithFloatButton(
        funcIcon: para,
        child: Scaffold(
          body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListView(
                children: <Widget>[
                  CustomChart(
                    title: "收支类型",
                    height: 70,
                    child: const FinancialTypeView(),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0,
                    height: 10,
                  ),
                  CustomChartDynamic(
                    title: "收支事项",
                    child: const FinancialReasonView(),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0,
                    height: 12,
                  ),
                  CustomChartDynamic(
                    title: "预算周期",
                    child: const FinancialDurationView(),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0,
                    height: 12,
                  ),
                  CustomChart(
                    title: "收支金额",
                    height: 90,
                    child: const FinancialAmountView(),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0,
                    height: 12,
                  ),
                  CustomChart(
                    title: "备注信息",
                    child: const FinancialNoteView(),
                  ),
                ],
              )),
        ));
  }
}
