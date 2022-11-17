/*
 * @Author: gui-qi
 * @Date: 2022-11-17 02:45:08
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-17 03:01:52
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'dart:async';

import 'package:client/dao/bill_dao.dart';
import 'package:client/model/bill.dart';
import 'package:client/units/common_utils.dart';

class AnalysisService {
  Future<double> getTodayTotalPay() async {
    double ret = 0.0;
    Future<List<Bill>> billList = BillDao.futureListBill();
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
}
