/*
 * @Author: gui-qi
 * @Date: 2022-11-04 02:31:52
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-04 06:48:38
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */

class FinancialReason {
  late String id;
  late String user;
  late String reason;
  late int type = 0;
  late String note;
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
