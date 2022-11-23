/*
 * @Author: gui-qi
 * @Date: 2022-11-23 05:21:03
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-23 14:20:39
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/page/data_model/global_do.dart';
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
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextField(
        style:const TextStyle(fontSize: 20),
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          hintText: '备注',
        ),
        onChanged: (String text) {
          context.read<GlobalDO>().note = text;
        },
      ),
    );
  }
}
