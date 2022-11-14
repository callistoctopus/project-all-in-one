/*
 * @Author: gui-qi
 * @Date: 2022-10-29 01:37:32
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-14 14:36:41
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/component/custom_float_button.dart';
import 'package:client/config/route.dart';
import 'package:client/dao/setting_dao.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
        SettingItem1(
          initValue: SettingDao.isDev(),
          itemName: "开发者模式",
          callback: (bool? value) {
            setState(() {
              SettingDao.setDevMode(value ?? false);
            });
          },
        ),
        SettingItem2(
          callback: () {
            context.go(ROUTE.DEBUG);
          },
          itemName: '示例',
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
    return Row(
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
    );
  }
}

class SettingItem2 extends StatelessWidget {
  const SettingItem2(
      {super.key, required this.callback, required this.itemName});

  final String itemName;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          callback();
        },
        child: Row(
          children: [
            Text(
              itemName,
              style: const TextStyle(inherit: false, color: Colors.black),
            ),
          ],
        ));
  }
}
