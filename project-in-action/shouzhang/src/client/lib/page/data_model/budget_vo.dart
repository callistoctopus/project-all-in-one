/*
 * @Author: gui-qi
 * @Date: 2022-11-23 06:02:49
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-23 06:18:44
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:flutter/material.dart';

class BillVO extends ChangeNotifier {
  int _editType = 0; //0:新增 1：编辑
  int _type = 0;
  String _reason = "";
  double _amount = -1;
  int _duration = 0;
  String _note = "";

  set editType(int type) {
    _editType = type;
    notifyListeners();
  }

  int get editType{
    return _editType;
  }

  set type(int type) {
    _type = type;
    notifyListeners();
  }

  int get type{
    return _type;
  }

  set reason(String reason) {
    _reason = reason;
    notifyListeners();
  }

  String get reason{
    return _reason;
  }

  set amount(double amount) {
    _amount = amount;
    notifyListeners();
  }

  double get amount{
    return _amount;
  }

  set duration(int duration) {
    _duration = duration;
    notifyListeners();
  }

  int get duration{
    return _duration;
  }

  set note(String note) {
    _note = note;
    notifyListeners();
  }

  String get note{
    return _note;
  }
}
