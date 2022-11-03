/*
 * @Author: gui-qi
 * @Date: 2022-10-26 08:18:13
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-03 10:26:01
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:flutter/material.dart';
import 'anaysis_page.dart';

void main() {


  
  runApp(MaterialApp(
    theme: ThemeData(
      colorSchemeSeed:const Color.fromARGB(255, 169, 192, 35),
      useMaterial3: true,
      visualDensity: VisualDensity.standard,
    ),
    home: const Scaffold(body: AnaysisPage()),
  ));
}
