/*
 * @Author: gui-qi
 * @Date: 2022-11-22 15:08:02
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-12-11 22:32:45
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/page/component/custom_choice_chip.dart';
import 'package:client/data/listenable/global_do.dart';
import 'package:client/units/common_const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModuleFinancialKind extends StatefulWidget {
  const ModuleFinancialKind({super.key});

  @override
  State<StatefulWidget> createState() => _ModuleFinancialKindState();
}

class _ModuleFinancialKindState extends State<ModuleFinancialKind> {
  @override
  Widget build(BuildContext context) {
    String selectedReason = context.read<GlobalDO>().reason;

    List<String> dataList =
        (context.read<GlobalDO>().type != context.watch<GlobalDO>().type
                    ? context.read<GlobalDO>().type
                    : context.watch<GlobalDO>().type) ==
                0
            ? consumeKind
            : incomeKind;

    return ListView(shrinkWrap: true, children: <Widget>[
      CustomChoiceChip(
        selectedColor: const Color(0xFF336699),
        dataList: dataList,
        onSelect: (i) {
          context.read<GlobalDO>().reason = dataList[i];
        },
        defaultSelect: dataList.indexOf(selectedReason),
        onLongPress: (index) {},
      )
    ]);
  }
}
