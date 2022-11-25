/*
 * @Author: gui-qi
 * @Date: 2022-11-04 02:15:05
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-25 09:33:48
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */

import 'package:hive_flutter/hive_flutter.dart';

class Base extends HiveObject {
  Base(this.id, this.user, this.isDeleted, this.updateTime);

  String id;

  String user;

  int isDeleted;

  DateTime updateTime;
}
