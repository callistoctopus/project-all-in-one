/*
 * @Author: gui-qi
 * @Date: 2022-10-29 01:37:32
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-12-10 20:15:38
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'dart:async';

import 'package:client/page/config/route.dart';
import 'package:client/data/dao/consume_dao.dart';
import 'package:client/data/dao/dao.dart';
import 'package:client/data/model/bill.dart';
import 'package:client/data/listenable/global_do.dart';
import 'package:client/units/common_const.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class BillListPage extends StatefulWidget {
  const BillListPage({super.key, this.shortMode = false});

  final bool shortMode;

  @override
  State<BillListPage> createState() => _BillListPageState();
}

class _BillListPageState extends State<BillListPage> {
  late Future<List<Bill>> futureListBill;

  @override
  void initState() {
    super.initState();
    futureListBill = ConsumeDao.futureListBill();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: Icon(Iconsax.arrow_left),),
      backgroundColor: Colors.white,
      body: Padding(
          padding: EdgeInsets.only(
              left: widget.shortMode ? 2 : 10,
              right: widget.shortMode ? 2 : 10,
              top: widget.shortMode ? 5 : 10),
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
                                // BillDao.deleteBill(snapshot.data![i]);
                                Dao.delete(snapshot.data![i]);
                                snapshot.data!.removeAt(i);
                              });
                            },
                            child: BillRow(
                              bill: snapshot.data![i],
                              onLongPress: (bill) {},
                              onTap: (bill) {
                                context.read<GlobalDO>().bill = bill;
                                context.go(ROUTE.EDIT_BILL);
                              },
                            ));
                      }
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(
                            height: widget.shortMode ? 5 : 17,
                            color:
                                widget.shortMode ? const Color(0xFFF2F2F2) : const Color(0xFFF2F2F2),
                            thickness: 0),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              })),
      floatingActionButton: widget.shortMode
          ? const SizedBox()
          : FloatingActionButton(
              shape: const CircleBorder(),
              backgroundColor: Colors.white,
              child: Text(
                ICONS.BACK,
                style: const TextStyle(color: Colors.black),
              ),
              onPressed: () => context.go(ROUTE.HOME),
            ),
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
    TextStyle ts = const TextStyle(color: Color.fromARGB(155, 25, 105, 0),fontWeight: FontWeight.bold, fontSize: 13);
    if (bill.type == 1) {
      pre = '+';
      ts = const TextStyle(color: Color.fromARGB(155, 255, 0, 0),fontWeight: FontWeight.bold, fontSize: 13);
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
                    style:
                        const TextStyle(color: Colors.black54, fontSize: 13))),
            Expanded(
                flex: 3,
                child: Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    bill.user,
                    style:
                        const TextStyle(color: Colors.black54, fontSize: 13))),
            Expanded(
                flex: 4,
                child: Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    bill.reason,
                    style:
                        const TextStyle(color: Colors.black87, fontSize: 13))),
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
