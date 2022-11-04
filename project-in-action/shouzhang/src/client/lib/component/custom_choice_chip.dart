/*
 * @Author: gui-qi
 * @Date: 2022-11-02 15:26:48
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-04 05:06:15
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:flutter/material.dart';

class CustomChoiceChip extends StatefulWidget {
  CustomChoiceChip({super.key, required this.dataList});

  final List<String> dataList;
  int _value = 0;

  @override
  State<CustomChoiceChip> createState() => _CustomChoiceChipState();
}

class _CustomChoiceChipState extends State<CustomChoiceChip>
    with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 13, top: 8.0, bottom: 8),
        child: Wrap(
          children: List<Widget>.generate(
            widget.dataList.length,
            (int index) {
              return Padding(
                  padding:
                      const EdgeInsets.only(top: 5.0, right: 10.0, bottom: 5),
                  child: ChoiceChip(
                    padding: const EdgeInsets.all(2),
                    side: BorderSide(
                        width: 0, color: Theme.of(context).primaryColor),
                    label: Text(widget.dataList[index]),
                    selected: widget._value == index,
                    onSelected: (bool selected) {
                      setState(() {
                        widget._value = selected ? index : 0;
                      });
                    },
                  ));
            },
          ).toList(),
        ));
  }
}