/*
 * @Author: gui-qi
 * @Date: 2022-11-04 02:15:05
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-06 16:47:41
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */

import 'package:hive/hive.dart';
part 'bill.g.dart';
@HiveType(typeId: 2)
class Bill extends HiveObject{
  @HiveField(0)
   String? id;

   @HiveField(1)
   String user = '';

   @HiveField(2)
   DateTime? time;

   @HiveField(3)
   String? reason;

   @HiveField(4)
   int? type = 0;

   @HiveField(5)
   double? amount;

   @HiveField(6)
   String? note;
   
   @HiveField(7)
   DateTime? updateTime;
}



class BillParser {
  static List<Bill> fromMap(Map<String, dynamic> json) {
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

  static Map<String, dynamic>  toMap(Bill bill) {
    Map<String, dynamic>  ret = {};

    return ret;
  }
}