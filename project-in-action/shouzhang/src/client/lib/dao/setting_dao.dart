/*
 * @Author: gui-qi
 * @Date: 2022-11-14 14:29:47
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-14 14:30:59
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/units/common_const.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SettingDao{
    static String currentUser() {
    return Hive.box(TABLE.setting).get(KEY.user, defaultValue: "");
  }

  static void setUser(String user) {
    Hive.box(TABLE.setting).put(KEY.user, user);
  }

  static bool isLogined() {
    return Hive.box(TABLE.setting).get(KEY.isLogined, defaultValue: false);
  }

  static void setLogined(bool isLogined) {
    Hive.box(TABLE.setting).put(KEY.isLogined, isLogined);
  }

  static bool isAutoLogin() {
    return Hive.box(TABLE.setting).get(KEY.isAutoLogin, defaultValue: false);
  }

  static void setAutoLogin(bool isAutoLogin) {
    Hive.box(TABLE.setting).put(KEY.isAutoLogin, isAutoLogin);
  }

    static void setAccount(String account) {
    Hive.box(TABLE.setting).put(KEY.account, account);
  }

    static String currentAccount() {
    return Hive.box(TABLE.setting).get(KEY.account, defaultValue: "");
  }

    static int budgetYear() {
    return Hive.box(TABLE.setting).get(KEY.budgetYear, defaultValue: 2022);
  }

  static void setBudgetYear(int year) {
    Hive.box(TABLE.setting).put(KEY.budgetYear, year);
  }

  static bool isDev() {
    return Hive.box(TABLE.setting).get(KEY.devMode, defaultValue: false);
  }

  static void setDevMode(bool isDev) {
    Hive.box(TABLE.setting).put(KEY.devMode, isDev);
  }

  static void setOfflineMode(bool mode){
    Hive.box(TABLE.setting).put(KEY.offlineMode, mode);
  }

  static bool isOfflineMode(){
    return Hive.box(TABLE.setting).get(KEY.offlineMode, defaultValue: false);
  }
}