/*
 * @Author: gui-qi
 * @Date: 2022-10-29 01:37:32
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-04 05:01:16
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/component/custom_float_button.dart';
import 'package:client/develop/develop.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'add_bill_page.dart';
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
      Icons.bug_report_rounded: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const DevelopmentPage()));
      },
      Iconsax.receipt: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const CashFlowPage()));
      },
      Iconsax.activity: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const Scaffold(body: BudgetSettingPage())));
      },
      Iconsax.add: () {
        showBottomSheet(
            context: context,
            builder: (context) => const SizedBox(
                  height: 380,
                  child: AddCashFlowPage(),
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
