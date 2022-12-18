/*
 * @Author: gui-qi
 * @Date: 2022-11-23 05:21:03
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-12-10 20:06:48
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/data/listenable/global_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FinancialAmountView extends StatefulWidget {
  const FinancialAmountView({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _FinancialAmountState();
}

class _FinancialAmountState extends State<FinancialAmountView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 20),
      height: 90,
      child: TextField(
        autofocus: false,
        style: const TextStyle(fontSize: 22),
        keyboardType: TextInputType.number,
        controller: TextEditingController.fromValue(TextEditingValue(
            text: context.read<GlobalDO>().amount == -1
                ? ""
                : context.read<GlobalDO>().amount.toString())),
        textAlignVertical: TextAlignVertical.center,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(2),
          fillColor: Colors.grey,
          prefixText: "￥",
          border: OutlineInputBorder(
              borderSide: BorderSide( color: Color(0xFFF2F2F2))),
          hintText: '请输入金额',
          hintStyle:TextStyle(color: Color(0xFFE0E0E0))
        ),
        onChanged: (String text) {
          context.read<GlobalDO>().amount = double.tryParse(text) ?? -1;
        },
      ),
    );
  }
}
