/*
 * @Author: gui-qi
 * @Date: 2022-11-04 02:15:05
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-04 02:58:39
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
class Bill {
   late String id;
   late String user;
   late String time;
   late String reason;
   late int type = 0;
   late double amount;
   late String note;
}

class BillParser {
  static List<Bill> fromJson(Map<String, dynamic> json) {
    List<Bill> ret = [];
    json['data'].forEach((value) {
      Bill bill = Bill();
      bill.id = value["id"] ?? "";
      bill.user = value['user'] ?? "";
      bill.time = value['time'] ?? "";
      bill.reason = value['reason'] ?? "";
      bill.type = value['type'] ?? 0;
      bill.amount = value['amount'] ?? 0;
      bill.note = value['note'] ?? "";
      ret.add(bill);
    });
    return ret;
  }
}