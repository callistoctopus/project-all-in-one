/*
 * @Author: gui-qi
 * @Date: 2022-11-14 14:25:28
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-12-12 22:10:01
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/data/dao/account_user_dao.dart';
import 'package:client/data/dao/setting_dao.dart';
import 'package:client/data/db.dart';
import 'package:client/data/model/budget.dart';
import 'package:client/units/common_utils.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

class BudgetDao {
  static List<Budget> fetchListBudget() {
    List<Budget> list = [];
    List<String?> userList = AccountUserDao.getSharedUser();
    Hive.box<Budget>(TABLE.budget).values.forEach((element) {
      if (userList.contains(element.user) &&
          element.year == SettingDao.budgetYear().toString() &&
          element.isDeleted == 0) {
        list.add(element);
      }
    });

    return list;
  }

  static Future<List<Budget>> fetchListBudgetFuture() async {
    List<Budget> list = [];
    List<String?> userList = AccountUserDao.getSharedUser();
    Hive.box<Budget>(TABLE.budget).values.forEach((element) {
      if (userList.contains(element.user) &&
          element.year == SettingDao.budgetYear().toString() &&
          element.isDeleted == 0) {
        list.add(element);
      }
    });

    return list;
  }

  static Future<bool> saveListBudget(List<Budget> budgetList) async {
    for (var element in budgetList) {
      element.user = SettingDao.currentUser();
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

  static Future<double> getTodayBudget() async {
    double todayTotalBudget = 0.0;
    List<String?> userList = AccountUserDao.getSharedUser();
    Hive.box<Budget>(TABLE.budget).values.forEach((element) {
      if (userList.contains(element.user) &&
          element.year == SettingDao.budgetYear().toString() &&
          element.isDeleted == 0) {
        double todayBudget = 0.0;
        if (element.duration == 0) {
          todayBudget = element.budget / 356;
        }
        todayTotalBudget += todayBudget;
      }
    });

    return todayTotalBudget;
  }

  static Future<double> getCurrentMonthBudget() async {
    double todayTotalBudget = 0.0;
    List<String?> userList = AccountUserDao.getSharedUser();
    Hive.box<Budget>(TABLE.budget).values.forEach((element) {
      if (userList.contains(element.user) &&
          element.year == SettingDao.budgetYear().toString() &&
          element.isDeleted == 0) {
        double todayBudget = 0.0;
        if (element.duration == 0) {
          todayBudget = element.budget / 12;
        }
        todayTotalBudget += todayBudget;
      }
    });

    return todayTotalBudget;
  }

  static Future<double> getCurrentYearBudget() async {
    double todayTotalBudget = 0.0;
    List<String?> userList = AccountUserDao.getSharedUser();
    Hive.box<Budget>(TABLE.budget).values.forEach((element) {
      if (userList.contains(element.user) &&
          element.year == SettingDao.budgetYear().toString() &&
          element.isDeleted == 0) {
        double todayBudget = 0.0;
        if (element.duration == 0) {
          todayBudget = element.budget ;
        }
        todayTotalBudget += todayBudget;
      }
    });

    return todayTotalBudget;
  }
}
