/*
 * @Author: gui-qi
 * @Date: 2022-11-04 02:15:05
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-25 09:26:16
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */

import 'package:client/data/model/model.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'target.g.dart';

@HiveType(typeId: 6)
@JsonSerializable()
class Target extends HiveObject implements Base{
  Target(this.id, this.user, this.time, this.reason, this.type, this.amount,
      this.note, this.updateTime);
  @override
  @HiveField(0)
  String id;

  @override
  @HiveField(1)
  String user;

  @HiveField(2)
  DateTime time;

  @HiveField(3)
  String reason;

  @HiveField(4)
  int type = 0;

  @HiveField(5)
  double amount;

  @HiveField(6)
  String note;

  @override
  @HiveField(7)
  int isDeleted = 0;

  @override
  @HiveField(8)
  DateTime updateTime;

  factory Target.fromJson(Map<String, dynamic> json) => _$TargetFromJson(json);

  Map<String, dynamic> toJson() => _$TargetToJson(this);
}
