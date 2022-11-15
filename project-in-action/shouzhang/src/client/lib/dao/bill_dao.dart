/*
 * @Author: gui-qi
 * @Date: 2022-11-14 14:19:43
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-15 00:48:20
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/dao/account_user_dao.dart';
import 'package:client/dao/setting_dao.dart';
import 'package:client/model/persistent_object/bill.dart';
import 'package:client/units/common_const.dart';
import 'package:client/units/common_utils.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

class BillDao{
  static Future<List<Bill>> futureListBill() async {
    List<Bill> list = [];
    List<String?> userList = AccountUserDao.getSharedUser();
    Hive.box<Bill>(TABLE.bill).values.forEach((element) {
      if (userList.contains(element.user) && element.isDeleted == 0) {
        list.add(element);
      }
    });

    return list;
  }

  static bool saveBill(Bill bill) {
    bill.user = SettingDao.currentUser();
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

  static bool deleteBill(Bill bill) {
    bill.isDeleted = 1;
    bill.updateTime = CommonUtils.now();
    if (bill.isInBox) {
      bill.save();
    } 
    return true;
  }
}