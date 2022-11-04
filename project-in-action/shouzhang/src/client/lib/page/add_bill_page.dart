/*
 * @Author: gui-qi
 * @Date: 2022-10-26 15:06:57
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-04 16:52:01
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/component/custom_choice_chip.dart';
import 'package:client/component/custom_float_button.dart';
import 'package:client/model/bill.dart';
import 'package:client/model/financial_reason.dart';
import 'package:client/service/data_access_service.dart';
import 'package:client/units/common_const.dart';
import 'package:flutter/material.dart';
import '../component/icon_toggle_buttons.dart';

class AddCashFlowPage extends StatefulWidget {
  const AddCashFlowPage({super.key});

  @override
  State<AddCashFlowPage> createState() => _AddCashFlowPageState();
}

class _AddCashFlowPageState extends State<AddCashFlowPage> {
  late Future<List<FinancialReason>> rl1;
  late Future<List<FinancialReason>> rl2;
  Bill bill = Bill();

  @override
  void initState() {
    super.initState();
    try {
      rl1 = DataAccessService.fetchFinancialReasonOut();
      rl2 = DataAccessService.fetchFinancialReasonIn();
    } on Exception {}
  }

  @override
  Widget build(BuildContext context) {
    Map<IconData, Function> para = {
      CommonConst.ICONS['BACK']!: () {
        Navigator.pop(context);
      },
      CommonConst.ICONS['SAVE']!: () {
        if (bill.amount == null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Theme.of(context).primaryColor,
              duration: const Duration(milliseconds: 1200),
              shape: const ContinuousRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              padding:
                  const EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 15),
              content: Text(
                '请输入金额',
                style: TextStyle(color: Theme.of(context).canvasColor),
                textAlign: TextAlign.center,
              ),
              behavior: SnackBarBehavior.floating,
              dismissDirection: DismissDirection.up));
          return;
        }

        bill.time = DateTime.now();
        DataAccessService.saveBill(bill);
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
                    if (lables.isNotEmpty && bill.type != t) {
                      bill.type = t;
                      setState(() {});
                    }
                  },
                  isSingle: true,
                  defaultSelected: bill.type == 0 ? '支出' : '收入',
                ),
              ),
              FutureBuilder<List<FinancialReason>>(
                  future: bill.type == 0 ? rl1 : rl2,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<String> dataList =
                          snapshot.data!.map((e) => e.reason!).toList();
                      bill.reason = dataList[0];
                      return CustomChoiceChip(
                        dataList: dataList,
                        onSelect: (i) {
                          bill.reason = dataList[i];
                        },
                        defaultSelect: dataList.indexOf(bill.reason!),
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }

                    return const CircularProgressIndicator();
                  }),
              Container(
                height: 70, //这里调整高度即可，建议按照屏幕高度比例来计算
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
                    bill.amount = double.parse(text);
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: '备注',
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
