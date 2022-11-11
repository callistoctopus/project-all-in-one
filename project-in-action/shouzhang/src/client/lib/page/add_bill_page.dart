/*
 * @Author: gui-qi
 * @Date: 2022-10-26 15:06:57
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-11 10:16:11
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/component/custom_choice_chip.dart';
import 'package:client/component/custom_float_button.dart';
import 'package:client/component/custom_snack_bar.dart';
import 'package:client/component/icon_toggle_buttons.dart';
import 'package:client/model/persistent_object/financial_reason.dart';
import 'package:client/page/add_reason_page.dart';
import 'package:client/service/local_database_service.dart';
import 'package:client/units/common_const.dart';
import 'package:client/units/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddBillView extends StatefulWidget {
  const AddBillView({required this.onSaved, super.key});

  final Function(CashInputVO po) onSaved;

  @override
  State<AddBillView> createState() => _AddBillViewState();
}

class _AddBillViewState extends State<AddBillView> {
  late Future<List<FinancialReason>> rl1;
  late Future<List<FinancialReason>> rl2;

  CashInputVO cpo = CashInputVO();

  saveFinancialReason(FinancialReasonVO rivo) {
    FinancialReason fr = FinancialReason(const Uuid().v1(), DB.currentUser(),
        rivo.reason, rivo.type, rivo.note, 0, CommonUtils.now());

    DB.saveFinancialReason(fr);
  }

  @override
  void initState() {
    super.initState();
    rl1 = DB.fetchFinancialReasonOut();
    rl2 = DB.fetchFinancialReasonIn();
  }

  @override
  Widget build(BuildContext context) {

    rl1 = DB.fetchFinancialReasonOut();
    rl2 = DB.fetchFinancialReasonIn();
    
    Map<IconData, Function> para = {
      ICONS.BACK: () {
        Navigator.pop(context);
      },
      ICONS.SAVE: () {
        if (cpo.amount == -1) {
          return CustomSnackBar().show(context, "请输入金额");
        }

        widget.onSaved(cpo);
        Navigator.pop(context);
      }
    };

    return PageWithFloatButton(
        funcIcon: para,
        child: Scaffold(
          body: ListView(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(left: 12, top: 3),
                child: const Text(style: TextStyle(fontSize: 12), "记一笔"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3, top: 6, right: 0),
                child: IconToggleButtons(
                  labelIcon: const {'支出': Icons.output, '收入': Icons.input},
                  onSelect: (lables) {
                    int t = lables[0] == '支出' ? 0 : 1;
                    if (lables.isNotEmpty && cpo.type != t) {
                      cpo.type = t;
                      setState(() {});
                    }
                  },
                  isSingle: true,
                  defaultSelected: cpo.type == 0 ? '支出' : '收入',
                ),
              ),
              FutureBuilder<List<FinancialReason>>(
                  future: cpo.type == 0 ? rl1 : rl2,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<String> dataList =
                          snapshot.data!.map((e) => e.reason).toList();
                      dataList.add("+追加");
                      cpo.reason = dataList[0];
                      return CustomChoiceChip(
                        dataList: dataList,
                        onSelect: (i) {
                          if (i == (dataList.length - 1)) {
                            return showModalBottomSheet(
                              constraints: const BoxConstraints(maxHeight: 300),
                              context: context,
                              builder: (context) => AddFinancialReasonView(
                                onEvent: (rivo) {
                                  saveFinancialReason(rivo);
                                  setState(() {});
                                },
                              ),
                            );
                          }
                          cpo.reason = dataList[i];
                        },
                        defaultSelect: dataList.indexOf(cpo.reason),
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }

                    return const CircularProgressIndicator();
                  }),
              Container(
                height: 70,
                padding: const EdgeInsets.only(
                    left: 16, top: 15, right: 16, bottom: 0),
                // margin: const EdgeInsets.only(top:5),
                child: TextField(
                  textAlign: TextAlign.justify,
                  textAlignVertical: TextAlignVertical.center,
                  cursorHeight: 25,
                  // scrollPadding: EdgeInsets.all(2.0),
                  decoration: const InputDecoration(
                    prefixText: "￥",
                    border: OutlineInputBorder(),
                    hintText: '金额',
                  ),
                  onChanged: (String text) {
                    cpo.amount = double.tryParse(text) ?? -1;
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
                    cpo.note = text;
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
