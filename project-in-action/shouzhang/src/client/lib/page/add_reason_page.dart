/*
 * @Author: gui-qi
 * @Date: 2022-10-26 15:06:57
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-11 06:35:45
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/component/custom_float_button.dart';
import 'package:client/component/custom_snack_bar.dart';
import 'package:client/component/icon_toggle_buttons.dart';
import 'package:client/units/common_const.dart';
import 'package:flutter/material.dart';

class AddFinancialReasonView extends StatelessWidget {
  AddFinancialReasonView({
    required this.onEvent,
    super.key,
  });

  final Function(FinancialReasonVO) onEvent;
  FinancialReasonVO rivo = FinancialReasonVO();
  @override
  Widget build(BuildContext context) {
    Map<IconData, Function> para = {
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
              Padding(
                padding: const EdgeInsets.only(left: 3, top: 6, right: 0),
                child: IconToggleButtons(
                  labelIcon: const {'支出': Icons.output, '收入': Icons.input},
                  onSelect: (lables) {
                    var t = '支出' == lables[0] ? 0 : 1;
                    if (lables.isNotEmpty && rivo.type != t) {
                      rivo.type = t;
                    }
                  },
                  isSingle: true,
                  defaultSelected: rivo.type == 0 ? '支出' : '收入',
                ),
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
