/*
 * @Author: gui-qi
 * @Date: 2022-11-14 14:23:27
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-17 01:30:22
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/dao/account_user_dao.dart';
import 'package:client/dao/setting_dao.dart';
import 'package:client/model/financial_reason.dart';
import 'package:client/units/common_const.dart';
import 'package:client/units/common_utils.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

class ReasonDao {
  static Future<bool> saveFinancialReason(FinancialReason fr) async {
    fr.user = SettingDao.currentUser();
    fr.updateTime = CommonUtils.now();
    if (fr.isInBox) {
      fr.save();
    } else {
      fr.id = const Uuid().v1();
      Hive.box<FinancialReason>(TABLE.financialReason).add(fr);
    }
    return true;
  }

  static Future<bool> updateFinancialReason(FinancialReason fr) async {
    if (fr.isInBox) {
      fr.save();
    }
    return true;
  }

  static Future<bool> deleteFinancialReason(FinancialReason fr) async {
    fr.isDeleted = 1;
    if (fr.isInBox) {
      fr.save();
    }
    return true;
  }

  static Future<List<FinancialReason>> fetchFinancialReasonOut() async {
    List<FinancialReason> list = [];

    List<String?> userList = AccountUserDao.getSharedUser();
    Hive.box<FinancialReason>(TABLE.financialReason).values.forEach((element) {
      if (element.type == 0 &&
          userList.contains(element.user) &&
          element.isDeleted == 0) {
        list.add(element);
      }
    });
    return list;
  }

  static Future<List<FinancialReason>> fetchFinancialReasonIn() async {
    List<FinancialReason> list = [];
    List<String?> userList = AccountUserDao.getSharedUser();
    Hive.box<FinancialReason>(TABLE.financialReason).values.forEach((element) {
      if (element.type == 1 &&
          userList.contains(element.user) &&
          element.isDeleted == 0) {
        list.add(element);
      }
    });
    return list;
  }
}
