/*
 * @Author: gui-qi
 * @Date: 2022-10-29 01:37:32
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-04 02:21:41
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
                body: ListView.builder(
                    itemCount: snapshot.data!.length * 2,
                    itemBuilder: (context, i) {
                      if (i % 2 == 0) {
                        return const Divider();
                      }

                      var pre = "-";
                      TextStyle ts = const TextStyle(
                          color: Color.fromARGB(10, 122, 167, 116));
                      if (snapshot.data![i ~/ 2].type == 1) {
                        pre = '+';
                        ts = const TextStyle(
                            color: Color.fromARGB(0, 241, 3, 3));
                      }

                      String amount =
                          pre + snapshot.data![i ~/ 2].amount.toString();

                      return Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 10,
                        children: [
                          Text(snapshot.data![i ~/ 2].time.substring(0, 10)),
                          Text(snapshot.data![i ~/ 2].reason),
                          Text(snapshot.data![i ~/ 2].note),
                          Text(amount),
                        ],
                      );
                    }));
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
