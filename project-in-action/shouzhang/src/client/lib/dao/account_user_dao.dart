/*
 * @Author: gui-qi
 * @Date: 2022-11-14 14:33:29
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-14 14:33:43
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/dao/setting_dao.dart';
import 'package:client/model/persistent_object/account_user.dart';
import 'package:client/units/common_const.dart';
import 'package:client/units/common_utils.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AccountUserDao {
  static bool saveAccountUser(AccountUser accountUser) {
    accountUser.updateTime = CommonUtils.now();
    if (accountUser.isInBox) {
      accountUser.save();
    } else {
      Hive.box<AccountUser>(TABLE.accountUser).add(accountUser);
    }
    return true;
  }

  static List<String> getSharedUser() {
    List<String> ret = [];
    var box = Hive.box<AccountUser>(TABLE.accountUser);
    box.values.forEach((element) {
      // if (element.account == DB.currentAccount()) ret.add(element.user);
      if (element.user == SettingDao.currentUser()) {
        box.values.forEach((element1) {
          if (element.account == element1.account) {
            ret.add(element1.user);
          }
        });
      }
    });
    return ret;
  }

  static List<AccountUser> getSharedAccountUser() {
    List<AccountUser> ret = [];
    var box = Hive.box<AccountUser>(TABLE.accountUser);
    for (var element in box.values) {
      // if (element.account == DB.currentAccount()) ret.add(element.user);
      if (element.user == SettingDao.currentUser()) {
        for (var element1 in box.values) {
          if (element.account == element1.account) {
            ret.add(element1);
          }
        }
      }
    }
    return ret;
  }
}