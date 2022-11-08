/*
 * @Author: gui-qi
 * @Date: 2022-10-26 08:18:13
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-08 05:43:30
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */

import 'dart:io';

import 'package:client/model/persistent_object/bill.dart';
import 'package:client/model/persistent_object/budget.dart';
import 'package:client/model/persistent_object/financial_reason.dart';
import 'package:client/model/runtime_object/auth_do.dart';
import 'package:client/page/bill_flow_page.dart';
import 'package:client/page/budget_page.dart';
import 'package:client/page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'page/anaysis_page.dart';

Future<void> main() async {
  var path = Directory.current.path;
  Hive.init(path);
  Hive.openBox('setting');
  Hive.registerAdapter(FinancialReasonAdapter());
  Hive.registerAdapter(BillAdapter());
  Hive.registerAdapter(BudgetAdapter());
  await Hive.openBox<FinancialReason>('financialReason');
  await Hive.openBox<Budget>('budget');
  await Hive.openBox<Bill>('bill');
  
  AuthDO.refresh();
  var initRoute = "/login";
  if (AuthDO.isAutoLogin && AuthDO.isLogined) {
    initRoute = '/home';
  }

  runApp(MaterialApp(
    theme: ThemeData(
      colorSchemeSeed: const Color.fromARGB(255, 192, 189, 35),
      useMaterial3: true,
      visualDensity: VisualDensity.standard,
    ),
    initialRoute: initRoute,
    routes: {
      '/login': (context) => Scaffold(body:LoginPage()),
      '/home': (context) => const Scaffold(body: AnaysisPage()),
      "/billList": (context) => const CashFlowPage(),
      '/budget': (context) => Scaffold(body: BudgetSettingPage()),
    },
  ));
}
