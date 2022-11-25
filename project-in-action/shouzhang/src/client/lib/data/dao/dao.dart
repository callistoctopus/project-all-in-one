/*
 * @Author: gui-qi
 * @Date: 2022-11-25 09:35:29
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-25 09:56:22
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/data/dao/setting_dao.dart';
import 'package:client/data/model/model.dart';
import 'package:client/units/common_utils.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

class Dao {
  static bool upsert<T extends Base>(T obj, String table) {
    obj.user = SettingDao.currentUser();
    obj.updateTime = CommonUtils.now();
    if (obj.isInBox) {
      obj.save();
    } else {
      obj.id = const Uuid().v1();
      Hive.box<T>(table).add(obj);
    }
    return true;
  }

  static bool delete<T extends Base>(T obj) {
    obj.isDeleted = 1;
    obj.updateTime = CommonUtils.now();
    if (obj.isInBox) {
      obj.save();
    } 
    return true;
  }

  
}
