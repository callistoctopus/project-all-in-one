/*
 * @Author: gui-qi
 * @Date: 2022-11-14 14:19:43
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-29 14:20:05
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/data/dao/account_user_dao.dart';
import 'package:client/data/db.dart';
import 'package:client/data/model/auto_consume.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AutoConsumeDao{
  static Future<List<AutoConsume>> fetchListAutoConsume() async {

    List<AutoConsume> list = [];
    List<String?> userList = AccountUserDao.getSharedUser();
    await Future(() => Hive.box<AutoConsume>(TABLE.autoConsume).values.forEach((element) {
      if (userList.contains(element.user) && element.isDeleted == 0) {
        list.add(element);
      }
    }));
    
    await Future(() => list.sort((a,b)=>b.updateTime.compareTo(a.updateTime)));
    return list;
  }
}