/*
 * @Author: gui-qi
 * @Date: 2022-11-09 12:54:29
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-10 01:29:29
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/page/account_page.dart';
import 'package:client/page/anaysis_page.dart';
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
            return const Scaffold(body: AnaysisPage());
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
            return const CashFlowPage();
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
      ],
      redirect: (context, state) {
        if (DB.isLogined()) {
          return null;
        }
        return ROUTE.LOGIN;
      },
    );
  }
}
