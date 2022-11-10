/*
 * @Author: gui-qi
 * @Date: 2022-11-04 15:49:28
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-10 01:30:17
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';

class CommonConst {}

class ICONS {
  static const IconData ADD = Iconsax.add;
  static const IconData BUG = Icons.bug_report_rounded;
  static const IconData LIST = Iconsax.receipt;
  static const IconData BUDGET = Iconsax.activity;
  static const IconData FILTER = Iconsax.filter_search;
  static const IconData BACK = Iconsax.back_square;
  static const IconData SAVE = FontAwesomeIcons.save;
  static const IconData SYNC = Iconsax.refresh;
  static const IconData USER = Iconsax.user;
  static const IconData PASSWORD = Iconsax.password_check;
  static const IconData LOGOUT = Iconsax.logout;
  static const IconData BOOK = Iconsax.book_1;
  static const IconData SETTING = Iconsax.setting_2;
}

class ROUTE {
  static const String HOME = '/';
  static const String BILLS = '/bills';
  static const String ADD_BILL = '/add_bill';
  static const String ADD_REASON = '/add_reason';
  static const String LOGIN = '/login';
  static const String BUDGET = '/budget';
  static const String ACCOUNT = '/account';
}
