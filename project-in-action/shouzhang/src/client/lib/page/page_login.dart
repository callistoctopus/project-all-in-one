/*
 * @Author: gui-qi
 * @Date: 2022-10-29 01:37:32
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-12-12 06:41:46
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/data/listenable/global_do.dart';
import 'package:client/page/view/home/view_home_analysis.dart';
import 'package:client/page/view/home/view_home_asset.dart';
import 'package:client/page/view/home/view_home_budget.dart';
import 'package:client/page/view/home/view_home_consume.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageHome extends StatefulWidget {
  const PageHome({super.key});

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  static final List<Widget> _widgetOptions = <Widget>[
    const ViewConsume(),
    const BudgetPage(),
    const AssetsPage(),
    const AnalysisPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      context.read<GlobalDO>().homePageIndes = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child:
              _widgetOptions.elementAt(context.read<GlobalDO>().homePageIndes)),
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: const Color(0xFFe2e7bf),
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '收支',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: '预算与目标',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: '资产',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: '我的',
          ),
        ],
        currentIndex: context.read<GlobalDO>().homePageIndes,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black45,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
    );
  }
}
