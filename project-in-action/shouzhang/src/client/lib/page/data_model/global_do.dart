/*
 * @Author: gui-qi
 * @Date: 2022-11-23 09:59:07
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-12-01 13:11:58
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/data/dao/setting_dao.dart';
import 'package:client/data/model/auto_consume.dart';
import 'package:client/data/model/bill.dart';
import 'package:client/data/model/budget.dart';
import 'package:client/units/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class GlobalDO extends ChangeNotifier {
  Bill _bill = Bill(const Uuid().v1(), SettingDao.currentUser(),
      CommonUtils.now(), "", 0, -1, "", CommonUtils.now());

  Budget _budget = Budget(
      const Uuid().v1(),
      SettingDao.currentUser(),
      CommonUtils.now().year.toString(),
      "",
      0,
      0,
      -1,
      "",
      0,
      CommonUtils.now());
      
  AutoConsume _autoConsume = AutoConsume(const Uuid().v1(),
      SettingDao.currentUser(), 0, "", 0, -1, CommonUtils.now());

  int homePageIndes = 0;

  int _type = 0;
  String _reason = "";
  double _amount = -1;
  int _duration = 0;
  String _note = "";

  set type(int type) {
    _type = type;
    notifyListeners();
  }

  set type_(int type) {
    _type = type;
  }

  int get type {
    return _type;
  }

  set reason(String reason) {
    _reason = reason;
    // notifyListeners();
  }

  String get reason {
    return _reason;
  }

  set amount(double amount) {
    _amount = amount;
    notifyListeners();
  }

  double get amount {
    return _amount;
  }

  set note(String note) {
    _note = note;
    notifyListeners();
  }

  String get note {
    return _note;
  }

  set duration(int duration) {
    _duration = duration;
    notifyListeners();
  }

  int get duration {
    return _duration;
  }

  set bill(Bill? bill) {
    _bill = bill ??
        Bill(const Uuid().v1(), SettingDao.currentUser(), CommonUtils.now(), "",
            0, -1, "", CommonUtils.now());
    _type = _bill.type;
    _amount = _bill.amount;
    _reason = _bill.reason;
    _note = _bill.note;
  }

  Bill get bill {
    _bill.time = CommonUtils.now();
    _bill.amount = _amount;
    _bill.type = _type;
    _bill.reason = _reason;
    _bill.note = _reason;
    return _bill;
  }

  set budget(Budget? budget) {
    _budget = budget ??
        Budget(
            const Uuid().v1(),
            SettingDao.currentUser(),
            CommonUtils.now().year.toString(),
            "",
            0,
            0,
            -1,
            "",
            0,
            CommonUtils.now());
    _type = _budget.type;
    _amount = _budget.budget;
    _reason = _budget.reason;
    _note = _budget.note;
  }

  Budget get budget {
    _budget.budget = _amount;
    _budget.type = _type;
    _budget.reason = _reason;
    _budget.note = _reason;
    return _budget;
  }

  set autoConsume(AutoConsume? autoConsume) {
    _autoConsume = autoConsume ??
        AutoConsume(const Uuid().v1(), SettingDao.currentUser(), 0, "", 0, -1,
            CommonUtils.now());
  }

  AutoConsume get autoConsume {
    return _autoConsume;
  }
}
