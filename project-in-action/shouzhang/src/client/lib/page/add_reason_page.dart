/*
 * @Author: gui-qi
 * @Date: 2022-10-26 15:06:57
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-07 06:26:53
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/component/custom_float_button.dart';
import 'package:client/model/persistent_object/financial_reason.dart';
import 'package:client/service/data_access_service.dart';
import 'package:client/units/common_const.dart';
import 'package:flutter/material.dart';
import '../component/icon_toggle_buttons.dart';

class AddFinancialReasonPage extends StatefulWidget {
  const AddFinancialReasonPage({super.key,});

  @override
  State<AddFinancialReasonPage> createState() => _AddFinancialReasonPageState();
}

class _AddFinancialReasonPageState extends State<AddFinancialReasonPage> {
  FinancialReason fr = FinancialReason("","","",0,"",0,DateTime.now());

  @override
  Widget build(BuildContext context) {
    Map<IconData, Function> para = {
      CommonConst.ICONS['BACK']!: () {
        Navigator.pop(context);
      },
      CommonConst.ICONS['SAVE']!: () async {
        if (fr.reason == null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Theme.of(context).primaryColor,
              duration: const Duration(milliseconds: 1200),
              shape: const ContinuousRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              padding: const EdgeInsets.only(
                  left: 15, top: 15, right: 15, bottom: 15),
              content: Text(
                '请输入种类名称',
                style: TextStyle(color: Theme.of(context).canvasColor),
                textAlign: TextAlign.center,
              ),
              behavior: SnackBarBehavior.floating,
              dismissDirection: DismissDirection.up));
          return;
        }

        DataAccessService.saveFinancialReason(fr);
        Navigator.pop(context);
      }
    };

    // #docregion itemBuilder
    return PageWithFloatButton(
        funcIcon: para,
        child: Scaffold(
          body: ListView(
            // mainAxisAlignment: MainAxisAlignment.start,
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
                    if (lables.isNotEmpty && fr.type != t) {
                      fr.type = t;
                      setState(() {});
                    }
                  },
                  isSingle: true,
                  defaultSelected: fr.type == 0 ? '支出' : '收入',
                ),
              ),
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
                    prefixText: "",
                    border: OutlineInputBorder(),
                    hintText: '种类名称',
                  ),
                  onChanged: (String text) {
                    fr.reason = text;
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
