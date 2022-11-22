/*
 * @Author: gui-qi
 * @Date: 2022-10-29 01:37:32
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-22 05:39:45
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/page/analysis/grade.dart';
import 'package:client/page/component/common_component.dart';
import 'package:client/service/server_data_access_service.dart';
import 'package:client/units/common_utils.dart';
import 'package:flutter/material.dart';

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
    DataAccessService.syncData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          children: <Widget>[
            SizedBox(height: 25,child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(CommonUtils.now().toString().substring(0, 10)),
                // GestureDetector(
                //   onTap: () {
                //     context.go(ROUTE.SETTING);
                //   },
                //   child: const SizedBox(
                //     child: Icon(Icons.settings),
                //   ),
                // )
                PopupMenuButton<Menu>(
                  padding: const EdgeInsets.all(1),
                    iconSize: 14,
                    onSelected: (Menu item) {
                      setState(() {
                        // _selectedMenu = item.name;
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
            COMMON_COMPONENT.chart("评分", "", () {}, Grade(), height: 125),
            const Divider(
              color: Colors.grey,
              thickness: 0,
              height: 1,
            ),
            COMMON_COMPONENT.chart("消息", "更多", () {}, const SizedBox(),
                height: 80),
            const Divider(
              color: Colors.grey,
              thickness: 0,
              height: 1,
            ),
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
