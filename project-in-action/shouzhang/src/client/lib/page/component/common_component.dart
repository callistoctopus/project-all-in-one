/*
 * @Author: gui-qi
 * @Date: 2022-11-21 03:13:24
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-23 00:40:28
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
                      style: const TextStyle(fontSize: 12),
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

class CustomChart2 extends StatefulWidget {
  CustomChart2(
      {super.key,
      required this.title,
      required this.child,
      this.link = "",
      this.callback,});

  String title;
  Widget child;
  String link;
  void Function()? callback;

  @override
  State<StatefulWidget> createState() => _CustomChartState2();
}

class _CustomChartState2 extends State<CustomChart2> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                      style: const TextStyle(fontSize: 12),
                    ),
                    GestureDetector(
                        onTap: widget.callback ?? () {},
                        child: Text(widget.link != "" ? "$widget.link >" : "",
                            style: const TextStyle(
                                fontSize: 12, color: Colors.blueAccent)))
                  ])),
          SizedBox(child: widget.child)
        ]));
  }
}
