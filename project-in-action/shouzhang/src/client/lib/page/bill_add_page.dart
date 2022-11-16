/*
 * @Author: gui-qi
 * @Date: 2022-10-26 15:06:57
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-15 15:04:01
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/component/custom_choice_chip.dart';
import 'package:client/component/custom_float_button.dart';
import 'package:client/component/custom_snack_bar.dart';
import 'package:client/component/icon_toggle_buttons.dart';
import 'package:client/dao/reason_dao.dart';
import 'package:client/dao/setting_dao.dart';
import 'package:client/model/persistent_object/financial_reason.dart';
import 'package:client/page/reason_add_page.dart';
import 'package:client/units/common_const.dart';
import 'package:client/units/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddBillView extends StatefulWidget {
  AddBillView({required this.onSaved, super.key, this.cpo});

  final Function(CashInputVO po) onSaved;
  CashInputVO? cpo;

  @override
  State<AddBillView> createState() => _AddBillViewState();
}

class _AddBillViewState extends State<AddBillView> {
  late Future<List<FinancialReason>> rl1;
  late Future<List<FinancialReason>> rl2;

  saveFinancialReason(FinancialReasonVO rivo) {
    FinancialReason fr = FinancialReason(
        const Uuid().v1(),
        SettingDao.currentUser(),
        rivo.reason,
        rivo.type,
        rivo.note,
        0,
        CommonUtils.now());

    ReasonDao.saveFinancialReason(fr);
  }

  @override
  void initState() {
    super.initState();
    rl1 = ReasonDao.fetchFinancialReasonOut();
    rl2 = ReasonDao.fetchFinancialReasonIn();
    widget.cpo ??= CashInputVO();
  }

  @override
  Widget build(BuildContext context) {
    rl1 = ReasonDao.fetchFinancialReasonOut();
    rl2 = ReasonDao.fetchFinancialReasonIn();

    Map<dynamic, Function> para = {
      ICONS.BACK: () {
        Navigator.pop(context);
      },
      ICONS.SAVE: () {
        if (widget.cpo!.amount == -1) {
          return CustomSnackBar().show(context, "请输入金额");
        }

        widget.onSaved(widget.cpo!);
        Navigator.pop(context);
      }
    };

    List<String> kinds = ['支出', '收入'];

    return PageWithFloatButton(
        funcIcon: para,
        child: Scaffold(
          body: ListView(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(left: 12, top: 3),
                child: const Text(style: TextStyle(fontSize: 12), "记一笔"),
              ),
              CustomChoiceChip(
                dataList: kinds,
                onSelect: (i) {
                  widget.cpo!.type = i;
                  setState(() {});
                },
                defaultSelect: widget.cpo == null ? 0 : widget.cpo!.type,
                onLongPress: (index) {},
              ),
              const Divider(
                color: Colors.grey,
                thickness: 0,
                indent: 20,
                endIndent: 20,
                height: 1,
              ),
              FutureBuilder<List<FinancialReason>>(
                  future: widget.cpo!.type == 0 ? rl1 : rl2,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<String> dataList =
                          snapshot.data!.map((e) => e.reason).toList();
                      dataList.add("+追加");
                      if (dataList.length > 1) {
                        widget.cpo!.reason = dataList[0];
                      }
                      // ? widget.cpo!.reason = dataList[0]
                      // : widget.cpo!.reason;
                      return CustomChoiceChip(
                        dataList: dataList,
                        onSelect: (i) {
                          if (i == (dataList.length - 1)) {
                            return showModalBottomSheet(
                                isScrollControlled: true,
                                // constraints: const BoxConstraints(maxHeight: 300),
                                context: context,
                                builder: (context) => AnimatedPadding(
                                      padding:
                                          MediaQuery.of(context).viewInsets,
                                      duration:
                                          const Duration(milliseconds: 100),
                                      child: AddFinancialReasonView(
                                        onEvent: (rivo) {
                                          saveFinancialReason(rivo);
                                          setState(() {});
                                        },
                                        rivo: FinancialReasonVO()
                                          ..type = widget.cpo!.type,
                                      ),
                                    ));
                          }
                          widget.cpo!.reason = dataList[i];
                        },
                        defaultSelect: dataList.indexOf(widget.cpo!.reason),
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
                                        ReasonDao.deleteFinancialReason(snapshot
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
              const Divider(
                color: Colors.grey,
                thickness: 0,
                indent: 20,
                endIndent: 20,
                height: 1,
              ),
              Container(
                height: 70,
                padding: const EdgeInsets.only(
                    left: 16, top: 15, right: 16, bottom: 0),
                // margin: const EdgeInsets.only(top:5),
                child: TextField(
                  controller: TextEditingController.fromValue(TextEditingValue(
                      text: widget.cpo!.amount == -1
                          ? ""
                          : widget.cpo!.amount.toString())),
                  textAlign: TextAlign.justify,
                  textAlignVertical: TextAlignVertical.center,
                  cursorHeight: 25,
                  decoration: const InputDecoration(
                    prefixText: "￥",
                    border: OutlineInputBorder(),
                    hintText: '金额',
                  ),
                  onChanged: (String text) {
                    widget.cpo!.amount = double.tryParse(text) ?? -1;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: '备注',
                  ),
                  onChanged: (String text) {
                    widget.cpo!.note = text;
                  },
                ),
              ),
            ],
          ),
        ));
  }
}

class CashInputVO {
  int type = 0;
  String reason = "";
  double amount = -1;
  String note = "";
}
