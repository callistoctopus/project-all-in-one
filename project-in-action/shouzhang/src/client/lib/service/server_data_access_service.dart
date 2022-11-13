/*
 * @Author: gui-qi
 * @Date: 2022-11-04 02:15:05
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-13 04:15:33
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'dart:convert';
import 'package:client/model/persistent_object/account.dart';
import 'package:client/model/persistent_object/account_user.dart';
import 'package:client/model/persistent_object/bill.dart';
import 'package:client/model/persistent_object/budget.dart';
import 'package:client/model/persistent_object/financial_reason.dart';
import 'package:client/service/local_database_service.dart';
import 'package:client/units/common_utils.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

class DataAccessService {
  static Future<bool> syncData() async {
    if (DB.isOfflineMode()) {
      return true;
    }
    List<Bill> billList = [];
    List<Budget> budgetList = [];
    List<FinancialReason> financialReasonList = [];
    List<Account> accountList = [];
    List<AccountUser> accountUserList = [];
    DateTime sysnTime = Hive.box("setting").get(
        'lastSyncTime${DB.currentUser()}',
        defaultValue: CommonUtils.format(DateTime(1992)));

    Hive.box<Bill>("bill").values.forEach((element) {
      if (element.updateTime.compareTo(sysnTime) > 0 &&
          element.user == DB.currentUser()) billList.add(element);
    });

    Hive.box<Budget>("budget").values.forEach((element) {
      if (element.updateTime.compareTo(sysnTime) > 0 &&
          element.user == DB.currentUser()) budgetList.add(element);
    });

    Hive.box<FinancialReason>("financialReason").values.forEach((element) {
      if (element.updateTime.compareTo(sysnTime) > 0 &&
          element.user == DB.currentUser()) {
        financialReasonList.add(element);
      }
    });

    Hive.box<Account>("account").values.forEach((element) {
      if (element.updateTime.compareTo(sysnTime) > 0 &&
          element.user == DB.currentUser()) {
        accountList.add(element);
      }
    });

    Hive.box<AccountUser>("accountUser").values.forEach((element) {
      if (element.updateTime.compareTo(sysnTime) > 0 &&
          element.account == DB.currentAccount()) {
        accountUserList.add(element);
      }
    });

    var entity = {
      "User": DB.currentUser(),
      "LastSyncTime": sysnTime.toString(),
      "BillList": billList,
      "BudgetList": budgetList,
      "FinancialReasonList": financialReasonList,
      "accountList": accountList,
      "accountUserList": accountUserList,
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
      print(jsonBody);
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

          List accountListr = data['accountList'];
          accountListr.forEach((element2) {
            bool isUpdate = false;
            Account b = Account.fromJson(element2);
            Hive.box<Account>("account").values.forEach((element) {
              if (element.id == b.id) {
                element.user = b.user;
                element.account = b.account;
                element.state = b.state;
                element.createTime = b.createTime;
                element.isDeleted = b.isDeleted;
                element.updateTime = b.updateTime;
                element.save();
                isUpdate = true;
              }
            });
            if (isUpdate == false) {
              Hive.box<Account>("account").add(b);
            }
          });

          List accountUserListr = data['accountUserList'];
          accountUserListr.forEach((element2) {
            bool isUpdate = false;
            AccountUser b = AccountUser.fromJson(element2);
            Hive.box<AccountUser>("accountUser").values.forEach((element) {
              if (element.id == b.id) {
                element.user = b.user;
                element.account = b.account;
                element.state = b.state;
                element.isDeleted = b.isDeleted;
                element.updateTime = b.updateTime;
                element.save();
                isUpdate = true;
              }
            });
            if (isUpdate == false) {
              Hive.box<AccountUser>("accountUser").add(b);
            }
          });

          sysnTime = DateTime.parse(data['latestSyncTime']);
          Hive.box("setting").put('lastSyncTime${DB.currentUser()}', sysnTime);

          if (DB.currentAccount() != DB.currentUser()) {
            String account = "";
            if (DB.allAccounts().isNotEmpty) {
              account = DB.allAccounts()[0].account;
            }
            DB.setAccount(account);
          }
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
      body: jsonEncode({'user': user, 'password': password, 'isSigin': true}),
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
          DB.setAccount("");
        }
      }
    }
  }

  static Future login(String user, String password) async {
    try {
      final response = await http.post(
        Uri.parse('http://139.224.11.164:8080/api/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:
            jsonEncode({'user': user, 'password': password, 'isSigin': false}),
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
            DB.setAccount("");
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
