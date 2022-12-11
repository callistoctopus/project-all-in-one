/*
 * @Author: gui-qi
 * @Date: 2022-11-02 15:26:48
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-12-11 22:36:18
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
      this.selectedColor = const Color(0xFF619ac3),
      this.backgroundColor = const Color(0xFFFFFFFF),
      this.enableAdd = false,
      this.onAdd,
      this.direction,
      required this.onLongPress});

  final List<String> dataList;
  final Function(int) onSelect;
  final Function(int) onLongPress;
  void Function()? onAdd;
  Color selectedColor;
  Color backgroundColor;
  bool enableAdd;
  int? defaultSelect = 0;
  Axis? direction;

  @override
  State<CustomChoiceChip> createState() => _CustomChoiceChipState();
}

class _CustomChoiceChipState extends State<CustomChoiceChip>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    if (widget.enableAdd && (widget.dataList.isEmpty || widget.dataList.last != "+")) {
      widget.dataList.add("+");
    }
    return Padding(
        padding: const EdgeInsets.only(left: 11, top: 8.0),
        child: Wrap(
          direction: widget.direction ?? Axis.horizontal,
          children: List<Widget>.generate(
            widget.dataList.length,
            (int index) {
              return Padding(
                  padding:
                      const EdgeInsets.only(top: 2.0, right: 8.0, bottom: 6),
                  child: GestureDetector(
                      onLongPress: () {
                        widget.onLongPress(index);
                        setState(() {});
                      },
                      child: ChoiceChip(
                        backgroundColor: widget.backgroundColor,
                        shadowColor: Colors.white,
                        selectedShadowColor: widget.selectedColor,
                        selectedColor: widget.selectedColor,
                        surfaceTintColor: widget.defaultSelect == index
                            ? widget.selectedColor
                            : Colors.white,
                        side: index == widget.dataList.length - 1 &&
                                widget.enableAdd
                            ? const BorderSide(
                                width: 0, color: Colors.blueAccent)
                            : widget.defaultSelect == index
                                ? BorderSide(
                                    width: 0, color: widget.selectedColor)
                                : const BorderSide(
                                    width: 0, color: Color(0xFF8a988e)),
                        label: Text(
                          widget.dataList[index],
                          style: widget.defaultSelect == index ? const TextStyle(fontSize: 16,color: Color(0xFFFFFFFF)) : const TextStyle(fontSize: 16,color: Color(0xFF8a988e)),
                        ),
                        selected: widget.defaultSelect == index,
                        labelStyle: index == widget.dataList.length - 1 &&
                                widget.enableAdd
                            ? const TextStyle(color: Colors.blueAccent)
                            : widget.defaultSelect == index
                                ? const TextStyle(color: Colors.white)
                                : const TextStyle(color: Colors.black),
                        onSelected: (bool selected) {
                          if (widget.enableAdd &&
                              index == (widget.dataList.length - 1) &&
                              widget.onAdd != null) {
                            widget.onAdd!();
                          } else {
                            setState(() {
                              widget.defaultSelect = selected ? index : 0;
                            });
                            widget.onSelect(index);
                          }
                        },
                      )));
            },
          ).toList(),
        ));
  }
}
