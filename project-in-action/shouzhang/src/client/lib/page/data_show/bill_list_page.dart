/*
 * @Author: gui-qi
 * @Date: 2022-10-29 01:37:32
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-21 08:55:10
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'dart:async';

import 'package:client/config/route.dart';
import 'package:client/dao/bill_dao.dart';
import 'package:client/model/bill.dart';
import 'package:client/page/data_model/ParamStore.dart';
import 'package:flutter/material.dart';
import 'package:client/page/component/custom_float_button.dart';
import 'package:go_router/go_router.dart';

class BillListPage extends StatefulWidget {
  BillListPage({super.key, this.shortMode = false});

  bool shortMode;

  @override
  State<BillListPage> createState() => _BillListPageState();
}

class _BillListPageState extends State<BillListPage> {
  late Future<List<Bill>> futureListBill;

  @override
  void initState() {
    super.initState();
    futureListBill = BillDao.futureListBill();
  }

  @override
  Widget build(BuildContext context) {
    return PageWithFloatButton(
      showFloatBottom: widget.shortMode ? false : true,
      child: Scaffold(
          body: Padding(
              padding: EdgeInsets.only(
                  left: widget.shortMode ? 2 : 30, right: widget.shortMode ? 2 : 20, top: widget.shortMode ? 5 : 20),
              child: FutureBuilder<List<Bill>>(
                  future: futureListBill,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                        itemCount: widget.shortMode ? 3 : 100,
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
                                  onLongPress: (bill) {},
                                  onTap: (bill) {
                                    PageParamStore.bill = bill;
                                    context.go(ROUTE.EDIT_BILL);
                                  },
                                ));
                          }
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(
                                height: widget.shortMode ? 5 : 17,
                                color: widget.shortMode
                                    ? Colors.white38
                                    : Colors.grey,
                                thickness: 0),
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
                flex: 3,
                child: Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    bill.time.toString().substring(0, 10),
                    style: const TextStyle(color: Colors.black54,fontSize: 11))),
            Expanded(
                flex: 3,
                child: Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    bill.user,
                    style: const TextStyle(color: Colors.black54,fontSize: 11))),
            Expanded(
                flex: 2,
                child: Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    bill.reason,
                    style: const TextStyle(color: Colors.black87,fontSize: 11))),
            Expanded(
                flex: 4,
                child: Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    amount,
                    style: ts)),
          ],
        ));
  }
}
