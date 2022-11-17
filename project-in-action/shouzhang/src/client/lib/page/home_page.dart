/*
 * @Author: gui-qi
 * @Date: 2022-10-29 01:37:32
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-17 00:57:17
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/component/custom_float_button.dart';
import 'package:client/config/route.dart';
import 'package:client/dao/bill_dao.dart';
import 'package:client/dao/setting_dao.dart';
import 'package:client/develop/FadeTransition.dart';
import 'package:client/page/setting_page.dart';
import 'package:client/model/persistent_object/bill.dart';
import 'package:client/page/add_page.dart';
import 'package:client/service/server_data_access_service.dart';
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
      SettingDao.currentUser(),
      DateTime.now(),
      po.reason,
      po.type,
      po.amount,
      po.note,
      DateTime.now(),
    );
    BillDao.saveBill(bill);
  }

  @override
  Widget build(BuildContext context) {
    Map<dynamic, Function> para = {
      ICONS.ADD: () {
        context.go(ROUTE.ADD_BILL);
      },
      ICONS.SETTING: () {
        context.go(ROUTE.SETTING);
      },
    };

    return PageWithFloatButton(
      funcIcon: para,
      defaultForward: false,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _COMPONENT.menu(context, '流水', () => context.go(ROUTE.BILLS)),
                _COMPONENT.verticalDivider(),
                _COMPONENT.menu(context, '预算', () => context.go(ROUTE.BUDGET)),
                _COMPONENT.verticalDivider(),
                _COMPONENT.menu(context, '盘账', () => context.go(ROUTE.ACCOUNT)),
              ],
            ),
            const Divider(
              color: Colors.grey,
              thickness: 0,
              indent: 20,
              endIndent: 20,
              height: 1,
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
                    child: const Card(
                      child: Text("今天"),
                    ),
                  )),
            )),
            Dev.onDevelop(const MyStatefulWidget()),

            // Text(
            //   '日别，月别，周别，年别，消费分析，建议，警告',
            //
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
            // Text(
            //   '日别，月别，周别，年别，预算分析，建议，警告',
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
            // Text(
            //   '资产管理，盘账',
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
            // Text(
            //   '消费目标，预计达成时间',
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
            // Text(
            //   '预算，年度，',
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
            // Text(
            //   '消费/预算 原因，消费种类（类型）',
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
            // Text(
            //   '设置背景图',
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
          ],
        ),
      ),
    );
  }
}

class _COMPONENT {
  static Widget menu(BuildContext context, String title, Function onEvent) {
    return Expanded(
        child: GestureDetector(
            onTap: () {
              onEvent();
            },
            child: SizedBox(
                height: 30,
                child:
                    Center(child: Text(title, textAlign: TextAlign.center)))));
  }

  static Widget verticalDivider() {
    return const SizedBox(
        height: 30,
        child: VerticalDivider(
          color: Colors.grey,
          thickness: 1,
          width: 1,
          indent: 2,
          endIndent: 2,
        ));
  }
}
