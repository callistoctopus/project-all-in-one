/*
 * @Author: gui-qi
 * @Date: 2022-11-04 02:15:05
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-09 09:59:14
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'account_user.g.dart';

@HiveType(typeId: 3)
@JsonSerializable()
class AccountUser extends HiveObject {
  AccountUser(this.id, this.user, this.account, this.state, this.isDeleted, this.updateTime);
  @HiveField(0)
  String id;

  @HiveField(1)
  String user;

  @HiveField(2)
  String account;

  @HiveField(3)
  int state;

  @HiveField(4)
  int isDeleted = 0;

  @HiveField(5)
  DateTime updateTime;

  factory AccountUser.fromJson(Map<String, dynamic> json) => _$AccountUserFromJson(json);

  Map<String, dynamic> toJson() => _$AccountUserToJson(this);
}
