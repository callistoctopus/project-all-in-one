/*
 * @Author: gui-qi
 * @Date: 2022-11-14 14:32:31
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-17 01:30:11
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/dao/setting_dao.dart';
import 'package:client/model/account.dart';
import 'package:client/units/common_const.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AccountDao{
    static List<Account> allAccounts() {
    List<Account> accounts = [];
    Hive.box<Account>(TABLE.account).values.forEach((element) {
      if (element.user == SettingDao.currentUser()) accounts.add(element);
    });
    return accounts;
  }
}