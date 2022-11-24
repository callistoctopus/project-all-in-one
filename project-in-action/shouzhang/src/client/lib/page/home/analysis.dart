/*
 * @Author: gui-qi
 * @Date: 2022-10-29 01:37:32
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-24 00:51:11
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/config/route.dart';
import 'package:client/dao/setting_dao.dart';
import 'package:client/page/views/analysis/grade.dart';
import 'package:client/page/component/custom_chart.dart';
import 'package:client/service/local_database_service.dart';
import 'package:client/service/server_data_access_service.dart';
import 'package:client/units/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

class AnalysisPage extends StatefulWidget {
  const AnalysisPage({super.key});

  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

enum Menu { itemOne, itemTwo, itemThree, itemFour }

class _AnalysisPageState extends State<AnalysisPage> {
  bool selected = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            SizedBox(
                height: 25,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(CommonUtils.now().toString().substring(0, 10)),
                    PopupMenuButton<Menu>(
                        padding: const EdgeInsets.all(1),
                        iconSize: 14,
                        onSelected: (Menu item) {
                          setState(() {
                            DataAccessService.syncData();
                          });
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<Menu>>[
                              const PopupMenuItem<Menu>(
                                value: Menu.itemOne,
                                child: Text('账号'),
                              ),
                              const PopupMenuItem<Menu>(
                                value: Menu.itemTwo,
                                child: Text('设置'),
                              ),
                              const PopupMenuItem<Menu>(
                                value: Menu.itemThree,
                                child: Text('退出'),
                              ),
                              const PopupMenuItem<Menu>(
                                value: Menu.itemFour,
                                child: Text('关于'),
                              ),
                            ]),
                  ],
                )),
            const Divider(
              color: Colors.grey,
              thickness: 0,
              height: 1,
            ),
            CustomChart(
                title: "账号",
                link: "设置",
                callback: () {
                  context.go(ROUTE.ACCOUNT);
                },
                height: 125,
                child: Grade()),
            const Divider(
              color: Colors.grey,
              thickness: 0,
              height: 1,
            ),
            SettingItem1(
              initValue: SettingDao.isDev(),
              itemName: "开发者模式",
              callback: (bool? value) {
                setState(() {
                  SettingDao.setDevMode(value ?? false);
                });
              },
            ),
            const Divider(
              color: Colors.grey,
              thickness: 0,
              height: 1,
            ),
            SettingItem2(
              callback: () {
                context.go(ROUTE.DEBUG);
              },
              itemName: '示例',
            ),
            const Divider(
              color: Colors.grey,
              thickness: 0,
              height: 1,
            ),
            SettingItem2(
              callback: () {
                SettingDao.setLogined(false);
                context.go(ROUTE.LOGIN);
              },
              itemName: '退出账号',
            ),
            const Divider(
              color: Colors.grey,
              thickness: 0,
              height: 1,
            ),
            SettingItem2(
              callback: () {
                DB.clear();
                context.go(ROUTE.LOGIN);
              },
              itemName: '清除本地数据',
            ),
            const Divider(
              color: Colors.grey,
              thickness: 0,
              height: 1,
            ),
            SettingItem2(
              callback: () {
                showAboutDialog(
                    context: context,
                    applicationVersion: "0.0.1",
                    applicationName: "丫丫记账",
                    applicationIcon: const Icon(Iconsax.pen_tool),
                    applicationLegalese:
                        "Copyright © 2022 QI YAZI. All rights reserved.",
                    useRootNavigator: false);
              },
              itemName: '关于',
            ),
            const Divider(
              color: Colors.grey,
              thickness: 0,
              height: 1,
            ),
            // COMMON_COMPONENT.chart("消息", "更多", () {}, const SizedBox(),
            //     height: 80),
            // const Divider(
            //   color: Colors.grey,
            //   thickness: 0,
            //   height: 1,
            // ),
          ],
        ),
      ),
    );
  }
}

class _COMPONENT {
  static Widget verticalDivider() {
    return const SizedBox(
        height: 25,
        child: VerticalDivider(
          color: Colors.grey,
          thickness: 1,
          width: 1,
          indent: 2,
          endIndent: 2,
        ));
  }
}

class SettingItem1 extends StatelessWidget {
  const SettingItem1(
      {super.key,
      required this.callback,
      required this.itemName,
      required this.initValue});

  final bool initValue;
  final String itemName;
  final Function(bool?) callback;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 1,
                child: Text(
                  itemName,
                  style: const TextStyle(inherit: false, color: Colors.black),
                )),
            Expanded(
                flex: 1,
                child: CupertinoSwitch(
                  value: initValue,
                  activeColor: CupertinoColors.activeBlue,
                  onChanged: (bool? value) {
                    callback(value);
                  },
                ))
          ],
        ));
  }
}

class SettingItem2 extends StatelessWidget {
  const SettingItem2(
      {super.key, required this.callback, required this.itemName});

  final String itemName;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        child: GestureDetector(
            onTap: () {
              callback();
            },
            child: Row(
              children: [
                Text(
                  itemName,
                  style: const TextStyle(
                      inherit: false, color: Colors.black, fontSize: 15),
                ),
              ],
            )));
  }
}
