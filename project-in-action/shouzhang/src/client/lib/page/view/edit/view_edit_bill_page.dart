/*
 * @Author: gui-qi
 * @Date: 2022-10-26 15:06:57
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-12-13 22:56:29
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/data/dao/dao.dart';
import 'package:client/data/db.dart';
import 'package:client/data/model/bill.dart';
import 'package:client/page/component/custom_button.dart';
import 'package:client/page/component/custom_chart.dart';
import 'package:client/page/component/custom_float_button.dart';
import 'package:client/page/component/custom_segment.dart';
import 'package:client/page/component/custom_snack_bar.dart';
import 'package:client/page/config/route.dart';
import 'package:client/data/listenable/global_do.dart';
import 'package:client/page/module/financial_amount.dart';
import 'package:client/page/module/financial_kind.dart';
import 'package:client/page/module/financial_reason.dart';
import 'package:client/page/module/financial_type.dart';
import 'package:client/units/common_const.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class EditBillPage extends StatefulWidget {
  const EditBillPage({super.key, required this.editType});

  final int editType;

  @override
  State<EditBillPage> createState() => _EditBillPageState();
}

class _EditBillPageState extends State<EditBillPage> {
  saveBill() {
    Dao.upsert<Bill>(context.read<GlobalDO>().bill, TABLE.bill);
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

    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: ListView(
            children: <Widget>[
              SizedBox(
                  height: 90,
                  child: Row(children: const [
                    Flexible(flex: 1, child: FinancialTypeView()),
                    Flexible(flex: 1, child: FinancialAmountView()),
                  ])),
              const Divider(
                color: Color(0xFFC4CBCF),
                thickness: 0,
                height: 1,
                indent: 10,
                endIndent: 10,
              ),
              CustomChartDynamic(
                title: "",
                child: const SegmentedControlApp(),
              ),
              
              CustomChartDynamic(
                title: "",
                child: const ModuleFinancialKind(),
              ),

              const Divider(
                color: Color(0xFFC4CBCF),
                thickness: 0,
                height: 1,
                indent: 10,
                endIndent: 10,
              ),
              CustomChartDynamic(
                title: "",
                child: const FinancialReasonView(),
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
                              return CustomSnackBar().show(context, "请输入金额");
                            }

                            saveBill();
                            context.go(ROUTE.HOME);
                          })
                    ],
                  ))
            ],
          )),
    );
  }
}
