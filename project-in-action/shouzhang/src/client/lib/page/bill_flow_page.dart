/*
 * @Author: gui-qi
 * @Date: 2022-10-29 01:37:32
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-04 15:48:21
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:flutter/material.dart';
import 'package:client/component/custom_float_button.dart';
import 'package:client/model/bill.dart';
import 'package:client/service/data_access_service.dart';

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
      futureListBill = DataAccessService.futureListBill();
    } on Exception {}
  }

  @override
  Widget build(BuildContext context) {
    return PageWithFloatButton(
      child: FutureBuilder<List<Bill>>(
        future: futureListBill,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                body: Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 15),
                    child: ListView.builder(
                        itemCount: 100,
                        itemBuilder: (context, i) {
                          if (i % 2 == 0) {
                            return const Divider(
                              height: 10,
                              thickness: 1,
                              indent: 5,
                              endIndent: 5,
                            );
                          } else {
                            if (i > snapshot.data!.length * 2) {
                              return Row(
                                children: const [
                                  Padding(
                                      padding: EdgeInsets.only(left: 35),
                                      child: Text("")),
                                ],
                              );
                            } else {
                              var pre = "-";
                              TextStyle ts = const TextStyle(
                                  color: Color.fromARGB(155, 25, 105, 0));
                              if (snapshot.data![i ~/ 2].type == 1) {
                                pre = '+';
                                ts = const TextStyle(
                                    color: Color.fromARGB(155, 255, 0, 0));
                              }

                              String amount = pre +
                                  snapshot.data![i ~/ 2].amount.toString();

                              return Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(left: 35),
                                      child: Text(snapshot.data![i ~/ 2].time.toString()
                                          .substring(0, 10))),
                                  Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Text(snapshot.data![i ~/ 2].user!)),
                                  Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child:
                                          Text(snapshot.data![i ~/ 2].reason!)),
                                  Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Text(snapshot.data![i ~/ 2].note!)),
                                  Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Text(amount, style: ts))
                                ],
                              );
                            }
                          }
                        })));
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
