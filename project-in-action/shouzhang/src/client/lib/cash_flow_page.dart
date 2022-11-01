/*
 * @Author: gui-qi
 * @Date: 2022-10-29 01:37:32
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-01 08:16:47
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */

//flutter pub add fl_chart
//flutter pub add http
import 'dart:convert';

import 'package:flutter/material.dart';
import 'component/icon_flow_buttons.dart';
import 'package:http/http.dart' as http;

class CashFlowPage extends StatefulWidget {
  const CashFlowPage({super.key});

  @override
  State<CashFlowPage> createState() => _CashFlowPageState();
}

class _CashFlowPageState extends State<CashFlowPage> {
  late Future<List<_Detail>> futureAlbum;

  Future<List<_Detail>> fetchAlbum() async {
    final response = await http
        .post(Uri.parse('http://139.224.11.164:8080/api/query/detail'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return _Parser.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
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
    Map<IconData, Function> para = {
      Icons.arrow_back_ios: () {
        Navigator.pop(context);
      },
    };

    return Scaffold(
      body: FutureBuilder<List<_Detail>>(
        future: futureAlbum,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // return Text(snapshot.data!.id);
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, i) {
                  return Row(
                    children: [
                      Text(snapshot.data![i].id),
                      Text(snapshot.data![i].user),
                      Text(snapshot.data![i].time),
                      Text(snapshot.data![i].reason),
                      Text(snapshot.data![i].type.toString()),
                      Text(snapshot.data![i].amount.toString()),
                      Text(snapshot.data![i].note),
                    ],
                  );
                });
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ),
      floatingActionButton: FlowMenu(menuMap: para),
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

  // fromJson(Map<String, dynamic> json) {
  //   return List<_Detail>(
  //     id: json['data'][0]["id"],
  //     user: json['data'][0]['user'],
  //     time: json['data'][0]['time'],
  //     reason: json['data'][0]['reason'],
  //     type: json['data'][0]['type'],
  //     amount: json['data'][0]['amount'],
  //     note: json['data'][0]['note'],
  //   );
  // }
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
        note: value['note'],
      ));
    });
    return ret;
  }
}
