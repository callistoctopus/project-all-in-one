/*
 * @Author: gui-qi
 * @Date: 2022-10-29 01:37:32
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-10-31 09:00:53
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:flutter/material.dart';

import 'add.dart';
import 'component/flow.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomePage(),
      floatingActionButton: 

      FlowMenu(),

      // FloatingActionButton(
      //   onPressed: () {
      //     showBottomSheet(
      //         shape: const OutlineInputBorder(),
      //         context: context,
      //         builder: (BuildContext context) => Container(
      //               height: 380, //这里调整高度即可，建议按照屏幕高度比例来计算
      //               decoration: const BoxDecoration(
      //                 borderRadius: BorderRadius.only(
      //                     topLeft: Radius.circular(60),
      //                     topRight: Radius.circular(60)),
      //               ),
      //               child: const AddPage(),
      //             ));
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '消费预测，建议，警告',
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
