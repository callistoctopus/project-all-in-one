/*
 * @Author: gui-qi
 * @Date: 2022-11-09 12:50:18
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-17 01:29:30
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'dart:io';

import 'package:client/model/account.dart';
import 'package:client/model/account_user.dart';
import 'package:client/model/bill.dart';
import 'package:client/model/budget.dart';
import 'package:client/model/financial_reason.dart';
import 'package:client/units/common_const.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DB {
  static Future init() async {
    if (TargetPlatform.linux == defaultTargetPlatform && !kIsWeb) {
      var path = Directory.current.path;
      Hive.init(path);
    } else {
      await Hive.initFlutter();
    }

    Hive.registerAdapter(FinancialReasonAdapter());
    Hive.registerAdapter(BillAdapter());
    Hive.registerAdapter(BudgetAdapter());
    Hive.registerAdapter(AccountAdapter());
    Hive.registerAdapter(AccountUserAdapter());
    await Hive.openBox(TABLE.setting);
    await Hive.openBox<FinancialReason>(TABLE.financialReason);
    await Hive.openBox<Budget>(TABLE.budget);
    await Hive.openBox<Bill>(TABLE.bill);
    await Hive.openBox<Account>(TABLE.account);
    await Hive.openBox<AccountUser>(TABLE.accountUser);
  }
}
