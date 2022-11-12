/*
 * @Author: gui-qi
 * @Date: 2022-10-29 01:37:32
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-12 13:10:52
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/component/custom_float_button.dart';
import 'package:client/config/route.dart';
import 'package:client/develop/setting_page.dart';
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
  bool selected = false;
  @override
  void initState() {
    super.initState();
    DataAccessService.syncData();
  }

  saveBill(CashInputVO po) {
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
  }

  @override
  Widget build(BuildContext context) {
    Map<IconData, Function> para = {
      ICONS.LOGOUT: () {
        DB.setLogined(false);
        context.go(ROUTE.LOGIN);
      },
      ICONS.SETTING: () {
        context.go(ROUTE.SETTING);
      },
      ICONS.ADD: () {
        showModalBottomSheet(
            context: context,
            builder: (context) => AddBillView(
                  onSaved: (po) => saveBill(po),
                ));
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
            Dev.onDevelop(Padding(
                padding: const EdgeInsets.only(top: 15),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = !selected;
                    });
                  },
                  child: AnimatedContainer(
                    height: selected ? 100.0 : 180.0,
                    color: selected ? Colors.yellow : Colors.blue,
                    alignment: selected
                        ? Alignment.center
                        : AlignmentDirectional.topStart,
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.fastOutSlowIn,
                    child: const Card(child: Text("今天"),),
                  )),
                )),

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
}
