/*
 * @Author: gui-qi
 * @Date: 2022-10-26 15:06:57
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-10-30 15:45:21
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
// #docregion MyApp

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

enum Sky { midnight, viridian, cerulean }

Map<Sky, Color> skyColors = <Sky, Color>{
  // Sky.midnight: const Color(0xff191970),
  Sky.viridian: const Color(0xff40826d),
  Sky.cerulean: const Color(0xff007ba7),
};

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  // #docregion build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Shouzhizhuijia(),
      floatingActionButton: GestureDetector(
          onDoubleTap: () {
            Navigator.pop(context);
          },
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
  Sky _selectedSegment = Sky.viridian;
  // #docregion RWS-build
  @override
  Widget build(BuildContext context) {
    // #docregion itemBuilder

    return CupertinoPageScaffold(
      backgroundColor: skyColors[_selectedSegment],
      navigationBar: CupertinoNavigationBar(
        // This Cupertino segmented control has the enum "Sky" as the type.
        middle: CupertinoSlidingSegmentedControl<Sky>(
          backgroundColor: CupertinoColors.systemGrey2,
          thumbColor: skyColors[_selectedSegment]!,
          // This represents the currently selected segmented control.
          groupValue: _selectedSegment,
          // Callback that sets the selected segmented control.
          onValueChanged: (Sky? value) {
            if (value != null) {
              setState(() {
                _selectedSegment = value;
              });
            }
          },
          children: const <Sky, Widget>{
            // Sky.midnight: Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 20),
            //   child: Text(
            //     'Midnight',
            //     style: TextStyle(color: CupertinoColors.white),
            //   ),
            // ),
            Sky.viridian: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '支出',
                style: TextStyle(color: CupertinoColors.white),
              ),
            ),
            Sky.cerulean: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '收入',
                style: TextStyle(color: CupertinoColors.white),
              ),
            ),
          },
        ),
      ),
      child: 
         Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 64),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: '金额',
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: '金额',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: '备注',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
