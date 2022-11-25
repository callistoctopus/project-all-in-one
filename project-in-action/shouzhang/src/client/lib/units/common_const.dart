/*
 * @Author: gui-qi
 * @Date: 2022-11-04 15:49:28
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-25 08:09:38
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/data/dao/setting_dao.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CommonConst {}

class ICONS {
  static dynamic ADD = SettingDao.isDev() == true ? Iconsax.add : "记一笔";
  static dynamic BUG = SettingDao.isDev() == true ? Icons.bug_report_rounded : "开发";
  static dynamic LIST = SettingDao.isDev() == true ? Iconsax.receipt : "账单";
  static dynamic BUDGET = SettingDao.isDev() == true ? Iconsax.activity : "预算";
  static dynamic FILTER = SettingDao.isDev() == true ? Iconsax.filter_search : "筛选";
  static dynamic BACK = SettingDao.isDev() == true ? Icons.arrow_back : "返回";
  static dynamic SAVE = SettingDao.isDev() == true ? Iconsax.finger_cricle : "保存";
  static dynamic SYNC = SettingDao.isDev() == true ? Iconsax.refresh : "同步";
  static dynamic LOGOUT = SettingDao.isDev() == true ? Iconsax.logout : "登出";
  static dynamic BOOK = SettingDao.isDev() == true ? Iconsax.book_1 : "账号";
  static dynamic SETTING = SettingDao.isDev() == true ? Iconsax.setting_2 : "设置";
  static dynamic CALCULATOR = SettingDao.isDev() == true ? Iconsax.calculator : "盘账";

  static const dynamic USER = Iconsax.user;
  static const dynamic PASSWORD = Iconsax.password_check;
  static const dynamic DELETE = Iconsax.profile_delete;
}