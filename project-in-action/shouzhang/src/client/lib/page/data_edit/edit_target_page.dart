/*
 * @Author: gui-qi
 * @Date: 2022-10-26 15:06:57
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-25 10:15:28
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/page/component/custom_chart.dart';
import 'package:client/page/component/custom_float_button.dart';
import 'package:client/page/component/custom_snack_bar.dart';
import 'package:client/config/route.dart';
import 'package:client/page/data_model/global_do.dart';
import 'package:client/page/views/financial_amount.dart';
import 'package:client/page/views/financial_duration.dart';
import 'package:client/page/views/financial_note.dart';
import 'package:client/page/views/financial_reason.dart';
import 'package:client/units/common_const.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class EditTargetPage extends StatefulWidget {
  const EditTargetPage({super.key, required this.editType});

  final int editType;

  @override
  State<EditTargetPage> createState() => _EditTargetPageState();
}

class _EditTargetPageState extends State<EditTargetPage> {
  saveBudget() {
    // BudgetDao.saveBudget(context.read<GlobalDO>().budget);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GlobalDO>().type = 2;
    });
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
                  CustomChartDynamic(
                    title: "目标",
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
                    height: 70,
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
