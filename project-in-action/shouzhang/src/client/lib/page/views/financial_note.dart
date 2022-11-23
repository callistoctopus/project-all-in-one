/*
 * @Author: gui-qi
 * @Date: 2022-11-23 05:21:03
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-23 08:40:22
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/model/bill.dart';
import 'package:client/page/data_model/bill_vo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FinancialNoteView extends StatefulWidget {
  const FinancialNoteView({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _FinancialNoteViewState();
}

class _FinancialNoteViewState extends State<FinancialNoteView> {
  List<String> kinds = ['支出', '收入'];
  @override
  Widget build(BuildContext context) {
    Bill bill = context.read<BillVO>().bill;
    return SizedBox(
      child: TextField(
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          hintText: '备注',
        ),
        onChanged: (String text) {
          bill.note = text;
          context.read<BillVO>().bill = bill;
        },
      ),
    );
  }
}
