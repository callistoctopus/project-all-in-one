/*
 * @Author: gui-qi
 * @Date: 2022-11-26 04:42:27
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-26 05:15:34
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'dart:async';

import 'package:client/data/dao/budget_dao.dart';
import 'package:client/data/model/budget.dart';

class BudgetAnalysisService {
  // TODO
  Future<double> getTodayTotalBudget() async {
    double ret = 0.0;
    Future<List<Budget>> budgetList = BudgetDao.fetchListBudgetFuture();
    await budgetList.then((value) {
      for (Budget budget in value) {
        if (budget.type == 0) {
          
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
