/*
 * @Author: gui-qi
 * @Date: 2022-10-29 01:37:32
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-05 08:20:44
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/component/custom_float_button.dart';
import 'package:client/develop/develop.dart';
import 'package:client/model/bill.dart';
import 'package:client/service/data_access_service.dart';
import 'package:client/units/common_const.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'add_cash_page.dart';
import 'budget_page.dart';
import 'bill_flow_page.dart';

class AnaysisPage extends StatefulWidget {
  const AnaysisPage({super.key});

  @override
  State<AnaysisPage> createState() => _AnaysisPageState();
}

class _AnaysisPageState extends State<AnaysisPage> {
  @override
  Widget build(BuildContext context) {
    Map<IconData, Function> para = {
      CommonConst.ICONS['BUG']!: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const DevelopmentPage()));
      },
      CommonConst.ICONS['LIST']!: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const CashFlowPage()));
      },
      CommonConst.ICONS['BUDGET']!: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Scaffold(body: BudgetSettingPage())));
      },
      CommonConst.ICONS['ADD']!: () {
        showBottomSheet(
            context: context,
            builder: (context) => SizedBox(
                  height: 380,
                  child: CashInputPage(
                    onSaved: (po) {
                      Bill bill = Bill();
                      bill.user = "test";
                      bill.time = DateTime.now();
                      bill.reason = po.reason;
                      bill.type = po.type;
                      bill.amount = po.amount;
                      bill.note = po.note;
                      DataAccessService.saveBill(bill);
                    },
                  ),
                ));
      },
    };

    return PageWithFloatButton(
      funcIcon: para,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '消费预测，建议，警告',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              '预算',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              '日报',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              '周报',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              '月报',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
