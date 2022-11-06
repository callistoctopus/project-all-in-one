/*
 * @Author: gui-qi
 * @Date: 2022-11-04 02:25:21
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-05 14:00:57
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
class Budget {
  String id = "";
  String? user;
  String? year;
  String reason = "";
  int type = 0;
  double amount = 0;
  String note = "";
}

class BudgetParser {
  static List<Budget> fromJson(Map<String, dynamic> json) {
    List<Budget> ret = [];

    if(json == null || json['data'] == null)return ret;

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
}
