/*
 * @Author: gui-qi
 * @Date: 2022-11-14 14:23:27
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-12-01 14:38:16
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/data/dao/account_user_dao.dart';
import 'package:client/data/dao/setting_dao.dart';
import 'package:client/data/db.dart';
import 'package:client/data/model/financial_reason.dart';
import 'package:client/units/common_utils.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

class ReasonDao {
  static Future<List<FinancialReason>> fetchFinancialReason(int type) async {
    List<FinancialReason> list = [];
    List<String?> userList = AccountUserDao.getSharedUser();
    Future(() => Hive.box<FinancialReason>(TABLE.financialReason)
            .values
            .forEach((element) {
          if (element.type == type &&
              userList.contains(element.user) &&
              element.isDeleted == 0) {
            list.add(element);
          }
        }));
    return list;
  }

  // static bool upsert(FinancialReason obj) {
  //   obj.user = SettingDao.currentUser();
  //   obj.updateTime = CommonUtils.now();
  //   if (obj.isInBox) {
  //     obj.save();
  //   } else {
  //     obj.id = const Uuid().v1();
  //     Hive.box<FinancialReason>(TABLE.financialReason).add(obj);
  //   }
  //   return true;
  // }

  static Future<Map<String, int>> fetchReasonCategory() async {
    Map<String, int> map = {};
    List<String?> userList = AccountUserDao.getSharedUser();
    await Future(() => Hive.box<FinancialReason>(TABLE.financialReason)
            .values
            .forEach((element) {
          if (userList.contains(element.user) && element.isDeleted == 0) {
            map[element.reason] = element.category;
          }
        }));
    return map;
  }
}
