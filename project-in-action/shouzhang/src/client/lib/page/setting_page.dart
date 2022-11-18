/*
 * @Author: gui-qi
 * @Date: 2022-10-29 01:37:32
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-18 06:59:21
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/component/custom_float_button.dart';
import 'package:client/config/route.dart';
import 'package:client/dao/setting_dao.dart';
import 'package:client/service/local_database_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return PageWithFloatButton(
        child: Column(
      children: [
        SettingItem2(
          callback: () {
            context.go(ROUTE.ACCOUNT);
          },
          itemName: '账号',
        ),
        const Divider(
          color: Colors.grey,
          thickness: 0,
          indent: 20,
          endIndent: 20,
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
          indent: 20,
          endIndent: 20,
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
          indent: 20,
          endIndent: 20,
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
          indent: 20,
          endIndent: 20,
          height: 1,
        ),
        SettingItem2(
          callback: () {
            DB.clear();
            context.go(ROUTE.LOGIN);
          },
          itemName: '恢复出厂设置',
        ),
        const Divider(
          color: Colors.grey,
          thickness: 0,
          indent: 20,
          endIndent: 20,
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
          indent: 20,
          endIndent: 20,
          height: 1,
        ),
      ],
    ));
  }
}

class Dev {
  static Widget onDevelop(Widget child) {
    if (SettingDao.isDev()) {
      return child;
    }
    return const SizedBox(
      height: 0,
    );
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
    return Container(
        padding: const EdgeInsets.only(left: 20),
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
                  // This bool value toggles the switch.
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
    return Container(
        padding: const EdgeInsets.only(left: 23),
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
