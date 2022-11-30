/*
 * @Author: gui-qi
 * @Date: 2022-11-07 14:13:11
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-30 14:51:33
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:intl/intl.dart';

class CommonUtils {
  static DateTime now() {
    return DateFormat('yyyy-MM-dd hh:mm:ss')
        .parse(DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now()));
  }

  static DateTime nowWithoutTime() {
    return DateFormat('yyyy-MM-dd')
        .parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));
  }

  static DateTime format(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd hh:mm:ss')
        .parse(DateFormat('yyyy-MM-dd hh:mm:ss').format(dateTime));
  }

  static num formatNum(num value, int position) {
    if (value.toString().length - (value.toString().lastIndexOf(".") - 1) >
        position) {
      value = double.tryParse(value
              .toStringAsFixed(position)
              .substring(0, value.toString().lastIndexOf(".") + position + 1)
              .toString()) ??
          0.0;
    }
    return value;
  }
}
