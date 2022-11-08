/*
 * @Author: gui-qi
 * @Date: 2022-11-04 02:15:05
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-08 12:45:25
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'dart:convert';
import 'package:client/model/persistent_object/bill.dart';
import 'package:client/model/persistent_object/budget.dart';
import 'package:client/model/persistent_object/financial_reason.dart';
import 'package:client/units/common_utils.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class DataAccessService {
  static Future<bool> syncData() async {
    var box = Hive.box("setting");
    List<Bill> billList = [];
    List<Budget> budgetList = [];
    List<FinancialReason> financialReasonList = [];
    DateTime sysnTime = box.get('lastSyncTime',
        defaultValue: CommonUtils.format(DateTime(1992)));

    Hive.box<Bill>("bill").values.forEach((element) {
      if (element.updateTime.compareTo(sysnTime) > 0) billList.add(element);
    });

    Hive.box<Budget>("budget").values.forEach((element) {
      if (element.updateTime.compareTo(sysnTime) > 0) budgetList.add(element);
    });

    Hive.box<FinancialReason>("financialReason").values.forEach((element) {
      if (element.updateTime.compareTo(sysnTime) > 0) {
        financialReasonList.add(element);
      }
    });

    var entity = {
      "User": "",
      "LastSyncTime": sysnTime.toString(),
      "BillList": billList,
      "BudgetList": budgetList,
      "FinancialReasonList": financialReasonList
    };
    var jsonEntity = jsonEncode(entity);
    print(jsonEntity);
    final response = await http.post(
      Uri.parse('http://139.224.11.164:8080/api/sync'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEntity,
    );

    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(utf8.decode(response.bodyBytes));

      if (jsonBody != null) {
        bool result = jsonBody['result'];
        if (result == true) {
          var data = jsonBody['data'];

          List billListr = data['billList'];
          billListr.forEach((element2) {
            bool isUpdate = false;
            Bill b = Bill.fromJson(element2);
            Hive.box<Bill>("bill").values.forEach((element) {
              if (element.id == b.id) {
                element.user = b.user;
                element.time = b.time;
                element.reason = b.reason;
                element.type = b.type;
                element.amount = b.amount;
                element.note = b.note;
                element.isDeleted = b.isDeleted;
                element.updateTime = b.updateTime;
                element.save();
                isUpdate = true;
              }
            });
            if (isUpdate == false) {
              Hive.box<Bill>("bill").add(b);
            }
          });

          List budgetListr = data['budgetList'];
          budgetListr.forEach((element2) {
            bool isUpdate = false;
            Budget b = Budget.fromJson(element2);
            Hive.box<Budget>("budget").values.forEach((element) {
              if (element.id == b.id) {
                element.user = b.user;
                element.year = b.year;
                element.reason = b.reason;
                element.type = b.type;
                element.budget = b.budget;
                element.note = b.note;
                element.isDeleted = b.isDeleted;
                element.updateTime = b.updateTime;
                element.save();
                isUpdate = true;
              }
            });
            if (isUpdate == false) {
              Hive.box<Budget>("budget").add(b);
            }
          });

          List financialReasonListr = data['financialReasonList'];
          financialReasonListr.forEach((element2) {
            bool isUpdate = false;
            FinancialReason b = FinancialReason.fromJson(element2);
            Hive.box<FinancialReason>("financialReason")
                .values
                .forEach((element) {
              if (element.id == b.id) {
                element.user = b.user;
                element.reason = b.reason;
                element.type = b.type;
                element.note = b.note;
                element.isDeleted = b.isDeleted;
                element.updateTime = b.updateTime;
                element.save();
                isUpdate = true;
              }
            });
            if (isUpdate == false) {
              Hive.box<FinancialReason>("financialReason").add(b);
            }
          });

          sysnTime = DateTime.parse(data['latestSyncTime']);
          box.put('lastSyncTime', sysnTime);
        }
      }
    }
    return false;
  }

  static Future sigin(String user, String password) async {
    final response = await http.post(
      Uri.parse('http://139.224.11.164:8080/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'user':user,'password':password, 'isSigin':true}),
    );

    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(utf8.decode(response.bodyBytes));
      if (jsonBody != null) {
        bool result = jsonBody['result'];
        if (result == true) {
          var settingBox = Hive.box('setting');
          settingBox.put('user', user);
          settingBox.put('password', password);
          settingBox.put('isLogined', true);
        }
      }
    }
  }

  static Future login(String user, String password) async {
    final response = await http.post(
      Uri.parse('http://139.224.11.164:8080/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'user':user,'password':password, 'isSigin':false}),
    );

    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(utf8.decode(response.bodyBytes));
      if (jsonBody != null) {
        bool result = jsonBody['result'];
        if (result == true) {
          var settingBox = Hive.box('setting');
          settingBox.put('user', user);
          settingBox.put('password', password);
          settingBox.put('isLogined', true);
        }
      }
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

    bill.user = Hive.box('setting').get('user');
    bill.time = CommonUtils.now();
    bill.updateTime = CommonUtils.now();
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
      element.user = Hive.box('setting').get('user');
      element.updateTime = CommonUtils.now();
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
    fr.user = Hive.box('setting').get('user');
    fr.updateTime = CommonUtils.now();
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
