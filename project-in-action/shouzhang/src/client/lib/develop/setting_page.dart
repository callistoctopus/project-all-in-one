/*
 * @Author: gui-qi
 * @Date: 2022-10-29 01:37:32
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-12 13:08:08
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/component/custom_float_button.dart';
import 'package:client/develop/AnimatedListPage.dart';
import 'package:client/develop/absorb_pointer_page.dart';
import 'package:client/develop/dismissible_page.dart';
import 'package:client/develop/wrap_page.dart';
import 'package:client/service/local_database_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'ink_well_page.dart';

class DevelopmentPage extends StatefulWidget {
  const DevelopmentPage({super.key});

  @override
  State<DevelopmentPage> createState() => _DevelopmentPageState();
}

class _DevelopmentPageState extends State<DevelopmentPage> {
  @override
  Widget build(BuildContext context) {
    Map<String, void Function()?> para2 = {
      'WarpPage': () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const WarpPage()));
      },
      'InkWellPage': () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const InkWellPage()));
      },
      'DismissiblePage': () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const DismissiblePage()));
      },
      'AbsorbPointerPage': () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AbsorbPointerPage()));
      },
      'AnimatedListPage': () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AnimatedListSample()));
      },
    };

    return PageWithFloatButton(
        child: Column(
      children: [
        SettingItem(
          initValue: DB.isDev(),
          itemName: "开发者模式",
          callback: (bool? value) {
            setState(() {
              DB.setDevMode(value ?? false);
            });
          },
        ),
        // ListView(
        //     children: para2.keys
        //         .map<Widget>((name) => Padding(
        //             padding: const EdgeInsets.only(
        //                 left: 16, top: 15, right: 16, bottom: 0),
        //             child: GestureDetector(
        //                 onTap: para2[name],
        //                 child: Text(
        //                   name,
        //                   style: TextStyle(fontSize: 18),
        //                 ))))
        //         .toList())
      ],
    ));
  }
}

class Dev {
  static Widget onDevelop(Widget child) {
    if (DB.isDev()) {
      return child;
    }
    return const SizedBox(
      height: 0,
    );
  }
}

class SettingItem extends StatelessWidget {
  const SettingItem(
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
