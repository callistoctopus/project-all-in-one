/*
 * @Author: gui-qi
 * @Date: 2022-11-04 15:49:28
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-04 16:12:10
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';

class CommonConst {
  static Map<String, IconData> ICONS = {
    'ADD': Iconsax.add,
    'BUG': Icons.bug_report_rounded,
    'LIST': Iconsax.receipt,
    'BUDGET': Iconsax.activity,
    'FILTER': Iconsax.filter_search,
    'BACK': Iconsax.back_square,
    'SAVE': FontAwesomeIcons.save,
  };
}
