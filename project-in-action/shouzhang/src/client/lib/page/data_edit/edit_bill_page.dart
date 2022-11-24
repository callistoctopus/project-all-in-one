/*
 * @Author: gui-qi
 * @Date: 2022-10-26 15:06:57
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-24 10:37:44
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/page/component/custom_chart.dart';
import 'package:client/page/component/custom_float_button.dart';
import 'package:client/page/component/custom_snack_bar.dart';
import 'package:client/config/route.dart';
import 'package:client/dao/bill_dao.dart';
import 'package:client/page/data_model/global_do.dart';
import 'package:client/page/views/financial_amount.dart';
import 'package:client/page/views/financial_note.dart';
import 'package:client/page/views/financial_reason.dart';
import 'package:client/page/views/financial_type.dart';
import 'package:client/units/common_const.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AddBillView extends StatefulWidget {
  const AddBillView({super.key, required this.editType});

  final int editType;

  @override
  State<AddBillView> createState() => _AddBillViewState();
}

class _AddBillViewState extends State<AddBillView> {
  saveBill() {
    BillDao.saveBill(context.read<GlobalDO>().bill);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.editType == 0) {
      context.read<GlobalDO>().bill = null;
    }

    Map<dynamic, Function> para = {
      ICONS.BACK: () {
        context.go(ROUTE.HOME);
      },
      ICONS.SAVE: () {
        if (context.read<GlobalDO>().amount == -1) {
          return CustomSnackBar().show(context, "请输入金额");
        }

        saveBill();
        context.go(ROUTE.HOME);
      }
    };

    return
        PageWithFloatButton(
            funcIcon: para,
            child:
        Scaffold(
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
              // CustomChart(
                title: "收支事项",
                // height: 1000,
                child: const FinancialReasonView(),
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
              )
            ],
          )),
      )
    );
  }
}
