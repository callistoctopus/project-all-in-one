/*
 * @Author: gui-qi
 * @Date: 2022-11-07 14:13:11
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-07 14:16:49
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
}
