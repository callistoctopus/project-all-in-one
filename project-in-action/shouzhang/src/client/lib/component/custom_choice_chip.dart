/*
 * @Author: gui-qi
 * @Date: 2022-11-02 15:26:48
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-16 13:39:57
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:flutter/material.dart';

class CustomChoiceChip extends StatefulWidget {
  CustomChoiceChip(
      {super.key,
      required this.dataList,
      required this.onSelect,
      this.defaultSelect,
      required this.onLongPress});

  final List<String> dataList;
  final Function(int) onSelect;
  final Function(int) onLongPress;
  int? defaultSelect = 0;

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
                  child: GestureDetector(
                      onLongPress: () {
                        widget.onLongPress(index);
                        setState(() {});
                      },
                      child: ChoiceChip(
                        backgroundColor: Colors.white,
                        selectedColor:Colors.lightBlue.shade300,
                        padding: const EdgeInsets.all(2),
                        side: widget.defaultSelect == index ? BorderSide(width: 0, color: Colors.lightBlue.shade300) : const BorderSide(width: 0, color: Colors.grey),
                        label: Text(widget.dataList[index]),
                        selected: widget.defaultSelect == index,
                        onSelected: (bool selected) {
                          widget.onSelect(index);
                          setState(() {
                            widget.defaultSelect = selected ? index : 0;
                          });
                        },
                      )));
            },
          ).toList(),
        ));
  }
}
