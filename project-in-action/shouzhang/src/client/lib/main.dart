/*
 * @Author: gui-qi
 * @Date: 2022-10-26 08:18:13
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-05 03:38:07
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:flutter/material.dart';
import 'page/anaysis_page.dart';

void main() {


  
  runApp(MaterialApp(
    theme: ThemeData(
      colorSchemeSeed:Color.fromARGB(255, 192, 189, 35),
      useMaterial3: true,
      visualDensity: VisualDensity.standard,
    ),
    home: const Scaffold(body: AnaysisPage()),
  ));
}
