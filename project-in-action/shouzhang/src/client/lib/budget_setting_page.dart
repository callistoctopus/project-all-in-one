/*
 * @Author: gui-qi
 * @Date: 2022-10-29 01:37:32
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-01 16:00:03
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

class BudgetSettingPage extends StatefulWidget {
  const BudgetSettingPage({super.key});

  @override
  State<BudgetSettingPage> createState() => _BudgetSettingPageState();
}

class _BudgetSettingPageState extends State<BudgetSettingPage> {
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
      Icons.cancel: () {
        Navigator.pop(context);
      },
      Icons.save: () {
        Navigator.pop(context);
      },
    };

    return Scaffold(
      body: Column(children: [
        Container(
          padding: const EdgeInsets.only(left: 0, top: 3),
          child: const Text(style: TextStyle(fontSize: 18), "月度预算"),
        ),
        Container(
          // margin: const EdgeInsets.symmetric(vertical: 20.0),
          height: 70.0,
          padding:
              const EdgeInsets.only(left: 16, top: 15, right: 16, bottom: 0),
          child: ListView(
            // This next line does the trick.
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              const Padding(
                  padding: EdgeInsets.only(left: 3, top: 15, right: 5),
                  child: Text(
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                      "交通")),
              SizedBox(
                width: 160.0,
                child: TextField(
                  textAlign: TextAlign.justify,
                  textAlignVertical: TextAlignVertical.center,
                  cursorHeight: 25,
                  // scrollPadding: EdgeInsets.all(2.0),
                  decoration: const InputDecoration(
                    prefixText: "￥",
                    border: OutlineInputBorder(),
                    hintText: '金额',
                  ),
                  onChanged: (String text) {
                    // money = text;
                  },
                ),
              ),
            ],
          ),
        ),
        Container(
          // margin: const EdgeInsets.symmetric(vertical: 20.0),
          height: 70.0,
          padding:
              const EdgeInsets.only(left: 16, top: 15, right: 16, bottom: 0),
          child: ListView(
            // This next line does the trick.
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              const Padding(
                  padding: EdgeInsets.only(left: 3, top: 15, right: 5),
                  child: Text(
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                      "买菜")),
              SizedBox(
                width: 160.0,
                child: TextField(
                  textAlign: TextAlign.justify,
                  textAlignVertical: TextAlignVertical.center,
                  cursorHeight: 25,
                  // scrollPadding: EdgeInsets.all(2.0),
                  decoration: const InputDecoration(
                    prefixText: "￥",
                    border: OutlineInputBorder(),
                    hintText: '金额',
                  ),
                  onChanged: (String text) {
                    // money = text;
                  },
                ),
              ),
            ],
          ),
        ),
        Container(
          // margin: const EdgeInsets.symmetric(vertical: 20.0),
          height: 70.0,
          padding:
              const EdgeInsets.only(left: 16, top: 15, right: 16, bottom: 0),
          child: ListView(
            // This next line does the trick.
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              const Padding(
                  padding: EdgeInsets.only(left: 3, top: 15, right: 5),
                  child: Text(
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                      "水果")),
              SizedBox(
                width: 160.0,
                child: TextField(
                  textAlign: TextAlign.justify,
                  textAlignVertical: TextAlignVertical.center,
                  cursorHeight: 25,
                  // scrollPadding: EdgeInsets.all(2.0),
                  decoration: const InputDecoration(
                    prefixText: "￥",
                    border: OutlineInputBorder(),
                    hintText: '金额',
                  ),
                  onChanged: (String text) {
                    // money = text;
                  },
                ),
              ),
            ],
          ),
        ),
        Container(
          // margin: const EdgeInsets.symmetric(vertical: 20.0),
          height: 70.0,
          padding:
              const EdgeInsets.only(left: 16, top: 15, right: 16, bottom: 0),
          child: ListView(
            // This next line does the trick.
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              const Padding(
                  padding: EdgeInsets.only(left: 3, top: 15, right: 5),
                  child: Text(
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                      "房租")),
              SizedBox(
                width: 160.0,
                child: TextField(
                  textAlign: TextAlign.justify,
                  textAlignVertical: TextAlignVertical.center,
                  cursorHeight: 25,
                  // scrollPadding: EdgeInsets.all(2.0),
                  decoration: const InputDecoration(
                    prefixText: "￥",
                    border: OutlineInputBorder(),
                    hintText: '金额',
                  ),
                  onChanged: (String text) {
                    // money = text;
                  },
                ),
              ),
            ],
          ),
        ),Container(
          // margin: const EdgeInsets.symmetric(vertical: 20.0),
          height: 70.0,
          padding:
              const EdgeInsets.only(left: 16, top: 15, right: 16, bottom: 0),
          child: ListView(
            // This next line does the trick.
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              const Padding(
                  padding: EdgeInsets.only(left: 3, top: 15, right: 5),
                  child: Text(
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                      "房贷")),
              SizedBox(
                width: 160.0,
                child: TextField(
                  textAlign: TextAlign.justify,
                  textAlignVertical: TextAlignVertical.center,
                  cursorHeight: 25,
                  // scrollPadding: EdgeInsets.all(2.0),
                  decoration: const InputDecoration(
                    prefixText: "￥",
                    border: OutlineInputBorder(),
                    hintText: '金额',
                  ),
                  onChanged: (String text) {
                    // money = text;
                  },
                ),
              ),
            ],
          ),
        ),Container(
          // margin: const EdgeInsets.symmetric(vertical: 20.0),
          height: 70.0,
          padding:
              const EdgeInsets.only(left: 16, top: 15, right: 16, bottom: 0),
          child: ListView(
            // This next line does the trick.
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              const Padding(
                  padding: EdgeInsets.only(left: 3, top: 15, right: 5),
                  child: Text(
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                      "生活")),
              SizedBox(
                width: 160.0,
                child: TextField(
                  textAlign: TextAlign.justify,
                  textAlignVertical: TextAlignVertical.center,
                  cursorHeight: 25,
                  // scrollPadding: EdgeInsets.all(2.0),
                  decoration: const InputDecoration(
                    prefixText: "￥",
                    border: OutlineInputBorder(),
                    hintText: '金额',
                  ),
                  onChanged: (String text) {
                    // money = text;
                  },
                ),
              ),
            ],
          ),
        ),
      ]),

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
