/*
 * @Author: gui-qi
 * @Date: 2022-11-17 02:45:08
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-25 08:09:18
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'dart:async';

import 'package:client/data/dao/bill_dao.dart';
import 'package:client/data/dao/budget_dao.dart';
import 'package:client/data/model/bill.dart';
import 'package:client/data/model/budget.dart';
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

  double getTodayTotalPay2()  {
    double ret = 0.0;
    Future<List<Bill>> billList = BillDao.futureListBill();
    billList.then((value) {
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

  Future<double> getYearTotalOutBudget() async {
    double ret = 0.0;
    Future<List<Budget>> budgetList = BudgetDao.fetchListBudgetFuture();
    await budgetList.then((value) {
      for (Budget budget in value) {
        if (budget.type == 0) {
          ret += budget.budget;
        }
      }
    });

    return ret;
  }

  Future<double> getYearTotalInBudget() async {
    double ret = 0.0;
    Future<List<Budget>> budgetList = BudgetDao.fetchListBudgetFuture();
    await budgetList.then((value) {
      for (Budget budget in value) {
        if (budget.type == 1) {
          ret += budget.budget;
        }
      }
    });

    return ret;
  }
}
