/*
 * @Author: gui-qi
 * @Date: 2022-11-14 14:19:43
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-12-02 02:25:52
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/data/dao/account_user_dao.dart';
import 'package:client/data/dao/reason_dao.dart';
import 'package:client/data/db.dart';
import 'package:client/data/model/bill.dart';
import 'package:client/units/common_utils.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ConsumeDao {
  static Future<List<Bill>> futureListBill() async {
    List<Bill> list = [];
    List<String?> userList = AccountUserDao.getSharedUser();
    await Future(() => Hive.box<Bill>(TABLE.bill).values.forEach((element) {
          if (userList.contains(element.user) && element.isDeleted == 0) {
            list.add(element);
          }
        }));

    await Future(() => list.sort((a, b) => b.time.compareTo(a.time)));
    return list;
  }

  static Future<double> getTotalByYearAndReason(int year, String reason) async {
    double total = 0.0;
    List<String?> userList = AccountUserDao.getSharedUser();
    await Future(() => Hive.box<Bill>(TABLE.bill).values.forEach((element) {
          if (userList.contains(element.user) &&
              element.isDeleted == 0 &&
              element.time.year == year &&
              element.reason == reason) {
            total += element.amount;
          }
        }));

    return total;
  }

  static Future<List<double>> getTotalByYearAndCategory(int year) async {
    List<double> total = [0, 0, 0, 0, 0, 0, 0, 0];

    Map<String, int> reasonCategory = {};
    await ReasonDao.fetchReasonCategory().then((value) {
      reasonCategory = value;
      try {
        List<String?> userList = AccountUserDao.getSharedUser();
        List<Bill> bills = Hive.box<Bill>(TABLE.bill).values.toList();
        for (int i = 0; i < bills.length; i++) {
          if (userList.contains(bills[i].user) &&
              bills[i].isDeleted == 0 &&
              bills[i].time.year == year) {
            String reason = bills[i].reason;
            if (reason.isNotEmpty && reasonCategory.containsKey(reason)) {
              total[reasonCategory[reason]!] += bills[i].amount;
            }
          }
        }
      } catch (e) {
        print(e.toString());
      }

      double totol2 = 0.0;
      for (var element in total) {
        totol2 += element;
      }

      total = total
          .map((e) => CommonUtils.formatNum(e / totol2, 2)*100 as double)
          .toList();
    });

    return total;
  }
}
