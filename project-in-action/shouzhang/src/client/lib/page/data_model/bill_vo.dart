/*
 * @Author: gui-qi
 * @Date: 2022-11-23 06:02:49
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-23 08:48:23
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/dao/setting_dao.dart';
import 'package:client/model/bill.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class BillVO extends ChangeNotifier {
  Bill _bill = Bill(const Uuid().v1(), SettingDao.currentUser(), DateTime.now(),
      "", 0, -1, "", DateTime.now());

  set bill(Bill bill) {
    _bill = bill;
    notifyListeners();
  }

  Bill get bill {
    return _bill;
  }

  void reset() {
    _bill = Bill(const Uuid().v1(), SettingDao.currentUser(), DateTime.now(),
        "", 0, -1, "", DateTime.now());
  }
}
