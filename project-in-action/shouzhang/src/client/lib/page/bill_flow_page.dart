/*
 * @Author: gui-qi
 * @Date: 2022-10-29 01:37:32
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-09 13:20:36
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/model/persistent_object/bill.dart';
import 'package:flutter/material.dart';
import 'package:client/component/custom_float_button.dart';
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
                    child: ListView.separated(
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
                          var pre = "-";
                          TextStyle ts = const TextStyle(
                              color: Color.fromARGB(155, 25, 105, 0));
                          if (snapshot.data![i].type == 1) {
                            pre = '+';
                            ts = const TextStyle(
                                color: Color.fromARGB(155, 255, 0, 0));
                          }

                          String amount =
                              pre + snapshot.data![i].amount.toString();

                          return Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Text(snapshot.data![i].time
                                      .toString()
                                      .substring(0, 10))),
                              Expanded(
                                  flex: 2, child: Text(snapshot.data![i].user)),
                              Expanded(
                                  flex: 2,
                                  child: Text(snapshot.data![i].reason)),
                              Expanded(flex: 1, child: Text(amount, style: ts)),
                            ],
                          );
                        }
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                    )));
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
