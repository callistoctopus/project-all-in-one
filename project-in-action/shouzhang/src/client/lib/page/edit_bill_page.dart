/*
 * @Author: gui-qi
 * @Date: 2022-10-26 15:06:57
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-18 15:19:38
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/component/custom_choice_chip.dart';
import 'package:client/component/custom_float_button.dart';
import 'package:client/component/custom_snack_bar.dart';
import 'package:client/config/route.dart';
import 'package:client/dao/bill_dao.dart';
import 'package:client/dao/budget_dao.dart';
import 'package:client/dao/reason_dao.dart';
import 'package:client/dao/setting_dao.dart';
import 'package:client/model/bill.dart';
import 'package:client/model/budget.dart';
import 'package:client/model/financial_reason.dart';
import 'package:client/page/ParamStore.dart';
import 'package:client/units/common_const.dart';
import 'package:client/units/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

class AddBillView extends StatefulWidget {
  AddBillView({super.key, required this.cpo});

  CashInputVO cpo;

  @override
  State<AddBillView> createState() => _AddBillViewState();
}

class _AddBillViewState extends State<AddBillView> {
  late Future<List<FinancialReason>> rl1;
  late Future<List<FinancialReason>> rl2;
  String reason = "";
  bool showAddReason = false;

  saveFinancialReason() {
    FinancialReason fr = FinancialReason(
        const Uuid().v1(),
        SettingDao.currentUser(),
        reason,
        widget.cpo.type,
        "",
        0,
        CommonUtils.now());

    ReasonDao.saveFinancialReason(fr);
  }

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
    rl1 = ReasonDao.fetchFinancialReasonOut();
    rl2 = ReasonDao.fetchFinancialReasonIn();
  }

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    rl1 = ReasonDao.fetchFinancialReasonOut();
    rl2 = ReasonDao.fetchFinancialReasonIn();

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

    List<String> kinds = ['支出', '收入'];
    List<String> duration = ['每天', '工作日', '每周', '每月', '每季度', '半年', '每年'];

    return PageWithFloatButton(
        funcIcon: para,
        child: Scaffold(
          body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListView(
                children: <Widget>[
                  const Text(style: TextStyle(fontSize: 12), "记一笔"),
                  CustomChoiceChip(
                    dataList: kinds,
                    backgroundColor: Colors.red,
                    onSelect: (i) {
                      widget.cpo.type = i;
                      setState(() {});
                    },
                    defaultSelect: widget.cpo.type,
                    onLongPress: (index) {},
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0,
                    height: 10,
                  ),
                  FutureBuilder<List<FinancialReason>>(
                      future: widget.cpo.type == 0 ? rl1 : rl2,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<String> dataList =
                              snapshot.data!.map((e) => e.reason).toList();
                          dataList.add("+追加");
                          if (dataList.length > 1) {
                            widget.cpo.reason = dataList[0];
                          }
                          return CustomChoiceChip(
                            backgroundColor: Colors.green,
                            dataList: dataList,
                            onSelect: (i) {
                              if (i == (dataList.length - 1)) {
                                setState(() {
                                  showAddReason = true;
                                });
                              }
                              widget.cpo.reason = dataList[i];
                            },
                            defaultSelect: dataList.indexOf(widget.cpo.reason),
                            onLongPress: (index) {
                              showDialog<void>(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('确定删除？'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('确定'),
                                          onPressed: () {
                                            ReasonDao.deleteFinancialReason(
                                                snapshot
                                                    .data!
                                                    .where((element) =>
                                                        element.reason ==
                                                        dataList[index])
                                                    .toList()[0]);
                                            Navigator.of(context).pop();
                                            setState(() {});
                                          },
                                        ),
                                        TextButton(
                                          child: const Text('取消'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }

                        return const CircularProgressIndicator();
                      }),
                  AnimatedContainer(
                      height: showAddReason ? 70 : 0,
                      duration: const Duration(milliseconds: 400),
                      child: Row(children: [
                        Expanded(
                            flex: 1,
                            child: TextField(
                              controller: controller,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    gapPadding: 2,
                                    borderSide: BorderSide(
                                        width: 0,
                                        color: showAddReason
                                            ? Colors.white
                                            : Colors.black,
                                        style: BorderStyle.none)),
                              ),
                              onChanged: (value) {
                                reason = value;
                              },
                            )),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                showAddReason = false;
                                saveFinancialReason();
                                reason = "";
                                controller.clear();
                              });
                            },
                            child: const Text("确定")),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                reason = "";
                                showAddReason = false;
                                controller.clear();
                              });
                            },
                            child: const Text("取消"))
                      ])),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0,
                    height: 12,
                  ),
                  widget.cpo.dataType == 1 ? CustomChoiceChip(
                    dataList: duration,
                    onSelect: (i) {
                      widget.cpo.duration = i;
                      setState(() {});
                    },
                    defaultSelect: widget.cpo.duration,
                    onLongPress: (index) {},
                  ) : const SizedBox(),
                  // const Divider(
                  //   color: Colors.grey,
                  //   thickness: 0,
                  //   height: 16,
                  // ),
                  Container(
                    padding: const EdgeInsets.only(top: 15),
                    height: 70,
                    child: TextField(
                      controller: TextEditingController.fromValue(
                          TextEditingValue(
                              text: widget.cpo.amount == -1
                                  ? ""
                                  : widget.cpo.amount.toString())),
                      textAlign: TextAlign.justify,
                      textAlignVertical: TextAlignVertical.center,
                      cursorHeight: 25,
                      decoration: const InputDecoration(
                        prefixText: "￥",
                        border: OutlineInputBorder(),
                        hintText: '金额',
                      ),
                      onChanged: (String text) {
                        widget.cpo.amount = double.tryParse(text) ?? -1;
                      },
                    ),
                  ),
                  SizedBox(
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
                ],
              )),
        ));
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
