/*
 * @Author: gui-qi
 * @Date: 2022-11-16 13:50:07
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-22 06:57:32
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/model/bill.dart';
import 'package:client/model/budget.dart';

class PageParamStore{
  static Bill? bill;
  static Budget? budget;
  static Map<String, dynamic> settingMap = {};
}