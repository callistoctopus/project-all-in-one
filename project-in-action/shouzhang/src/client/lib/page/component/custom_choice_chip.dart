/*
 * @Author: gui-qi
 * @Date: 2022-11-02 15:26:48
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-21 15:28:09
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
      this.backgroundColor = Colors.lightBlue,
      required this.onLongPress});

  final List<String> dataList;
  final Function(int) onSelect;
  final Function(int) onLongPress;
  Color backgroundColor = Colors.lightBlue;
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
                        shadowColor: Colors.white,
                        selectedShadowColor: widget.backgroundColor,
                        selectedColor: widget.backgroundColor,
                        surfaceTintColor: widget.defaultSelect == index
                            ? widget.backgroundColor
                            : Colors.white,
                        side: widget.defaultSelect == index
                            ? BorderSide(
                                width: 0, color: widget.backgroundColor)
                            : const BorderSide(width: 0, color: Colors.grey),
                        label: Text(widget.dataList[index]),
                        selected: widget.defaultSelect == index,
                        labelStyle: widget.defaultSelect == index
                            ? const TextStyle(color: Colors.white)
                            : const TextStyle(color: Colors.black),
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
