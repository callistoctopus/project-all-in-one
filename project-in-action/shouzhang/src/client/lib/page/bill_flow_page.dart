/*
 * @Author: gui-qi
 * @Date: 2022-10-29 01:37:32
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-12 12:14:26
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'dart:async';

import 'package:client/model/persistent_object/bill.dart';
import 'package:client/service/local_database_service.dart';
import 'package:flutter/material.dart';
import 'package:client/component/custom_float_button.dart';

class CashFlowPage extends StatefulWidget {
  const CashFlowPage({super.key});

  @override
  State<CashFlowPage> createState() => _CashFlowPageState();
}

class _CashFlowPageState extends State<CashFlowPage> {
  late Future<List<Bill>> futureListBill;

  @override
  void initState() {
    super.initState();
    // Timer(, () { })
    try {
      futureListBill = DB.futureListBill();
    } on Exception {}
  }

  @override
  Widget build(BuildContext context) {
    return PageWithFloatButton(
      child: Scaffold(
          body: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
              child: FutureBuilder<List<Bill>>(
                  future: futureListBill,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                        itemCount: 100,
                        itemBuilder: (context, i) {
                          if (i >= snapshot.data!.length) {
                            return Row(
                              children: const [
                                Padding(
                                    padding: EdgeInsets.only(left: 35),
                                    child: Text("")),
                              ],
                            );
                          } else {
                            return BillRow(
                              bill: snapshot.data![i],
                            );
                          }
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const CircularProgressIndicator();
                  }))),
    );
  }
}

class BillRow extends StatelessWidget {
  const BillRow({super.key, required this.bill});

  final Bill bill;

  @override
  Widget build(BuildContext context) {
    var pre = "-";
    TextStyle ts = const TextStyle(color: Color.fromARGB(155, 25, 105, 0));
    if (bill.type == 1) {
      pre = '+';
      ts = const TextStyle(color: Color.fromARGB(155, 255, 0, 0));
    }

    String amount = pre + bill.amount.toString();

    return Row(
      children: [
        Expanded(flex: 2, child: Text(bill.time.toString().substring(0, 10))),
        Expanded(flex: 2, child: Text(bill.user)),
        Expanded(flex: 2, child: Text(bill.reason)),
        Expanded(flex: 1, child: Text(amount, style: ts)),
      ],
    );
  }
}
