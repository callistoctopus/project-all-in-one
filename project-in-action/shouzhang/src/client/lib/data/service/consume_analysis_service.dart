/*
 * @Author: gui-qi
 * @Date: 2022-11-26 04:42:27
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-12-01 01:04:43
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'dart:async';

import 'package:client/data/dao/consume_dao.dart';
import 'package:client/data/model/bill.dart';
import 'package:client/units/common_utils.dart';

class ConsumeAnalysisService {
  Future<double> getTodayTotalCunsume() async {
    double ret = 0.0;
    Future<List<Bill>> billList = ConsumeDao.futureListBill();
    await billList.then((value) {
      for (Bill bill in value) {
        if (bill.type == 0 &&
            bill.time.year == (CommonUtils.now().year) &&
            bill.time.month == (CommonUtils.now().month) &&
            bill.time.day == (CommonUtils.now().day)) {
          ret += bill.amount;
        }
      }
    });

    return ret;
  }

  Future<List<double>> getCurrentMonthEveryDayCunsume() async {
    List<double> ret = [];
    Future<List<Bill>> billList = ConsumeDao.futureListBill();
    for (int i = 0; i <= 30; i++) {
      ret.add(0.0);
    }

    await billList.then((value) {
      for (Bill bill in value) {
        if (bill.type == 0 &&
            bill.time.year == (CommonUtils.now().year) &&
            bill.time.month == (CommonUtils.now().month)) {
          ret[bill.time.day-1] += bill.amount;
        }
      }
    });

    return ret;
  }

  Future<List<double>> getLastWeekEveryDayCunsume() async {
    List<double> ret = [];
    Future<List<Bill>> billList = ConsumeDao.futureListBill();
    for (int i = 0; i <= 6; i++) {
      ret.add(0.0);
    }

    DateTime mon =
        CommonUtils.nowWithoutTime().add(Duration(days: -(CommonUtils.now().weekday - 1)));
    

    await billList.then((value) {
      for (Bill bill in value) {
        if (bill.type == 0 && bill.time.compareTo(mon) >= 0) {
          ret[bill.time.difference(mon).inDays] += bill.amount;
        }
      }
    });

    return ret;
  }
}
