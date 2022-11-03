/*
 * @Author: gui-qi
 * @Date: 2022-10-29 01:37:32
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-02 15:49:31
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/component/custom_float_button.dart';
import 'package:client/develop/absorb_pointer_page.dart';
import 'package:client/develop/dismissible_page.dart';
import 'package:client/develop/warp_page.dart';
import 'package:flutter/material.dart';

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
    };

    return PageWithFloatButton(
      child: ListView(
          children: para2.keys
              .map<Widget>((name) => Padding(
                  padding: const EdgeInsets.only(
                      left: 16, top: 15, right: 16, bottom: 0),
                  child:
                      GestureDetector(onTap: para2[name], child: Text(name))))
              .toList()),
    );
  }
}
