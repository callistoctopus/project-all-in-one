/*
 * @Author: gui-qi
 * @Date: 2022-10-29 01:37:32
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-09 13:19:22
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/component/custom_float_button.dart';
import 'package:client/develop/develop.dart';
import 'package:client/model/persistent_object/bill.dart';
import 'package:client/service/data_access_service.dart';
import 'package:client/service/local_database_service.dart';
import 'package:client/units/common_const.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

import 'add_cash_page.dart';

class AnaysisPage extends StatefulWidget {
  const AnaysisPage({super.key});

  @override
  State<AnaysisPage> createState() => _AnaysisPageState();
}

class _AnaysisPageState extends State<AnaysisPage> {
  @override
  Widget build(BuildContext context) {
    Map<IconData, Function> para = {
      // CommonConst.ICONS['BUG']!: () {
      //   Navigator.push(context,
      //       MaterialPageRoute(builder: (context) => const DevelopmentPage()));
      // },
      ICONS.LIST: () {
        // Navigator.pushNamed(context, '/billList');
        context.go('/billList');
      },
      ICONS.BUDGET: () {
        // Navigator.pushNamed(context, '/budget');
        context.go('/budget');
      },
      ICONS.SYNC: () {
        DataAccessService.syncData();
      },
      ICONS.LOGOUT: () {
        DB.setLogined(false);
        context.go('/login');
      },
      ICONS.BOOK: () {
        context.go('/account');
      },
      ICONS.ADD: () {
        showBottomSheet(
            context: context,
            builder: (context) => SizedBox(
                  height: 380,
                  child: CashInputPage(
                    onSaved: (po) {
                      Bill bill = Bill(
                        "",
                        "",
                        DateTime.now(),
                        po.reason,
                        po.type,
                        po.amount,
                        po.note,
                        DateTime.now(),
                      );
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
