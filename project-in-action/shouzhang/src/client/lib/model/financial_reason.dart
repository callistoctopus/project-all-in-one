/*
 * @Author: gui-qi
 * @Date: 2022-11-04 02:31:52
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-06 16:48:42
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */

import 'package:hive/hive.dart';

part 'financial_reason.g.dart';

@HiveType(typeId: 0)
class FinancialReason extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String user = '';

  @HiveField(2)
  String? reason;

  @HiveField(3)
  int type = 0;

  @HiveField(4)
  String? note;

  @HiveField(5)
  DateTime? updateTime;
}

class FinancialReasonParser {
  static List<FinancialReason> fromMap(Map<String, dynamic> json) {
    List<FinancialReason> ret = [];
    json['data'].forEach((value) {
      FinancialReason fr = FinancialReason();
      fr.id = value["id"] ?? "";
      fr.user = value['user'] ?? "";
      fr.type = value['type'] ?? 0;
      fr.reason = value['reason'] ?? "";
      fr.note = value['note'] ?? "";
      ret.add(fr);
    });
    return ret;
  }

    static Map<String, dynamic>  toMap(FinancialReason bill) {
    Map<String, dynamic>  ret = {};

    return ret;
  }
}
