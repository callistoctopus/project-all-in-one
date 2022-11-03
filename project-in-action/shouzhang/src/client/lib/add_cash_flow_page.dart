/*
 * @Author: gui-qi
 * @Date: 2022-10-26 15:06:57
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-03 14:27:39
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'dart:convert';

import 'package:client/component/custom_float_button.dart';
import 'package:flutter/material.dart';
import 'component/icon_toggle_buttons.dart';
import 'package:http/http.dart' as http;

class AddCashFlowPage extends StatefulWidget {
  const AddCashFlowPage({super.key});

  @override
  State<AddCashFlowPage> createState() => _AddCashFlowPageState();
}

class _AddCashFlowPageState extends State<AddCashFlowPage> {
  late Future<List<FinancialReason>> rl1;
  late Future<List<FinancialReason>> rl2;

  var user = "";
  var time = DateTime(2022);
  var reason = "";
  var type = "支出";
  var amount = "";
  var note = '';
  int _value = 0;

  Future<List<FinancialReason>> fetchFinancialOut() async {
    final response = await http
        .post(Uri.parse('http://139.224.11.164:8080/api/query/financial/0'));

    if (response.statusCode == 200) {
      return _Parser.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to load album')));
      return [];
    }
  }

  Future<List<FinancialReason>> fetchFinancialIn() async {
    final response = await http
        .post(Uri.parse('http://139.224.11.164:8080/api/query/financial/1'));

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
      rl1 = fetchFinancialOut();
      rl2 = fetchFinancialIn();
    } on Exception {}
  }

  @override
  Widget build(BuildContext context) {
    Map<IconData, Function> para = {
      Icons.cancel: () {
        Navigator.pop(context);
      },
      Icons.save: () async {
        final response = await http.post(
          Uri.parse('http://139.224.11.164:8080/api/add/detail'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'amount': double.parse(this.amount),
            'note': this.note,
            'reason': this.reason,
            'time': '',
            'type': this.type == '支出' ? 0 : 1,
            'user': 'test',
          }),
        );

        if (response.statusCode == 200) {
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Failed to load album')));
          return;
        }
      }
    };

    Widget reason() {
      FutureBuilder<List<FinancialReason>> reason1 =
          FutureBuilder<List<FinancialReason>>(
              future: rl1,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Wrap(
                    children: List<Widget>.generate(
                      snapshot.data!.length,
                      (int index) {
                        return ChoiceChip(
                          avatar: CircleAvatar(
                              backgroundColor: Colors.blue.shade900,
                              child: Text(snapshot.data![index].reason)),
                          label: Text(snapshot.data![index].reason),
                          selected: _value == index,
                          onSelected: (bool selected) {
                            setState(() {
                              _value = (selected ? index : null)!;
                            });
                          },
                        );
                      },
                    ).toList(),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                return const CircularProgressIndicator();
              });

      FutureBuilder<List<FinancialReason>> reason2 =
          FutureBuilder<List<FinancialReason>>(
              future: rl2,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Wrap(
                    children: List<Widget>.generate(
                      snapshot.data!.length,
                      (int index) {
                        return ChoiceChip(
                          avatar: CircleAvatar(
                              backgroundColor: Colors.blue.shade900,
                              child: Text(snapshot.data![index].reason)),
                          label: Text(snapshot.data![index].reason),
                          selected: _value == index,
                          onSelected: (bool selected) {
                            setState(() {
                              _value = (selected ? index : null)!;
                            });
                          },
                        );
                      },
                    ).toList(),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                return const CircularProgressIndicator();
              });
      return type == '支出' ? reason1 : reason2;
    }

    // #docregion itemBuilder
    return PageWithFloatButton(
        funcIcon: para,
        child: Scaffold(
          body: ListView(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(left: 12, top: 3),
                child: const Text(style: TextStyle(fontSize: 12), "记一笔"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3, top: 6, right: 0),
                child: IconToggleButtons(
                  labelIcon: const {'支出': Icons.output, '收入': Icons.input},
                  onSelect: (lables) {
                    if (lables.isNotEmpty && type != lables[0]) {
                      type = lables[0];
                      setState(() {});
                    }
                  },
                  isSingle: true,
                  defaultSelected: type,
                ),
              ),
              reason(),
              Container(
                height: 70, //这里调整高度即可，建议按照屏幕高度比例来计算
                padding: const EdgeInsets.only(
                    left: 16, top: 15, right: 16, bottom: 0),
                // margin: const EdgeInsets.only(top:5),
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
                    amount = text;
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: '备注',
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class FinancialReason {
  final String id;
  final String user;
  final int type;
  final String reason;
  final String note;

  const FinancialReason({
    required this.id,
    required this.user,
    required this.reason,
    required this.type,
    required this.note,
  });
}

class _Parser {
  static List<FinancialReason> fromJson(Map<String, dynamic> json) {
    List<FinancialReason> ret = [];
    json['data'].forEach((value) {
      ret.add(FinancialReason(
        id: value["id"] ?? "",
        user: value['user'] ?? "",
        type: value['type'] ?? "",
        reason: value['reason'] ?? "",
        note: value['note'] ?? "",
      ));
    });
    return ret;
  }
}
