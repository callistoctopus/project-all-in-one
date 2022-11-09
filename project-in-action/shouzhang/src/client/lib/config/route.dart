/*
 * @Author: gui-qi
 * @Date: 2022-11-09 12:54:29
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-09 13:16:05
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
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouteConfig {
  static GoRouter routeConfig() {
    return GoRouter(
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
            return const Scaffold(body: AccountPage());
          },
        ),
      ],
      redirect: (context, state) {
        if (DB.isLogined()) {
          return null;
        }
        return '/login';
      },
    );
  }
}
