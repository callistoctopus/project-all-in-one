/*
 * @Author: gui-qi
 * @Date: 2022-10-29 01:37:32
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-10-31 15:35:23
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
    Map<IconData, Function> para = {
      Icons.cancel: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddPage()));
      },
      Icons.arrow_back_ios: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddPage()));
      },
      Icons.add: () {
        showBottomSheet(context: context, builder: (context) => const SizedBox(height: 380, child: AddPage(),));
      }
    };

    return Scaffold(
      body: const HomePage(),
      floatingActionButton: FlowMenu(menuMap: para),
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
