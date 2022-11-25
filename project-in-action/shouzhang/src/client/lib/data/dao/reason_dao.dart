/*
 * @Author: gui-qi
 * @Date: 2022-11-14 14:23:27
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-25 10:17:53
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/data/dao/account_user_dao.dart';
import 'package:client/data/db.dart';
import 'package:client/data/model/financial_reason.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ReasonDao {
  static Future<List<FinancialReason>> fetchFinancialReason(int type) async {
    List<FinancialReason> list = [];
    List<String?> userList = AccountUserDao.getSharedUser();
    Hive.box<FinancialReason>(TABLE.financialReason).values.forEach((element) {
      if (element.type == type &&
          userList.contains(element.user) &&
          element.isDeleted == 0) {
        list.add(element);
      }
    });
    return list;
  }
}
