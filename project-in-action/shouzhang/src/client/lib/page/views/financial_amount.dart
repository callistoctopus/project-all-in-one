/*
 * @Author: gui-qi
 * @Date: 2022-11-23 05:21:03
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-23 08:42:11
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/model/bill.dart';
import 'package:client/page/data_model/bill_vo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FinancialAmountView extends StatefulWidget {
  const FinancialAmountView({super.key,});

  @override
  State<StatefulWidget> createState() => _FinancialAmountState();
}

class _FinancialAmountState extends State<FinancialAmountView> {
  List<String> kinds = ['支出', '收入'];
  @override
  Widget build(BuildContext context) {
    Bill bill = context.read<BillVO>().bill;
    return Container(
      padding: const EdgeInsets.only(top: 0),
      height: 60,
      child: TextField(
        keyboardType: TextInputType.number,
        controller: TextEditingController.fromValue(TextEditingValue(
            text: bill.amount == -1 ? "" : bill.amount.toString())),
        textAlign: TextAlign.justify,
        textAlignVertical: TextAlignVertical.center,
        cursorHeight: 25,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(2),
          fillColor: Colors.grey,
          prefixText: "￥",
          border: InputBorder.none,
          hintText: '金额',
        ),
        onChanged: (String text) {
          bill.amount = double.tryParse(text) ?? -1;
          context.read<BillVO>().bill = bill;
        },
      ),
    );
  }
}
