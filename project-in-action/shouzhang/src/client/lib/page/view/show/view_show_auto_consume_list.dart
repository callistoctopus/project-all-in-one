/*
 * @Author: gui-qi
 * @Date: 2022-10-29 01:37:32
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-29 14:32:24
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'dart:async';

import 'package:client/data/dao/auto_consume_dao.dart';
import 'package:client/data/model/auto_consume.dart';
import 'package:client/page/component/custom_chart.dart';
import 'package:client/page/config/route.dart';
import 'package:client/data/dao/dao.dart';
import 'package:client/data/model/bill.dart';
import 'package:client/data/listenable/global_do.dart';
import 'package:client/units/common_const.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AutoConsumeListPage extends StatefulWidget {
  const AutoConsumeListPage({super.key, this.shortMode = false});

  final bool shortMode;

  @override
  State<AutoConsumeListPage> createState() => _AutoConsumeListPageState();
}

class _AutoConsumeListPageState extends State<AutoConsumeListPage> {
  late Future<List<AutoConsume>> autoConsumeList;

  @override
  void initState() {
    super.initState();
    autoConsumeList = AutoConsumeDao.fetchListAutoConsume();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomChart(
          title: "自动扣费一览",
          link: "添加",
          callback: () {
            context.go(ROUTE.ADD_AUTOCOMSUME);
          },
          height: MediaQuery.of(context).size.height,
          child: Padding(
              padding: EdgeInsets.only(
                  left: widget.shortMode ? 2 : 30,
                  right: widget.shortMode ? 2 : 20,
                  top: widget.shortMode ? 5 : 20),
              child: FutureBuilder<List<AutoConsume>>(
                  future: autoConsumeList,
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
                                key: ValueKey<AutoConsume>(snapshot.data![i]),
                                onDismissed: (DismissDirection direction) {
                                  setState(() {
                                    // BillDao.deleteBill(snapshot.data![i]);
                                    Dao.delete(snapshot.data![i]);
                                    snapshot.data!.removeAt(i);
                                  });
                                },
                                child: AutoConsumeRow(
                                  bill: snapshot.data![i],
                                  onLongPress: (autoConsume) {},
                                  onTap: (autoConsume) {
                                    context.read<GlobalDO>().autoConsume = autoConsume;
                                    context.go(ROUTE.EDIT_AUTOCOMSUME);
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

class AutoConsumeRow extends StatelessWidget {
  const AutoConsumeRow(
      {super.key,
      required this.bill,
      required this.onTap,
      required this.onLongPress});

  final AutoConsume bill;
  final Function(AutoConsume) onTap;
  final Function(AutoConsume) onLongPress;

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
                    bill.duration.toString(),
                    style:
                        const TextStyle(color: Colors.black54, fontSize: 11))),
            Expanded(
                flex: 3,
                child: Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    bill.user,
                    style:
                        const TextStyle(color: Colors.black54, fontSize: 11))),
            Expanded(
                flex: 2,
                child: Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    bill.reason,
                    style:
                        const TextStyle(color: Colors.black87, fontSize: 11))),
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
