/*
 * @Author: gui-qi
 * @Date: 2022-11-04 02:15:05
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-07 08:49:45
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'bill.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class Bill extends HiveObject {
  Bill(this.id, this.user, this.time, this.reason, this.type, this.amount,
      this.note, this.updateTime);
  @HiveField(0)
  String id;

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

  @HiveField(7)
  int isDeleted = 0;

  @HiveField(8)
  DateTime updateTime;

  factory Bill.fromJson(Map<String, dynamic> json) => _$BillFromJson(json);

  Map<String, dynamic> toJson() => _$BillToJson(this);
}
