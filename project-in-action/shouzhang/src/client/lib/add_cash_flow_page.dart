/*
 * @Author: gui-qi
 * @Date: 2022-10-26 15:06:57
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-01 10:30:41
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
// #docregion MyApp
import 'package:flutter/material.dart';
import 'component/icon_flow_buttons.dart';
import 'component/icon_toggle_buttons.dart';

class AddCashFlowPage extends StatefulWidget {
  const AddCashFlowPage({super.key});

  @override
  State<AddCashFlowPage> createState() => _AddCashFlowPageState();
}

class _AddCashFlowPageState extends State<AddCashFlowPage> {
  var money = "";
  var inout = 0;

  @override
  Widget build(BuildContext context) {
    Map<IconData, Function> para = {
      // Icons.arrow_back_ios: (){},
      Icons.cancel: () {
        Navigator.pop(context);
      },
      Icons.save: () {
        Navigator.pop(context);
      }
    };

    Widget reason() {
      Widget reason1 = Padding(
          padding: const EdgeInsets.only(left: 3, top: 0),
          child: IconToggleButtons2(
            icon: const [
              Icons.shopping_basket,
              Icons.restaurant,
              Icons.shopping_bag,
              Icons.attach_money,
              Icons.water_drop
            ],
            label: const [
              '支出',
              '收入',
              '买菜',
              '房租',
              '水电',
            ],
            onSelect: (indexs) {},
            isSingle: true,
          ));

      Widget reason2 = Padding(
          padding: const EdgeInsets.only(left: 3, top: 0),
          child: IconToggleButtons2(
            icon: const [
              Icons.attach_money,
              Icons.work,
              Icons.people,
            ],
            label: const [
              '工资',
              '外快',
              '人情',
            ],
            onSelect: (indexs) {},
            isSingle: true,
          ));
      return inout == 0 ? reason1 : reason2;
    }

    // #docregion itemBuilder
    return Scaffold(
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 12, top: 3),
            child: const Text(style: TextStyle(fontSize: 12), "记一笔"),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 3, top: 6, right: 0),
            child: IconToggleButtons2(
              icon: const [Icons.output, Icons.input],
              label: const ['支出', '收入'],
              onSelect: (indexs) {
                if(indexs.isNotEmpty && inout != indexs[0]){
                  inout = indexs[0];
                  setState(() {
                    
                  });
                };
              },
              isSingle: true,
            ),
          ),
          reason(),
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
      ),
      floatingActionButton: FlowMenu(menuMap: para),
    );
  }
}
