/*
 * @Author: gui-qi
 * @Date: 2022-10-29 01:37:32
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-24 14:34:43
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/page/data_model/global_do.dart';
import 'package:client/page/home/analysis.dart';
import 'package:client/page/home/asset.dart';
import 'package:client/page/home/budget.dart';
import 'package:client/page/home/consume.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  static final List<Widget> _widgetOptions = <Widget>[
    const ConsumePage(),
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
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
            child: _widgetOptions.elementAt(context.read<GlobalDO>().homePageIndes)),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
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
