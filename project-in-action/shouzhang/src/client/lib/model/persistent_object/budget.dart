/*
 * @Author: gui-qi
 * @Date: 2022-11-04 02:25:21
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-07 10:02:35
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'budget.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class Budget extends HiveObject {
  Budget(this.id, this.user, this.year, this.reason, this.type, this.budget,
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
  double budget = 0;

  @HiveField(6)
  String note = "";

  @HiveField(7)
  int isDeleted = 0;

  @HiveField(8)
  DateTime updateTime;

  factory Budget.fromJson(Map<String, dynamic> json) => _$BudgetFromJson(json);

  Map<String, dynamic> toJson() => _$BudgetToJson(this);
}
