/*
 * @Author: gui-qi
 * @Date: 2022-11-09 12:50:18
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-25 08:06:58
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'dart:io';
import 'package:client/data/model/account.dart';
import 'package:client/data/model/account_user.dart';
import 'package:client/data/model/auto_create_config.dart';
import 'package:client/data/model/bill.dart';
import 'package:client/data/model/budget.dart';
import 'package:client/data/model/financial_reason.dart';
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

    try {
      Hive.registerAdapter(FinancialReasonAdapter());
      Hive.registerAdapter(BillAdapter());
      Hive.registerAdapter(BudgetAdapter());
      Hive.registerAdapter(AccountAdapter());
      Hive.registerAdapter(AccountUserAdapter());
      Hive.registerAdapter(AutoCreateConfigAdapter());
      await Hive.openBox(TABLE.setting);
      await Hive.openBox<FinancialReason>(TABLE.financialReason);
      await Hive.openBox<Budget>(TABLE.budget);
      await Hive.openBox<Bill>(TABLE.bill);
      await Hive.openBox<Account>(TABLE.account);
      await Hive.openBox<AccountUser>(TABLE.accountUser);
      await Hive.openBox<AutoCreateConfig>(TABLE.autoCreateConfig);
    } catch (e) {
      Hive.deleteFromDisk();
    }
  }

  static Future clear() async {
    await Hive.box(TABLE.setting).clear();
    await Hive.box<FinancialReason>(TABLE.financialReason).clear();
    await Hive.box<Budget>(TABLE.budget).clear();
    await Hive.box<Bill>(TABLE.bill).clear();
    await Hive.box<Account>(TABLE.account).clear();
    await Hive.box<AccountUser>(TABLE.accountUser).clear();
    return;
  }
}

class TABLE {
  static const String setting = 'setting';
  static const String financialReason = 'financialReason';
  static const String budget = 'budget';
  static const String bill = 'bill';
  static const String account = 'account';
  static const String accountUser = 'accountUser';
  static const String autoCreateConfig = 'autoCreateConfig';
}

class KEY {
  static const String isLogined = 'isLogined';
  static const String isAutoLogin = 'isAutoLogin';
  static const String user = 'user';
  static const String account = 'account';
  static const String accountUsers = 'accountUsers';
  static const String lastSyncTime = 'lastSyncTime';
  static const String budgetYear = 'budgetYear';
  static const String devMode = 'devMode';
  static const String offlineMode = 'offlineMode';
}
