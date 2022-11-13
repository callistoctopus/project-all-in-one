/*
 * @Author: gui-qi
 * @Date: 2022-11-09 12:50:18
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-13 04:07:46
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
import 'package:client/units/common_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

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

  static String currentUser() {
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

  static Future<List<Bill>> futureListBill() async {
    List<Bill> list = [];
    List<String?> userList = DB.getSharedUser();
    Hive.box<Bill>(TABLE.bill).values.forEach((element) {
      if (userList.contains(element.user)) {
        list.add(element);
      }
    });

    return list;
  }

  static bool saveBill(Bill bill) {
    bill.user = DB.currentUser();
    bill.time = CommonUtils.now();
    bill.updateTime = CommonUtils.now();
    if (bill.isInBox) {
      bill.save();
    } else {
      bill.id = const Uuid().v1();
      Hive.box<Bill>(TABLE.bill).add(bill);
    }
    return true;
  }

  static bool saveAccountUser(AccountUser accountUser) {
    accountUser.updateTime = CommonUtils.now();
    if (accountUser.isInBox) {
      accountUser.save();
    } else {
      Hive.box<AccountUser>(TABLE.accountUser).add(accountUser);
    }
    return true;
  }

  static Future<List<Budget>> fetchListBudget() async {
    List<Budget> list = [];
    List<String?> userList = DB.getSharedUser();
    Hive.box<Budget>(TABLE.budget).values.forEach((element) {
      if (userList.contains(element.user)) {
        list.add(element);
      }
    });

    return list;
  }

  static Future<bool> saveListBudget(List<Budget> budgetList) async {
    for (var element in budgetList) {
      element.user = DB.currentUser();
      element.updateTime = CommonUtils.now();
      if (element.isInBox) {
        element.save();
      } else {
        element.id = const Uuid().v1();
        Hive.box<Budget>(TABLE.budget).add(element);
      }
    }

    return true;
  }

  static Future<bool> saveFinancialReason(FinancialReason fr) async {
    fr.user = DB.currentUser();
    fr.updateTime = CommonUtils.now();
    if (fr.isInBox) {
      fr.save();
    } else {
      fr.id = const Uuid().v1();
      Hive.box<FinancialReason>(TABLE.financialReason).add(fr);
    }
    return true;
  }

  static Future<List<FinancialReason>> fetchFinancialReasonOut() async {
    List<FinancialReason> list = [];

    List<String?> userList = DB.getSharedUser();
    Hive.box<FinancialReason>(TABLE.financialReason).values.forEach((element) {
      if (element.type == 0 && userList.contains(element.user)) {
        list.add(element);
      }
    });
    return list;
  }

  static Future<List<FinancialReason>> fetchFinancialReasonIn() async {
    List<FinancialReason> list = [];
    List<String?> userList = DB.getSharedUser();
    Hive.box<FinancialReason>(TABLE.financialReason).values.forEach((element) {
      if (element.type == 1 && userList.contains(element.user)) {
        list.add(element);
      }
    });
    return list;
  }

  static void setAccount(String account) {
    Hive.box(TABLE.setting).put(KEY.account, account);
  }

  static String currentAccount() {
    return Hive.box(TABLE.setting).get(KEY.account, defaultValue: "");
  }

  static List<Account> allAccounts() {
    List<Account> accounts = [];
    Hive.box<Account>(TABLE.account).values.forEach((element) {
      if (element.user == DB.currentUser()) accounts.add(element);
    });
    return accounts;
  }

  // static List<AccountUser> accountUsers() {
  //   List<AccountUser> list = [];
  //   Hive.box<AccountUser>(TABLE.accountUser).values.forEach((element) {
  //     if (element.user == DB.currentUser() || element.account == DB.currentAccount()) {
  //       list.add(element);
  //     }
  //   });
  //   return list;
  // }

  static List<String> getSharedUser() {
    List<String> ret = [];
    var box = Hive.box<AccountUser>(TABLE.accountUser);
    box.values.forEach((element) {
      // if (element.account == DB.currentAccount()) ret.add(element.user);
      if (element.user == DB.currentUser()) {
        box.values.forEach((element1) {
          if (element.account == element1.account) {
            ret.add(element1.user);
          }
        });
      }
    });
    return ret;
  }

  static List<AccountUser> getSharedAccountUser() {
    List<AccountUser> ret = [];
    var box = Hive.box<AccountUser>(TABLE.accountUser);
    for (var element in box.values) {
      // if (element.account == DB.currentAccount()) ret.add(element.user);
      if (element.user == DB.currentUser()) {
        for (var element1 in box.values) {
          if (element.account == element1.account) {
            ret.add(element1);
          }
        }
      }
    }
    return ret;
  }

  static int budgetYear() {
    return Hive.box(TABLE.setting).get(KEY.budgetYear, defaultValue: 2022);
  }

  static void setBudgetYear(int year) {
    Hive.box(TABLE.setting).put(KEY.budgetYear, year);
  }

  static bool isDev() {
    return Hive.box(TABLE.setting).get(KEY.devMode, defaultValue: false);
  }

  static void setDevMode(bool isDev) {
    Hive.box(TABLE.setting).put(KEY.devMode, isDev);
  }

  static void setOfflineMode(bool mode){
    Hive.box(TABLE.setting).put(KEY.offlineMode, mode);
  }

  static bool isOfflineMode(){
    return Hive.box(TABLE.setting).get(KEY.offlineMode, defaultValue: false);
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
  static const String account = 'account';
  static const String accountUsers = 'accountUsers';
  static const String lastSyncTime = 'lastSyncTime';
  static const String budgetYear = 'budgetYear';
  static const String devMode = 'devMode';
  static const String offlineMode = 'offlineMode';
}
