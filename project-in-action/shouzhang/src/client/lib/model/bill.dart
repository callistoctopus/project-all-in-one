/*
 * @Author: gui-qi
 * @Date: 2022-11-04 02:15:05
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-04 16:31:45
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
class Bill {
   String? id;
   String user = '';
   DateTime? time;
   String? reason;
   int? type = 0;
   double? amount;
   String? note;
}

class BillParser {
  static List<Bill> fromJson(Map<String, dynamic> json) {
    List<Bill> ret = [];
    json['data'].forEach((value) {
      Bill bill = Bill();
      bill.id = value["id"] ?? "";
      bill.user = value['user'] ?? "";
      bill.time = value['time'] != null ? DateTime.parse(value['time']) : null;
      bill.reason = value['reason'] ?? "";
      bill.type = value['type'] ?? 0;
      bill.amount = value['amount'] ?? 0;
      bill.note = value['note'] ?? "";
      ret.add(bill);
    });
    return ret;
  }
}