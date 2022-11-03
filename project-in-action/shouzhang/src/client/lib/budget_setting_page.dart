/*
 * @Author: gui-qi
 * @Date: 2022-10-29 01:37:32
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-03 13:54:49
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'dart:convert';

import 'package:client/add_financial_reason_page.dart';
import 'package:client/component/custom_float_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BudgetSettingPage extends StatefulWidget {
  const BudgetSettingPage({super.key});

  @override
  State<BudgetSettingPage> createState() => _BudgetSettingPageState();
}

class _BudgetSettingPageState extends State<BudgetSettingPage> {
  late Future<List<_Budget>> futureAlbum;

  Future<List<_Budget>> fetchAlbum() async {
    final response = await http
        .post(Uri.parse('http://139.224.11.164:8080/api/query/budget'));

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
    Map<IconData, Function> para = {
      Icons.cancel: () {
        Navigator.pop(context);
      },
      Icons.save: () {
        Navigator.pop(context);
      },
    };

    fun() {
      showBottomSheet(
          context: context,
          builder: (context) => const SizedBox(
                height: 380,
                child: AddFinancialReasonPage(),
              ));
    }

    return PageWithFloatButton(
        funcIcon: para,
        child: Scaffold(
          body: FutureBuilder<List<_Budget>>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.length + 1,
                    itemBuilder: (context, i) {
                      if (i == snapshot.data!.length) {
                        return TextButton(
                            onPressed: fun, child: const Text("追加"));
                      }

                      return InputWithTest(
                        text: snapshot.data![i].reason,
                        oldBudget: snapshot.data![i].amount.toString(),
                      );
                    });
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ));
  }
}

class InputWithTest extends StatefulWidget {
  const InputWithTest({super.key, required this.text, required this.oldBudget});

  final String text;
  final String oldBudget;

  @override
  State<InputWithTest> createState() => _InputWithTestState();
}

class _InputWithTestState extends State<InputWithTest> {
  var money = "";
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
            width: 100,
            child: Text(
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
                widget.text)),
        SizedBox(
          width: 140.0,
          child: TextField(
            textAlign: TextAlign.justify,
            textAlignVertical: TextAlignVertical.center,
            cursorHeight: 25,
            decoration: InputDecoration(
              prefixText: "￥",
              border: const UnderlineInputBorder(),
              hintText: widget.oldBudget,
            ),
            onChanged: (String text) {
              money = text;
            },
          ),
        ),
      ],
    );
  }
}

class _Budget {
  final String id;
  final String user;
  final String year;
  final String reason;
  final int type;
  final double amount;
  final String note;

  const _Budget({
    required this.id,
    required this.user,
    required this.year,
    required this.reason,
    required this.type,
    required this.amount,
    required this.note,
  });
}

class _Parser {
  static List<_Budget> fromJson(Map<String, dynamic> json) {
    List<_Budget> ret = [];

    json['data'].forEach((value) {
      ret.add(_Budget(
        id: value["id"] ?? "",
        user: value['user'] ?? "",
        year: value['year'] ?? "",
        reason: value['reason'] ?? "",
        type: value['type'] ?? 0,
        amount: value['budget'] ?? 0,
        note: value['note'] ?? "",
      ));
    });
    return ret;
  }
}
