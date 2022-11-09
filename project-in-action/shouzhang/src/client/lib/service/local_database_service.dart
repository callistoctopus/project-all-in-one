/*
 * @Author: gui-qi
 * @Date: 2022-11-09 12:50:18
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-09 13:23:50
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
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DB {
  static Future init() async {
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
    await Hive.openBox(TABLE.setting);
    await Hive.openBox<FinancialReason>(TABLE.financialReason);
    await Hive.openBox<Budget>(TABLE.budget);
    await Hive.openBox<Bill>(TABLE.bill);
    await Hive.openBox<Account>(TABLE.account);
    await Hive.openBox<AccountUser>(TABLE.accountUser);
  }

  static String user() {
    return Hive.box(TABLE.setting).get(KEY.user, defaultValue: "");
  }

  static void setUser(String user) {
    Hive.box(TABLE.setting).put(KEY.user, user);
  }

  static bool isLogined() {
    return Hive.box(TABLE.setting).get(KEY.isLogined, defaultValue: false);
  }

  static void setLogined(bool isLogined) {
    Hive.box(TABLE.setting).put(KEY.isLogined, isLogined);
  }

  static bool isAutoLogin() {
    return Hive.box(TABLE.setting).get(KEY.isAutoLogin, defaultValue: false);
  }

  static void setAutoLogin(bool isAutoLogin) {
    Hive.box(TABLE.setting).put(KEY.isAutoLogin, isAutoLogin);
  }
}

class TABLE {
  static const String setting = 'setting';
  static const String financialReason = 'financialReason';
  static const String budget = 'budget';
  static const String bill = 'bill';
  static const String account = 'account';
  static const String accountUser = 'accountUser';
}

class KEY {
  static const String isLogined = 'isLogined';
  static const String isAutoLogin = 'isAutoLogin';
  static const String user = 'user';
  static const String lastSyncTime = 'lastSyncTime';
}
