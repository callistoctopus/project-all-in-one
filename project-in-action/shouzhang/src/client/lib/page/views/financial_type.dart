/*
 * @Author: gui-qi
 * @Date: 2022-11-22 15:44:20
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-23 08:34:51
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/model/bill.dart';
import 'package:client/page/component/custom_choice_chip.dart';
import 'package:client/page/data_model/bill_vo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FinancialTypeView extends StatefulWidget {
  const FinancialTypeView({super.key});

  @override
  State<StatefulWidget> createState() => _FinancialTypeViewState();
}

class _FinancialTypeViewState extends State<FinancialTypeView> {
  List<String> kinds = ['支出', '收入'];
  
  @override
  Widget build(BuildContext context) {
    Bill bill = context.read<BillVO>().bill;
    return CustomChoiceChip(
      dataList: kinds,
      backgroundColor: Colors.red,
      onSelect: (i) {
        bill.type = i;
        context.read<BillVO>().bill = bill;
        setState(() {});
      },
      defaultSelect: context.read<BillVO>().bill.type,
      onLongPress: (index) {},
    );
  }
}
