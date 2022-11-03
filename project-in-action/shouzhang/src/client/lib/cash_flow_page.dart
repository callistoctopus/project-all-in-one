/*
 * @Author: gui-qi
 * @Date: 2022-10-29 01:37:32
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-03 08:51:58
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'dart:convert';

import 'package:client/component/custom_float_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CashFlowPage extends StatefulWidget {
  const CashFlowPage({super.key});

  @override
  State<CashFlowPage> createState() => _CashFlowPageState();
}

class _CashFlowPageState extends State<CashFlowPage> {
  late Future<List<Detail>> futureAlbum;

  final ScrollController _firstController = ScrollController();

  Future<List<Detail>> fetchAlbum() async {
    final response = await http
        .post(Uri.parse('http://139.224.11.164:8080/api/query/detail'));

    if (response.statusCode == 200) {
      return _Parser.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to load album')));
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    try {
      futureAlbum = fetchAlbum();
    } on Exception {}
  }

  @override
  Widget build(BuildContext context) {
    return PageWithFloatButton(
      child: FutureBuilder<List<Detail>>(
        future: futureAlbum,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // return Text(snapshot.data!.id);
            return Scaffold(body: ListView.builder(
                itemCount: snapshot.data!.length*2,
                itemBuilder: (context, i) {
                  if(i%2 == 0){
                    return const Divider();
                  }

                  var pre = "-";
                  TextStyle ts =
                      const TextStyle(color: Color.fromARGB(10, 122, 167, 116));
                  if (snapshot.data![i~/2].type == 1) {
                    pre = '+';
                    ts = const TextStyle(color: Color.fromARGB(0, 241, 3, 3));
                  }

                  String amount = pre + snapshot.data![i~/2].amount.toString();

                  return 
                      Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 10,
                    children: [
                      Text(snapshot.data![i~/2].time.substring(0, 10)),
                      Text(snapshot.data![i~/2].reason),
                      Text(snapshot.data![i~/2].note),
                      Text(amount),
                    ],
                  );
                }));
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}

class Detail {
  final String id;
  final String user;
  final String time;
  final String reason;
  final int type;
  final double amount;
  final String note;

  const Detail({
    required this.id,
    required this.user,
    required this.time,
    required this.reason,
    required this.type,
    required this.amount,
    required this.note,
  });
}

class _Parser {
  static List<Detail> fromJson(Map<String, dynamic> json) {
    List<Detail> ret = [];
    json['data'].forEach((value) {
      ret.add(Detail(
        id: value["id"],
        user: value['user'],
        time: value['time'],
        reason: value['reason'],
        type: value['type'],
        amount: value['amount'],
        note: value['note'] ?? "",
      ));
    });
    return ret;
  }
}
