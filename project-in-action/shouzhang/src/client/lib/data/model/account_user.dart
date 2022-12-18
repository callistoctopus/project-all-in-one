/*
 * @Author: gui-qi
 * @Date: 2022-11-04 02:15:05
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-25 10:03:41
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */

import 'package:client/data/model/model.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'account_user.g.dart';

@HiveType(typeId: 3)
@JsonSerializable()
class AccountUser extends HiveObject  implements Base{
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
