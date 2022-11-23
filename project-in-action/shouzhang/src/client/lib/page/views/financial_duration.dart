/*
 * @Author: gui-qi
 * @Date: 2022-11-23 05:21:03
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-23 10:22:52
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/page/component/custom_choice_chip.dart';
import 'package:client/page/data_model/global_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FinancialDurationView extends StatefulWidget {
  const FinancialDurationView({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _FinancialDurationState();
}


List<String> duration = ['每天', '工作日', '每周', '每月', '每季度', '半年', '每年'];
    
class _FinancialDurationState extends State<FinancialDurationView> {
  List<String> kinds = ['支出', '收入'];
  @override
  Widget build(BuildContext context) {
    return CustomChoiceChip(
      dataList: duration,
      onSelect: (i) {
        context.read<GlobalDO>().duration = i;
        setState(() {});
      },
      defaultSelect: context.read<GlobalDO>().duration,
      onLongPress: (index) {},
    );
  }
}
