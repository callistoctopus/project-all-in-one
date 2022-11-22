/*
 * @Author: gui-qi
 * @Date: 2022-11-21 03:13:24
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-22 02:53:13
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:flutter/material.dart';

class COMMON_COMPONENT {

  static Widget chart(
      String title, String link, Function callback, Widget child,
      {double height = 150}) {
    return SizedBox(
        height: height,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 2, top: 3, right: 2),
              height: 20,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 12),
                    ),
                    GestureDetector(
                        onTap: () => callback(),
                        child: Text(link,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.blueAccent)))
                  ])),
          SizedBox(height: height - 20, child: child)
        ]));
  }
}