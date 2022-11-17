/*
 * @Author: gui-qi
 * @Date: 2022-10-29 01:37:32
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-16 14:20:23
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'dart:async';

import 'package:client/config/route.dart';
import 'package:client/dao/bill_dao.dart';
import 'package:client/model/persistent_object/bill.dart';
import 'package:client/page/ParamStore.dart';
import 'package:client/page/bill_add_page.dart';
import 'package:flutter/material.dart';
import 'package:client/component/custom_float_button.dart';
import 'package:go_router/go_router.dart';

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
    try {
      futureListBill = BillDao.futureListBill();
    } on Exception {}
  }

  @override
  Widget build(BuildContext context) {
    return PageWithFloatButton(
      child: Scaffold(
          body: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
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
                            return Dismissible(
                                key: ValueKey<Bill>(snapshot.data![i]),
                                onDismissed: (DismissDirection direction) {
                                  setState(() {
                                    BillDao.deleteBill(snapshot.data![i]);
                                    snapshot.data!.removeAt(i);
                                  });
                                },
                                child: BillRow(
                                  bill: snapshot.data![i],
                                  onLongPress: (bill) {
                                    
                                  },
                                  onTap: (bill) {
                                    PageParamStore.bill = bill;
                                    context.go(ROUTE.EDIT_BILL);
                                  },
                                ));
                          }
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(
                                height: 17, color: Colors.grey, thickness: 0),
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
  const BillRow(
      {super.key,
      required this.bill,
      required this.onTap,
      required this.onLongPress});

  final Bill bill;
  final Function(Bill) onTap;
  final Function(Bill) onLongPress;

  @override
  Widget build(BuildContext context) {
    var pre = "-";
    TextStyle ts = const TextStyle(color: Color.fromARGB(155, 25, 105, 0));
    if (bill.type == 1) {
      pre = '+';
      ts = const TextStyle(color: Color.fromARGB(155, 255, 0, 0));
    }

    String amount = pre + bill.amount.toString();

    return GestureDetector(
        onTap: () {
          onTap(bill);
        },
        onLongPress: () {
          onLongPress(bill);
        },
        child: Row(
          children: [
            Expanded(
                flex: 1, child: Text(bill.time.toString().substring(0, 10))),
            Expanded(flex: 1, child: Text(bill.user)),
            Expanded(flex: 1, child: Text(bill.reason)),
            Expanded(flex: 1, child: Text(amount, style: ts)),
          ],
        ));
  }
}
