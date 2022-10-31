/*
 * @Author: gui-qi
 * @Date: 2022-10-26 15:06:57
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-10-31 09:18:22
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
// #docregion MyApp
import 'package:flutter/material.dart';
import 'component/icon_toggle_button.dart';

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
              // Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back),
          )),
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

class _ShouzhizhuijiaState extends State<Shouzhizhuijia> {
  var money = "";

  @override
  Widget build(BuildContext context) {
    // #docregion itemBuilder
    return ListView(
      // mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 12, top: 3),
          child: const Text(style: TextStyle(fontSize: 12), "记一笔"),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 3, top: 6, right: 0),
          child: Row(children:  [
            IconToggleButtons(
              icon: Icons.output,
              label: '支出',
              onPressed: (){},
            ),
            IconToggleButtons(
              icon: Icons.input,
              label: '收入',
              onPressed: (){},
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 3, top: 0),
          child: Row(
            children: [
              IconToggleButtons(
                icon: Icons.shopping_basket,
                label: '买菜',
                onPressed: (){},
              ),
              IconToggleButtons(
                icon: Icons.restaurant,
                label: '吃饭',
                onPressed: (){},
              ),
              IconToggleButtons(
                icon: Icons.shopping_bag,
                label: '买衣服',
                onPressed: (){},
              ),
              IconToggleButtons(
                icon: Icons.attach_money,
                label: '房租',
                onPressed: (){},
              ),
              IconToggleButtons(
                icon: Icons.water_drop,
                label: '水电',
                onPressed: (){},
              ),
            ],
          ),
        ),
        Container(
          height: 70, //这里调整高度即可，建议按照屏幕高度比例来计算
          padding:
              const EdgeInsets.only(left: 16, top: 15, right: 16, bottom: 0),
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
              money = text;
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
    );
  }
}
