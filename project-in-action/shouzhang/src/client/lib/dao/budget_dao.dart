/*
 * @Author: gui-qi
 * @Date: 2022-11-14 14:25:28
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-14 14:35:34
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/dao/account_user_dao.dart';
import 'package:client/dao/setting_dao.dart';
import 'package:client/model/persistent_object/budget.dart';
import 'package:client/units/common_const.dart';
import 'package:client/units/common_utils.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

class BudgetDao{
  static Future<List<Budget>> fetchListBudget() async {
    List<Budget> list = [];
    List<String?> userList = AccountUserDao.getSharedUser();
    Hive.box<Budget>(TABLE.budget).values.forEach((element) {
      if (userList.contains(element.user)) {
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
}