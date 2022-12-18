/*
 * @Author: gui-qi
 * @Date: 2022-11-21 03:13:24
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-12-11 22:21:16
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:flutter/material.dart';

class CustomChart extends StatefulWidget {
  CustomChart(
      {super.key,
      this.title = "",
      this.link = "",
      this.callback,
      required this.child,
      this.height = 150});

  String title;
  Widget child;
  String link;
  void Function()? callback;
  double height;

  @override
  State<StatefulWidget> createState() => _CustomChartState();
}

class _CustomChartState extends State<CustomChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.height,
        padding: const EdgeInsets.only(bottom: 8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 2, top: 3, right: 2),
              height: 15,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xFFCCCCFF)),
                    ),
                    GestureDetector(
                        onTap: widget.callback ?? () {},
                        child: Text(widget.link != "" ? "${widget.link} >" : "",
                            style: const TextStyle(
                                fontSize: 12, color: Colors.blueAccent)))
                  ])),
          SizedBox(height: widget.height - 23, child: widget.child),
        ]));
  }
}

class CustomChartDynamic extends StatefulWidget {
  CustomChartDynamic({
    super.key,
    required this.title,
    this.link = "",
    this.callback,
    required this.child,
  });

  String title;
  Widget child;
  String link;
  void Function()? callback;

  @override
  State<StatefulWidget> createState() => _CustomChartDynamicState();
}

class _CustomChartDynamicState extends State<CustomChartDynamic> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 13),
        child: ListView(shrinkWrap: true, children: [
          Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 2, top: 3, right: 2),
              height: 13,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(fontSize: 12),
                    ),
                    GestureDetector(
                        onTap: widget.callback ?? () {},
                        child: Text(widget.link != "" ? "${widget.link} >" : "",
                            style: const TextStyle(
                                fontSize: 12, color: Colors.blueAccent)))
                  ])),
          widget.child
        ]));
  }
}
