/*
 * @Author: gui-qi
 * @Date: 2022-11-04 02:31:52
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-04 16:51:30
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */

class FinancialReason {
  String? id;
  String user = '';
  String? reason;
  int type = 0;
  String? note;
}

class FinancialReasonParser {
  static List<FinancialReason> fromJson(Map<String, dynamic> json) {
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
}
