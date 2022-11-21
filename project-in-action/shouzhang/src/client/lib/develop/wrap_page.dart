/*
 * @Author: gui-qi
 * @Date: 2022-10-29 01:37:32
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-02 16:22:03
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/page/component/custom_float_button.dart';
import 'package:flutter/material.dart';

class WarpPage extends StatefulWidget {
  const WarpPage({super.key});

  @override
  State<WarpPage> createState() => _WarpPageState();
}

class _WarpPageState extends State<WarpPage> {
  int _value = 0;

  @override
  Widget build(BuildContext context) {
    return PageWithFloatButton(
        child: Scaffold(
      body: Wrap(
        children: List<Widget>.generate(
          12,
          (int index) {
            return ChoiceChip(
              avatar: CircleAvatar(
                  backgroundColor: Colors.blue.shade900,
                  child: const Text('地')),
              label: Text('Item $index'),
              selected: _value == index,
              onSelected: (bool selected) {
                setState(() {
                  _value = (selected ? index : null)!;
                });
              },
            );
          },
        ).toList(),
      ),
    ));
  }
}
