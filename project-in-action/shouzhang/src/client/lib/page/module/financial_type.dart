/*
 * @Author: gui-qi
 * @Date: 2022-11-22 15:44:20
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-12-11 22:25:21
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/page/component/custom_choice_chip.dart';
import 'package:client/data/listenable/global_do.dart';
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
    return CustomChoiceChip(
      dataList: kinds,
      selectedColor: const Color(0xFFFF6666),
      onSelect: (i) {
        context.read<GlobalDO>().type = i;
        setState(() {});
      },
      defaultSelect: context.read<GlobalDO>().type,
      onLongPress: (index) {},
      // direction: Axis.vertical,
    );
  }
}
