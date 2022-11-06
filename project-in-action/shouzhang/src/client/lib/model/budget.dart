/*
 * @Author: gui-qi
 * @Date: 2022-11-04 02:25:21
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-06 16:48:08
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:hive/hive.dart';

part 'budget.g.dart';

@HiveType(typeId: 1)
class Budget extends HiveObject {
  @HiveField(0)
  String id = "";

  @HiveField(1)
  String? user;

  @HiveField(2)
  String? year;

  @HiveField(3)
  String reason = "";

  @HiveField(4)
  int type = 0;

  @HiveField(5)
  double amount = 0;

  @HiveField(6)
  String note = "";

  @HiveField(7)
  DateTime? updateTime;
}

class BudgetParser {
  static List<Budget> fromMap(Map<String, dynamic> json) {
    List<Budget> ret = [];

    if (json == null || json['data'] == null) return ret;

    json['data'].forEach((value) {
      Budget b = Budget();
      b.id = value["id"] ?? "";
      b.user = value['user'] ?? "";
      b.year = value['year'] ?? "";
      b.reason = value['reason'] ?? "";
      b.type = value['type'] ?? 0;
      b.amount = value['budget'] ?? 0;
      b.note = value['note'] ?? "";
      ret.add(b);
    });
    return ret;
  }

  static Map<String, dynamic>  toMap(Budget bill) {
    Map<String, dynamic>  ret = {};

    return ret;
  }
}
