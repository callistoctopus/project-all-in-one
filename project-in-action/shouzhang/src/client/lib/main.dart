/*
 * @Author: gui-qi
 * @Date: 2022-10-26 08:18:13
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-06 16:14:46
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */

import 'dart:io';

import 'package:client/model/bill.dart';
import 'package:client/model/budget.dart';
import 'package:client/model/financial_reason.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'page/anaysis_page.dart';

Future<void> main() async {
  var path = Directory.current.path;
  Hive.init(path);
  Hive.registerAdapter(FinancialReasonAdapter());
  Hive.registerAdapter(BillAdapter());
  Hive.registerAdapter(BudgetAdapter());
  await Hive.openBox<FinancialReason>('financialReason');
  await Hive.openBox<Budget>('budget');
  await Hive.openBox<Bill>('bill');
  await Hive.openBox('setting');

  runApp(MaterialApp(
    theme: ThemeData(
      colorSchemeSeed: const Color.fromARGB(255, 192, 189, 35),
      useMaterial3: true,
      visualDensity: VisualDensity.standard,
    ),
    home: const Scaffold(body: AnaysisPage()),
  ));
}
