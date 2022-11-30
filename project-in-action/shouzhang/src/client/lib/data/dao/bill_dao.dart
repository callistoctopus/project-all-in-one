/*
 * @Author: gui-qi
 * @Date: 2022-11-14 14:19:43
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-30 14:07:39
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/data/dao/account_user_dao.dart';
import 'package:client/data/db.dart';
import 'package:client/data/model/bill.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ConsumeDao{
  static Future<List<Bill>> futureListBill() async {

    List<Bill> list = [];
    List<String?> userList = AccountUserDao.getSharedUser();
    await Future(() => Hive.box<Bill>(TABLE.bill).values.forEach((element) {
      if (userList.contains(element.user) && element.isDeleted == 0) {
        list.add(element);
      }
    }));
    
    await Future(() => list.sort((a,b)=>b.time.compareTo(a.time)));
    return list;
  }

  static Future<double> getTotalByYearAndReason(int year, String reason) async{
    double total = 0.0;
    List<String?> userList = AccountUserDao.getSharedUser();
    await Future(() => Hive.box<Bill>(TABLE.bill).values.forEach((element) {
      if (userList.contains(element.user) && element.isDeleted == 0 && element.time.year == year && element.reason == reason) {
        total += element.amount;
      }
    }));
    
    return total;
  }
}