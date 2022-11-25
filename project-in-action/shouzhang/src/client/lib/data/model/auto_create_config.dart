/*
 * @Author: gui-qi
 * @Date: 2022-11-04 02:25:21
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-25 10:06:35
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/data/model/model.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auto_create_config.g.dart';

@HiveType(typeId: 5)
@JsonSerializable()
class AutoCreateConfig extends HiveObject  implements Base{
  AutoCreateConfig(this.id, this.user, this.year, this.reason, this.type, this.duration, this.budget,
      this.note, this.isDeleted, this.updateTime);

  @HiveField(0)
  String id = "";

  @HiveField(1)
  String user;

  @HiveField(2)
  String year;

  @HiveField(3)
  String reason = "";

  @HiveField(4)
  int type = 0;

  @HiveField(5)
  int duration = 0;

  @HiveField(6)
  double budget = 0;

  @HiveField(7)
  String note = "";

  @HiveField(8)
  int isDeleted = 0;

  @HiveField(9)
  DateTime updateTime;

  factory AutoCreateConfig.fromJson(Map<String, dynamic> json) => _$AutoCreateConfigFromJson(json);

  Map<String, dynamic> toJson() => _$AutoCreateConfigToJson(this);
}
