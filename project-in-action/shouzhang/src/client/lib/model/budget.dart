/*
 * @Author: gui-qi
 * @Date: 2022-11-04 02:25:21
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-04 02:25:39
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
class Budget {
  final String id;
  final String user;
  final String year;
  final String reason;
  final int type;
  final double amount;
  final String note;

  const Budget({
    required this.id,
    required this.user,
    required this.year,
    required this.reason,
    required this.type,
    required this.amount,
    required this.note,
  });
}

class BudgetParser {
  static List<Budget> fromJson(Map<String, dynamic> json) {
    List<Budget> ret = [];

    json['data'].forEach((value) {
      ret.add(Budget(
        id: value["id"] ?? "",
        user: value['user'] ?? "",
        year: value['year'] ?? "",
        reason: value['reason'] ?? "",
        type: value['type'] ?? 0,
        amount: value['budget'] ?? 0,
        note: value['note'] ?? "",
      ));
    });
    return ret;
  }
}