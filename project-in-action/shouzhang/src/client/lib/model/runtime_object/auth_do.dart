/*
 * @Author: gui-qi
 * @Date: 2022-11-08 01:53:08
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-08 02:40:46
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:hive/hive.dart';

class AuthDO {
  static String user = "";
  static String password = "";
  static bool isLogined = false;
  static bool isAutoLogin = false;

  static void refresh() {
    var settingBox = Hive.box('setting');
    user = settingBox.get('user', defaultValue: "");
    password = settingBox.get('password', defaultValue: "");
    isLogined = settingBox.get('isLogined', defaultValue: false);
    isAutoLogin = settingBox.get('isAutoLogin', defaultValue: false);
  }
}
