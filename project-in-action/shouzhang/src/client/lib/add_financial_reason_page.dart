/*
 * @Author: gui-qi
 * @Date: 2022-10-26 15:06:57
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-03 14:27:46
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'dart:convert';

import 'package:client/component/custom_float_button.dart';
import 'package:flutter/material.dart';
import 'component/icon_toggle_buttons.dart';
import 'package:http/http.dart' as http;

class AddFinancialReasonPage extends StatefulWidget {
  const AddFinancialReasonPage({super.key});

  @override
  State<AddFinancialReasonPage> createState() => _AddFinancialReasonPageState();
}

class _AddFinancialReasonPageState extends State<AddFinancialReasonPage> {
  var user = "";
  var reason = "";
  var type = "支出";
  var note = '';

  @override
  Widget build(BuildContext context) {
    Map<IconData, Function> para = {
      Icons.cancel: () {
        Navigator.pop(context);
      },
      Icons.save: () async {
        final response = await http.post(
          Uri.parse('http://139.224.11.164:8080/api/add/financial'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'user': 'test',
            'type': this.type == '支出' ? 0 : 1,
            'reason': this.reason,
            'note': this.note,
          }),
        );

        if (response.statusCode == 200) {
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Failed to add album')));
          return;
        }
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
                    if (lables.isNotEmpty && type != lables[0]) {
                      type = lables[0];
                      setState(() {});
                    }
                  },
                  isSingle: true,
                  defaultSelected: type,
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
                    reason = text;
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
