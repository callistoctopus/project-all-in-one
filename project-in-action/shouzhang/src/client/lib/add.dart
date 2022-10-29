/*
 * @Author: gui-qi
 * @Date: 2022-10-26 15:06:57
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-10-29 18:26:04
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
// #docregion MyApp

import 'package:flutter/material.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  // #docregion build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Shouzhizhuijia(),
      floatingActionButton: GestureDetector(
        onDoubleTap: (){Navigator.pop(context);},
          child: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.save),
      )),
      // This trailing comma makes auto-formatting nicer for build methods.
      // ),
    );
  }
  // #enddocregion build
}
// #enddocregion MyApp

class Shouzhizhuijia extends StatefulWidget {
  const Shouzhizhuijia({super.key});

  @override
  State<Shouzhizhuijia> createState() => _ShouzhizhuijiaState();
}

// #docregion RWS-var
class _ShouzhizhuijiaState extends State<Shouzhizhuijia> {
  final _biggerFont = const TextStyle(fontSize: 17);
  // #enddocregion RWS-var

  // #docregion RWS-build
  @override
  Widget build(BuildContext context) {
    // #docregion itemBuilder

    return Column(
      children: [
        Text(
          "收入/支出",
          style: _biggerFont,
        ),
        const Divider(),
        Text(
          "类别",
          style: _biggerFont,
        ),
        const Divider(),
        Text(
          "金额",
          style: _biggerFont,
        ),
      ],
    );
  }
}
