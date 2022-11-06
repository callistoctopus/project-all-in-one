/*
 * @Author: gui-qi
 * @Date: 2022-11-04 02:15:05
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-06 16:51:09
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'dart:convert';
import 'dart:ffi';
import 'dart:math';
import 'package:client/model/budget.dart';
import 'package:client/model/bill.dart';
import 'package:client/model/financial_reason.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class DataAccessService {
  static Future<bool> syncData() async {

    var box = Hive.box("setting");
    List<Bill> billList = [];
    List<Budget> budgetList = [];
    List<FinancialReason> financialReasonList = [];
    int sysnTime = box.get('lastSyncTime',defaultValue: -1);
    if(sysnTime == -1){
      billList = Hive.box<Bill>("bill").values.toList();
      budgetList = Hive.box<Budget>("budget").values.toList();
      financialReasonList = Hive.box<FinancialReason>("financialReason").values.toList();
    }else{
      Hive.box<Bill>("bill").values.forEach((element) {
        if(element.updateTime!.millisecond > sysnTime) billList.add(element);
      });

      Hive.box<Budget>("budget").values.forEach((element) {
        if(element.updateTime!.millisecond > sysnTime) budgetList.add(element);
      });

      Hive.box<FinancialReason>("financialReason").values.forEach((element) {
        if(element.updateTime!.millisecond > sysnTime) financialReasonList.add(element);
      });
    }

    var billListMap = [];
    var budgetListMap = [];
    var financialReasonListMap = [];

    billList.forEach((element) {
      billListMap.add(BillParser.toMap(element));
    });

    budgetList.forEach((element) {
      budgetListMap.add(BudgetParser.toMap(element));
    });

    financialReasonList.forEach((element) {
      financialReasonListMap.add(FinancialReasonParser.toMap(element));
    });

    var entity = {"Bill": billListMap, "Budget": budgetListMap, "FinancialReason": financialReasonList};

    final response = await http.post(
      Uri.parse('http://139.224.11.164:8080/api/sync'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(entity),
    );

    if (response.statusCode == 200) {
      sysnTime = jsonDecode(response.body)['sysnTime'];
      return true;
    } else {
      return false;
    }
  }

  static Future<List<Bill>> futureListBill() async {
    List<Bill> list = [];
    var box = Hive.box<Bill>("bill");
    box.values.forEach((element) {
      list.add(element);
    });

    return list;
  }

  static Future<bool> saveBill(Bill bill) async {
    var box = Hive.box<Bill>("bill");

    bill.updateTime = DateTime.now();
    if (bill.isInBox) {
      bill.save();
    } else {
      bill.id = const Uuid().v1();
      box.add(bill);
    }

    return true;
  }

  static Future<List<Budget>> fetchListBudget() async {
    List<Budget> list = [];
    var box = Hive.box<Budget>("budget");
    box.values.forEach((element) {
      list.add(element);
    });

    return list;
  }

  static Future<bool> saveListBudget(List<Budget> budgetList) async {
    var box = Hive.box<Budget>("Budget");
    budgetList.forEach((element) {
      element.updateTime = DateTime.now();
      if (element.isInBox) {
        element.save();
      } else {
        element.id = const Uuid().v1();
        box.add(element);
      }
    });

    return true;
  }

  static Future<bool> saveFinancialReason(FinancialReason fr) async {
    var box = Hive.box<FinancialReason>("financialReason");
    fr.updateTime = DateTime.now();
    fr.id = const Uuid().v1();
    box.add(fr);
    return true;
  }

  static Future<List<FinancialReason>> fetchFinancialReasonOut() async {
    List<FinancialReason> list = [];
    var box = Hive.box<FinancialReason>("financialReason");
    box.values.forEach((element) {
      if (element.type == 0) list.add(element);
    });
    return list;
  }

  static Future<List<FinancialReason>> fetchFinancialReasonIn() async {
    List<FinancialReason> list = [];
    var box = Hive.box<FinancialReason>("financialReason");
    box.values.forEach((element) {
      if (element.type == 1) list.add(element);
    });
    return list;
  }
}
