/*
 * @Author: gui-qi
 * @Date: 2022-11-04 02:31:52
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-12-01 14:18:01
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */

import 'package:client/data/model/model.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'financial_reason.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class FinancialReason extends HiveObject implements Base {
  FinancialReason(this.id, this.user, this.reason, this.type, this.note, this.category, 
      this.isDeleted, this.updateTime);

  @HiveField(0)
  String id;

  @HiveField(1)
  String user = '';

  @HiveField(2)
  String reason;

  @HiveField(3)
  int type = 0;

  @HiveField(4)
  String note;

  @HiveField(5)
  int category;

  @HiveField(6)
  int isDeleted = 0;

  @HiveField(7)
  DateTime updateTime;

  factory FinancialReason.fromJson(Map<String, dynamic> json) =>
      _$FinancialReasonFromJson(json);

  Map<String, dynamic> toJson() => _$FinancialReasonToJson(this);
}
