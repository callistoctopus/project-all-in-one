/*
 * @Author: gui-qi
 * @Date: 2022-10-26 08:18:13
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-10-31 07:15:46
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */

// flutter pub add english_words
import 'package:flutter/material.dart';
import 'dashboard.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      colorSchemeSeed: const Color(0xff6750a4),
      useMaterial3: true,
      // Desktop and web platforms have a compact visual density by default.
      // To see buttons with circular background on desktop/web, the "visualDensity"
      // needs to be set to "VisualDensity.standard".
      visualDensity: VisualDensity.standard,
    ),
    title: 'Navigation Basics',
    home: const Scaffold(body:DashboardPage()),
  ));
}
