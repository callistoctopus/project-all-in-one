/*
 * @Author: gui-qi
 * @Date: 2022-10-29 01:37:32
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-03 07:00:45
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */

//flutter pub add fl_chart
//flutter pub add http
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
  late Future<List<_Detail>> futureAlbum;

  final ScrollController _firstController = ScrollController();

  Future<List<_Detail>> fetchAlbum() async {
    final response = await http
        .post(Uri.parse('http://139.224.11.164:8080/api/query/detail'));

    if (response.statusCode == 200) {
      return _Parser.fromJson(jsonDecode(response.body));
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
      child: FutureBuilder<List<_Detail>>(
        future: futureAlbum,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // return Text(snapshot.data!.id);
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, i) {
                  return Card(
                      child: Wrap(
                    children: [
                      Text(snapshot.data![i].user),
                      Text(snapshot.data![i].time),
                      Text(snapshot.data![i].reason),
                      Text(snapshot.data![i].type.toString()),
                      Text(snapshot.data![i].amount.toString()),
                      Text(snapshot.data![i].note),
                    ],
                  ));
                });
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

class _Detail {
  final String id;
  final String user;
  final String time;
  final String reason;
  final int type;
  final double amount;
  final String note;

  const _Detail({
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
  static List<_Detail> fromJson(Map<String, dynamic> json) {
    List<_Detail> ret = [];
    json['data'].forEach((value) {
      ret.add(_Detail(
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
