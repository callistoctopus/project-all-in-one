/*
 * @Author: gui-qi
 * @Date: 2022-11-23 02:15:44
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-23 02:19:26
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:flutter/cupertino.dart';

class FinancialType extends ChangeNotifier{
  int _curFinancialType = 0;

  set curFinancialType(int type){
    _curFinancialType = type;
    notifyListeners();
  }

  int get curFinancialType{
    return _curFinancialType;
  }

}