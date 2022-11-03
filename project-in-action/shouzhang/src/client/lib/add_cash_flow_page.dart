/*
 * @Author: gui-qi
 * @Date: 2022-10-26 15:06:57
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-03 10:15:06
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'dart:convert';

import 'package:client/component/custom_float_button.dart';
import 'package:flutter/material.dart';
import 'component/icon_toggle_buttons.dart';
import 'package:http/http.dart' as http;

class AddCashFlowPage extends StatefulWidget {
  const AddCashFlowPage({super.key});

  @override
  State<AddCashFlowPage> createState() => _AddCashFlowPageState();
}

class _AddCashFlowPageState extends State<AddCashFlowPage> {
  var user = "";
  var time = DateTime(2022);
  var reason = "";
  var type = "支出";
  var amount = "";
  var note = '';

  var rl1 = {
    '衣服': Icons.shopping_basket,
    '餐饮': Icons.restaurant,
    '买菜': Icons.shopping_bag,
    '房租': Icons.attach_money,
    '水电': Icons.water_drop,
  };

  var rl2 = {'工资': Icons.attach_money, '外快': Icons.work, '人情': Icons.people};

  @override
  Widget build(BuildContext context) {
    Map<IconData, Function> para = {
      Icons.cancel: () {
        Navigator.pop(context);
      },
      Icons.save: () async {
        final response = await http.post(
          Uri.parse('http://139.224.11.164:8080/api/add/detail'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'amount': double.parse(this.amount),
            'note': this.note,
            'reason': this.reason,
            'time': '',
            'type': this.type,
            'user': 'test',
          }),
        );

        if (response.statusCode == 200) {
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Failed to load album')));
          return;
        }
      }
    };

    Widget reason() {
      Widget reason1 = Padding(
          padding: const EdgeInsets.only(left: 3, top: 0),
          child: IconToggleButtons(
            labelIcon: rl1,
            onSelect: (lables) {
              this.reason = lables[0];
            },
            isSingle: true, defaultSelected: rl1.keys.elementAt(0),
          ));

      Widget reason2 = Padding(
          padding: const EdgeInsets.only(left: 3, top: 0),
          child: IconToggleButtons(
            labelIcon: rl2,
            onSelect: (lables) {
              this.reason = lables[0];
            },
            isSingle: true, defaultSelected: rl2.keys.elementAt(0),
          ));
      return type == '支出' ? reason1 : reason2;
    }

    // #docregion itemBuilder
    return PageWithFloatButton(
        funcIcon: para,
        child: Scaffold(
          body: ListView(
            // mainAxisAlignment: MainAxisAlignment.start,
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
                    if (lables.isNotEmpty && type != lables[0]) {
                      type = lables[0];
                      setState(() {});
                    }
                  },
                  isSingle: true, defaultSelected: type,
                ),
              ),
              reason(),
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
                    amount = text;
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
