/*
 * @Author: gui-qi
 * @Date: 2022-11-09 12:54:29
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-13 06:35:13
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/develop/dev_sample_page.dart';
import 'package:client/develop/setting_page.dart';
import 'package:client/page/account_page.dart';
import 'package:client/page/home_page.dart';
import 'package:client/page/bill_flow_page.dart';
import 'package:client/page/budget_page.dart';
import 'package:client/page/login_page.dart';
import 'package:client/service/local_database_service.dart';
import 'package:client/units/common_const.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouteConfig {
  static GoRouter routeConfig() {
    return GoRouter(
      routes: <GoRoute>[
        GoRoute(
          path: ROUTE.HOME,
          builder: (BuildContext context, GoRouterState state) {
            return const Scaffold(body: HomePage());
          },
        ),
        GoRoute(
          path: ROUTE.LOGIN,
          builder: (BuildContext context, GoRouterState state) {
            return Scaffold(body: LoginPage());
          },
        ),
        GoRoute(
          path: ROUTE.BILLS,
          builder: (BuildContext context, GoRouterState state) {
            return const Scaffold(body: CashFlowPage());
          },
        ),
        GoRoute(
          path: ROUTE.BUDGET,
          builder: (BuildContext context, GoRouterState state) {
            return Scaffold(body: BudgetSettingPage());
          },
        ),
        GoRoute(
          path: ROUTE.ACCOUNT,
          builder: (BuildContext context, GoRouterState state) {
            return const Scaffold(body: AccountPage());
          },
        ),
        GoRoute(
          path: ROUTE.DEBUG,
          builder: (BuildContext context, GoRouterState state) {
            return DevSamplePage();
          },
        ),
        GoRoute(
          path: ROUTE.SETTING,
          builder: (BuildContext context, GoRouterState state) {
            return const SettingPage();
          },
        ),
      ],
      redirect: (context, state) {
        if (DB.isLogined() || DB.isOfflineMode()) {
          return null;
        }
        return ROUTE.LOGIN;
      },
    );
  }
}

class ROUTE {
  static const String HOME = '/';
  static const String BILLS = '/bills';
  static const String ADD_BILL = '/add_bill';
  static const String ADD_REASON = '/add_reason';
  static const String LOGIN = '/login';
  static const String BUDGET = '/budget';
  static const String ACCOUNT = '/account';
  static const String DEBUG = '/debig';
  static const String SETTING = '/setting';
}
