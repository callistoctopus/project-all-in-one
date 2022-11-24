/*
 * @Author: gui-qi
 * @Date: 2022-11-09 12:54:29
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-24 15:02:21
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/dao/setting_dao.dart';
import 'package:client/develop/dev_sample_page.dart';
import 'package:client/page/data_edit/edit_budget_page.dart';
import 'package:client/page/data_edit/edit_target_page.dart';
import 'package:client/page/data_show/budget_list_page.dart';
import 'package:client/page/data_show/target_list_page.dart';
import 'package:client/page/home/setting.dart';
import 'package:client/page/data_edit/edit_account_page.dart';
import 'package:client/page/data_edit/edit_bill_page.dart';
import 'package:client/page/home_page.dart';
import 'package:client/page/data_show/bill_list_page.dart';
import 'package:client/page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouteConfig {
  static GoRouter routeConfig() {
    return GoRouter(
      routes: <GoRoute>[
        GoRoute(
          path: ROUTE.HOME,
          builder: (BuildContext context, GoRouterState state) {
            return Scaffold(body: HomePage());
          },
        ),
        GoRoute(
          path: ROUTE.LOGIN,
          builder: (BuildContext context, GoRouterState state) {
            if (SettingDao.isLogined() || SettingDao.isOfflineMode()) {
              return Scaffold(body: HomePage());
            }
            return Scaffold(body: LoginPage());
          },
        ),
        GoRoute(
          path: ROUTE.BILLS,
          builder: (BuildContext context, GoRouterState state) {
            return Scaffold(body: BillListPage());
          },
        ),
        GoRoute(
          path: ROUTE.BUDGET,
          builder: (BuildContext context, GoRouterState state) {
            return Scaffold(
                body: AddBudgetView(
                    editType: int.parse(state.queryParams["editType"] ?? "0")));
          },
        ),
        GoRoute(
          path: ROUTE.BUDGETS,
          builder: (BuildContext context, GoRouterState state) {
            return Scaffold(body: BudgetSettingPage());
          },
        ),
        GoRoute(
          path: ROUTE.TARGETS,
          builder: (BuildContext context, GoRouterState state) {
            return Scaffold(body: TargetListPage());
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
            return const DevSamplePage();
          },
        ),
        // GoRoute(
        //   path: ROUTE.SETTING,
        //   builder: (BuildContext context, GoRouterState state) {
        //     return const SettingPage();
        //   },
        // ),
        GoRoute(
          path: ROUTE.BILL,
          builder: (BuildContext context, GoRouterState state) {
            return AddBillView(
                editType: int.parse(state.queryParams["editType"] ?? "0"));
          },
        ),
        GoRoute(
          path: ROUTE.TARGET,
          builder: (BuildContext context, GoRouterState state) {
            return EditTargetPage(
                editType: int.parse(state.queryParams["editType"] ?? "0"));
          },
        ),
      ],
      redirect: (context, state) {
        if (SettingDao.isLogined() || SettingDao.isOfflineMode()) {
          return null;
        }
        return ROUTE.LOGIN;
      },
    );
  }
}

class ROUTE {
  static const String HOME = '/';
  static const String LOGIN = '/login';
  static const String ACCOUNT = '/account';

  static const String BILLS = '/bills';
  static const String BILL = '/bill';
  static const String ADD_BILL = '$BILL?editType=0';
  static const String EDIT_BILL = '$BILL?editType=1';

  // static const String ADD_REASON = '/add_reason';
  static const String BUDGETS = '/budgets';
  static const String BUDGET = '/budget';
  static const String ADD_BUDGET = '$BUDGET?editType=0';
  static const String EDIT_BUDGET = '$BUDGET?editType=1';

  static const String TARGETS = '/targets';
  static const String TARGET = '/target';
  static const String ADD_TARGET = '$TARGET?editType=0';
  static const String EDIT_TARGET = '$TARGET?editType=1';

  static const String DEBUG = '/debug';
  // static const String SETTING = '/setting';
}
