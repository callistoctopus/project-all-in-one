/*
 * @Author: gui-qi
 * @Date: 2022-10-26 15:06:57
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-23 02:41:45
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/page/component/common_component.dart';
import 'package:client/page/component/custom_choice_chip.dart';
import 'package:client/page/component/custom_float_button.dart';
import 'package:client/page/component/custom_snack_bar.dart';
import 'package:client/config/route.dart';
import 'package:client/dao/bill_dao.dart';
import 'package:client/dao/budget_dao.dart';
import 'package:client/dao/reason_dao.dart';
import 'package:client/dao/setting_dao.dart';
import 'package:client/model/bill.dart';
import 'package:client/model/budget.dart';
import 'package:client/model/financial_reason.dart';
import 'package:client/page/data_model/ParamStore.dart';
import 'package:client/page/data_model/financial_type.dart';
import 'package:client/page/views/financial_reason.dart';
import 'package:client/page/views/financial_type.dart';
import 'package:client/units/common_const.dart';
import 'package:client/units/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddBillView extends StatefulWidget {
  AddBillView({super.key, required this.cpo});

  CashInputVO cpo;

  @override
  State<AddBillView> createState() => _AddBillViewState();
}

class _AddBillViewState extends State<AddBillView> {
  saveBill() {
    late Bill bill;
    if (widget.cpo.dataType == 0) {
      if (widget.cpo.editType == 0) {
        bill = Bill(
          const Uuid().v1(),
          SettingDao.currentUser(),
          DateTime.now(),
          widget.cpo.reason,
          widget.cpo.type,
          widget.cpo.amount,
          widget.cpo.note,
          DateTime.now(),
        );
      } else {
        bill = PageParamStore.bill!;
        bill.reason = widget.cpo.reason;
        bill.type = widget.cpo.type;
        bill.amount = widget.cpo.amount;
        bill.note = widget.cpo.note;
      }

      BillDao.saveBill(bill);
    } else {
      late Budget b;
      if (widget.cpo.editType == 0) {
        b = Budget(
            const Uuid().v1(),
            SettingDao.currentUser(),
            SettingDao.budgetYear().toString(),
            widget.cpo.reason,
            widget.cpo.type,
            widget.cpo.duration,
            widget.cpo.amount,
            widget.cpo.note,
            0,
            DateTime.now());
      } else {
        b = PageParamStore.budget!;
        b.reason = widget.cpo.reason;
        b.type = widget.cpo.type;
        b.budget = widget.cpo.amount;
        b.note = widget.cpo.note;
      }
      BudgetDao.saveBudget(b);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.cpo.editType == 1) {
      if (widget.cpo.dataType == 0) {
        widget.cpo.type = PageParamStore.bill!.type;
        widget.cpo.reason = PageParamStore.bill!.reason;
        widget.cpo.amount = PageParamStore.bill!.amount;
        widget.cpo.note = PageParamStore.bill!.note;
      } else {
        widget.cpo.type = PageParamStore.budget!.type;
        widget.cpo.reason = PageParamStore.budget!.reason;
        widget.cpo.amount = PageParamStore.budget!.budget;
        widget.cpo.note = PageParamStore.budget!.note;
      }
    }

    Map<dynamic, Function> para = {
      ICONS.BACK: () {
        context.go(ROUTE.HOME);
      },
      ICONS.SAVE: () {
        if (widget.cpo.amount == -1) {
          return CustomSnackBar().show(context, "请输入金额");
        }

        saveBill();
        context.go(ROUTE.HOME);
      }
    };

    return PageWithFloatButton(
        funcIcon: para,
        child: Scaffold(
            body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: MultiProvider(
              providers: [
                ChangeNotifierProvider<FinancialType>(create: (_) => FinancialType()),
              ],
              child: ListView(
                children: <Widget>[
                  CustomChart(
                    title: "收支类型",
                    height: 70,
                    child: FinancialTypeView(
                      callback: (int value) {},
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0,
                    height: 10,
                  ),
                  CustomChart(
                    title: "收支事项",
                    height: 80,
                    child: FinancialReasonView(
                      callback: (reason) {
                        widget.cpo.reason = reason;
                      },
                      reasonType: 0,
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0,
                    height: 12,
                  ),
                  CustomChart(
                    title: "收支金额",
                    height: 90,
                    child: Container(
                      padding: const EdgeInsets.only(top: 0),
                      height: 60,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: TextEditingController.fromValue(
                            TextEditingValue(
                                text: widget.cpo.amount == -1
                                    ? ""
                                    : widget.cpo.amount.toString())),
                        textAlign: TextAlign.justify,
                        textAlignVertical: TextAlignVertical.center,
                        cursorHeight: 25,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(2),
                          fillColor: Colors.grey,
                          prefixText: "￥",
                          border: InputBorder.none,
                          hintText: '金额',
                        ),
                        onChanged: (String text) {
                          widget.cpo.amount = double.tryParse(text) ?? -1;
                        },
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0,
                    height: 12,
                  ),
                  CustomChart(
                    title: "备注信息",
                    child: SizedBox(
                      child: TextField(
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: '备注',
                        ),
                        onChanged: (String text) {
                          widget.cpo.note = text;
                        },
                      ),
                    ),
                  )
                ],
              )),
        )));
  }
}

class CashInputVO {
  int editType = 0; //0:新增 1：编辑
  int dataType = 0; //0:收支 1:预算
  int type = 0;
  String reason = "";
  double amount = -1;
  int duration = 0;
  String note = "";
}
