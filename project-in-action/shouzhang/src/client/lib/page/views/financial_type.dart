/*
 * @Author: gui-qi
 * @Date: 2022-11-22 15:44:20
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-22 16:27:07
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/page/component/custom_choice_chip.dart';
import 'package:flutter/material.dart';

class FinancialTypeView extends StatefulWidget {
  FinancialTypeView({super.key, required this.callback});

  void Function(int) callback;
  int type = 0;

  @override
  State<StatefulWidget> createState() => _FinancialTypeViewState();
}

class _FinancialTypeViewState extends State<FinancialTypeView> {
  List<String> kinds = ['支出', '收入'];
  @override
  Widget build(BuildContext context) {
    return CustomChoiceChip(
      dataList: kinds,
      backgroundColor: Colors.red,
      onSelect: (i) {
        widget.type = i;
        widget.callback(i);
        setState(() {});
      },
      defaultSelect: widget.type,
      onLongPress: (index) {},
    );
  }
}
