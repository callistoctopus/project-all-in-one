/*
 * @Author: gui-qi
 * @Date: 2022-10-26 15:06:57
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-15 10:17:20
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/component/custom_choice_chip.dart';
import 'package:client/component/custom_float_button.dart';
import 'package:client/component/custom_snack_bar.dart';
import 'package:client/units/common_const.dart';
import 'package:flutter/material.dart';

class AddFinancialReasonView extends StatelessWidget {
  AddFinancialReasonView({
    required this.onEvent,
    required this.rivo,
    super.key,
  });
  FinancialReasonVO rivo;
  final Function(FinancialReasonVO) onEvent;

  List<String> kinds = ['支出', '收入'];
  @override
  Widget build(BuildContext context) {
    Map<dynamic, Function> para = {
      ICONS.BACK: () {
        Navigator.pop(context);
      },
      ICONS.SAVE: () async {
        if (rivo.reason == "") {
          return CustomSnackBar().show(context, '请输入种类名称');
        }
        onEvent(rivo);
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
                child: const Text(style: TextStyle(fontSize: 12), "追加种类"),
              ),
              CustomChoiceChip(
                dataList: kinds,
                onSelect: (i) {
                  rivo.type = i;
                },
                defaultSelect: rivo.type,
                onLongPress: (index) {},
              ),
              Container(
                height: 70,
                padding: const EdgeInsets.only(
                    left: 16, top: 15, right: 16, bottom: 0),
                child: TextField(
                  textAlign: TextAlign.justify,
                  textAlignVertical: TextAlignVertical.center,
                  cursorHeight: 25,
                  decoration: const InputDecoration(
                    prefixText: "",
                    border: OutlineInputBorder(),
                    hintText: '种类名称',
                  ),
                  onChanged: (String text) {
                    rivo.reason = text;
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
                      rivo.note = text;
                    }),
              ),
            ],
          ),
        ));
  }
}

class FinancialReasonVO {
  int type = 0;
  String reason = "";
  String note = "";
}
