/*
 * @Author: gui-qi
 * @Date: 2022-11-04 02:15:05
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-29 14:13:02
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */

import 'package:client/data/model/model.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'auto_consume.g.dart';

@HiveType(typeId: 8)
@JsonSerializable()
class AutoConsume extends HiveObject implements Base {
  AutoConsume(this.id, this.user, this.duration, this.reason, this.type,
      this.amount, this.updateTime);
  @override
  @HiveField(0)
  String id;

  @override
  @HiveField(1)
  String user;

  @HiveField(2)
  int duration;

  @HiveField(3)
  String reason;

  @HiveField(4)
  int type = 0;

  @HiveField(5)
  double amount;

  @override
  @HiveField(6)
  int isDeleted = 0;

  @override
  @HiveField(7)
  DateTime updateTime;

  factory AutoConsume.fromJson(Map<String, dynamic> json) =>
      _$AutoConsumeFromJson(json);

  Map<String, dynamic> toJson() => _$AutoConsumeToJson(this);
}
