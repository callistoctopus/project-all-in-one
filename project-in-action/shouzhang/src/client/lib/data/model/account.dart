/*
 * @Author: gui-qi
 * @Date: 2022-11-04 02:15:05
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-25 10:03:53
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */

import 'package:client/data/model/model.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'account.g.dart';

@HiveType(typeId: 4)
@JsonSerializable()
class Account extends HiveObject  implements Base{
  Account(this.id, this.user, this.account, this.state, this.createTime,
      this.isDeleted, this.updateTime);
  @HiveField(0)
  String id;

  @HiveField(1)
  String user;

  @HiveField(2)
  String account;

  @HiveField(3)
  int state;

  @HiveField(4)
  DateTime createTime;

  @HiveField(5)
  int isDeleted = 0;

  @HiveField(6)
  DateTime updateTime;

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}
