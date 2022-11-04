/*
 * @Author: gui-qi
 * @Date: 2022-11-04 02:15:05
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-04 03:04:56
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'dart:convert';
import 'package:client/model/budget.dart';
import 'package:client/model/bill.dart';
import 'package:client/model/financial_reason.dart';
import 'package:http/http.dart' as http;

class DataAccessService {
  static Future<List<Bill>> futureListBill() async {
    final response = await http
        .post(Uri.parse('http://139.224.11.164:8080/api/query/detail'));

    if (response.statusCode == 200) {
      return BillParser.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      return [];
    }
  }

  static Future<bool> saveBill(Bill bill) async {
    final response = await http.post(
      Uri.parse('http://139.224.11.164:8080/api/add/detail'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'amount': bill.amount,
        'note': bill.note,
        'reason': bill.reason,
        'time': bill.time,
        'type': bill.type,
        'user': bill.user,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<List<Budget>> fetchListBudget() async {
    final response = await http
        .post(Uri.parse('http://139.224.11.164:8080/api/query/budget'));

    if (response.statusCode == 200) {
      return BudgetParser.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      return [];
    }
  }

  static Future<bool> saveFinancialReason(FinancialReason fr) async {
    final response = await http.post(
      Uri.parse('http://139.224.11.164:8080/api/add/financial'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'user': fr.user,
        'type': fr.type,
        'reason': fr.reason,
        'note': fr.note,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<List<FinancialReason>> fetchFinancialReasonOut() async {
    final response = await http
        .post(Uri.parse('http://139.224.11.164:8080/api/query/financial/0'));

    if (response.statusCode == 200) {
      return FinancialReasonParser.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      return [];
    }
  }


  static Future<List<FinancialReason>> fetchFinancialReasonIn() async {
    final response = await http
        .post(Uri.parse('http://139.224.11.164:8080/api/query/financial/1'));

    if (response.statusCode == 200) {
      return FinancialReasonParser.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      return [];
    }
  }
}
