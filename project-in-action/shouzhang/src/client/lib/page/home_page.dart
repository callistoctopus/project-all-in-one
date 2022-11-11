/*
 * @Author: gui-qi
 * @Date: 2022-10-29 01:37:32
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-11 06:45:18
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/component/custom_float_button.dart';
import 'package:client/develop/develop.dart';
import 'package:client/model/persistent_object/bill.dart';
import 'package:client/page/add_bill_page.dart';
import 'package:client/service/server_data_access_service.dart';
import 'package:client/service/local_database_service.dart';
import 'package:client/units/common_const.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    DataAccessService.syncData();
  }

  @override
  Widget build(BuildContext context) {
    Map<IconData, Function> para = {
      ICONS.LOGOUT: () {
        DB.setLogined(false);
        context.go(ROUTE.LOGIN);
      },
      ICONS.SETTING: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const DevelopmentPage()));
      },
      ICONS.ADD: () {
        showBottomSheet(
            context: context, builder: (context) => _COMPONENT.addBill());
      },
    };

    return PageWithFloatButton(
      funcIcon: para,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _COMPONENT.v1(context, '账单', () => context.go(ROUTE.BILLS)),
                _COMPONENT.v1(context, '预算', () => context.go(ROUTE.BUDGET)),
                _COMPONENT.v1(context, '账本', () => context.go(ROUTE.ACCOUNT)),
              ],
            ),

            // Text(
            //   '消费预测，建议，警告',
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
            // Text(
            //   '预算',
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
            // Text(
            //   '日报',
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
            // Text(
            //   '周报',
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
            // Text(
            //   '月报',
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
            // Text(
            //   '自动扣费',
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
            // Text(
            //   '消息提示',
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
          ],
        ),
      ),
    );
  }
}

class _COMPONENT {
  static Widget v1(BuildContext context, String title, Function onEvent) {
    return Expanded(
        child: GestureDetector(
            onTap: () {
              onEvent();
            },
            child: SizedBox(
                height: 40,
                child: Card(
                    child: Center(
                        child: Text(title, textAlign: TextAlign.center))))));
  }

  static Widget addBill() {
    return SizedBox(
      height: 380,
      child: AddBillView(
        onSaved: (po) {
          Bill bill = Bill(
            const Uuid().v1(),
            DB.currentUser(),
            DateTime.now(),
            po.reason,
            po.type,
            po.amount,
            po.note,
            DateTime.now(),
          );
          DB.saveBill(bill);
        },
      ),
    );
  }
}
