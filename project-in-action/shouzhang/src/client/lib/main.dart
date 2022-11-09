/*
 * @Author: gui-qi
 * @Date: 2022-10-26 08:18:13
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-09 12:41:07
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */

import 'dart:io';

import 'package:client/model/persistent_object/account.dart';
import 'package:client/model/persistent_object/account_user.dart';
import 'package:client/model/persistent_object/bill.dart';
import 'package:client/model/persistent_object/budget.dart';
import 'package:client/model/persistent_object/financial_reason.dart';
import 'package:client/model/runtime_object/auth_do.dart';
import 'package:client/page/account_page.dart';
import 'package:client/page/bill_flow_page.dart';
import 'package:client/page/budget_page.dart';
import 'package:client/page/login_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'page/anaysis_page.dart';

Future<void> main() async {
  if (TargetPlatform.linux == defaultTargetPlatform && !kIsWeb) {
    var path = Directory.current.path;
    Hive.init(path);
  } else {
    await Hive.initFlutter();
  }
  
  Hive.registerAdapter(FinancialReasonAdapter());
  Hive.registerAdapter(BillAdapter());
  Hive.registerAdapter(BudgetAdapter());
  Hive.registerAdapter(AccountAdapter());
  Hive.registerAdapter(AccountUserAdapter());
  await Hive.openBox('setting');
  await Hive.openBox<FinancialReason>('financialReason');
  await Hive.openBox<Budget>('budget');
  await Hive.openBox<Bill>('bill');
  await Hive.openBox<Account>('account');
  await Hive.openBox<AccountUser>('accountUser');

  AuthDO.refresh();

  final GoRouter router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const Scaffold(body: AnaysisPage());
        },
      ),
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return Scaffold(body: LoginPage());
        },
      ),
      GoRoute(
        path: '/billList',
        builder: (BuildContext context, GoRouterState state) {
          return const CashFlowPage();
        },
      ),
      GoRoute(
        path: '/budget',
        builder: (BuildContext context, GoRouterState state) {
          return Scaffold(body: BudgetSettingPage());
        },
      ),
      GoRoute(
        path: '/account',
        builder: (BuildContext context, GoRouterState state) {
          return Scaffold(body: AccountPage());
        },
      ),
    ],
    redirect: (context, state) {
      var settingBox = Hive.box('setting');
      bool isLogined = settingBox.get('isLogined', defaultValue: false);
      if (isLogined) {
        return null;
      }
      return '/login';
    },
  );

  runApp(MaterialApp.router(
    theme: ThemeData(
      colorSchemeSeed: const Color.fromARGB(255, 192, 189, 35),
      useMaterial3: true,
      visualDensity: VisualDensity.standard,
    ),
    routerConfig: router,
    // initialRoute: initRoute,
    // routes: {
    //   '/login': (context) => Scaffold(body:LoginPage()),
    //   '/home': (context) => const Scaffold(body: AnaysisPage()),
    //   "/billList": (context) => const CashFlowPage(),
    //   '/budget': (context) => Scaffold(body: BudgetSettingPage()),
    // },
  ));

  // runApp(MaterialApp(
  //   theme: ThemeData(
  //     colorSchemeSeed: const Color.fromARGB(255, 192, 189, 35),
  //     useMaterial3: true,
  //     visualDensity: VisualDensity.standard,
  //   ),
  //   // routerConfig: _router,
  //   initialRoute: '/login',
  //   routes: {
  //     '/login': (context) => Scaffold(body:LoginPage()),
  //     '/home': (context) => const Scaffold(body: AnaysisPage()),
  //     "/billList": (context) => const CashFlowPage(),
  //     '/budget': (context) => Scaffold(body: BudgetSettingPage()),
  //   },
  // ));

  // runApp(MaterialApp(
  //   theme: ThemeData(
  //     colorSchemeSeed: const Color.fromARGB(255, 192, 189, 35),
  //     useMaterial3: true,
  //     visualDensity: VisualDensity.standard,
  //   ),
  //   // routerConfig: _router,
  //   home: const Scaffold(body: AnaysisPage()),
  // ));
}
