/*
 * @Author: gui-qi
 * @Date: 2022-11-21 03:13:24
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-12-08 21:44:28
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:flutter/material.dart';

class CustomChart extends StatefulWidget {
  CustomChart(
      {super.key,
      required this.title,
      required this.child,
      this.link = "",
      this.callback,
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
    return SizedBox(
        height: widget.height,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 2, top: 3, right: 2),
              height: 20,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(fontSize: 12,color: Color(0xFFCCCCFF)),
                    ),
                    GestureDetector(
                        onTap: widget.callback ?? () {},
                        child: Text(widget.link != "" ? "${widget.link} >" : "",
                            style: const TextStyle(
                                fontSize: 12, color: Colors.blueAccent)))
                  ])),
          SizedBox(height: widget.height - 20, child: widget.child)
        ]));
  }
}

class CustomChartDynamic extends StatefulWidget {
  CustomChartDynamic({
    super.key,
    required this.title,
    required this.child,
    this.link = "",
    this.callback,
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
    return ListView(
        shrinkWrap: true,
        children: [
          Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 2, top: 3, right: 2),
              height: 20,
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
        ]);
  }
}
