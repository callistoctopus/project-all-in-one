/*
 * @Author: gui-qi
 * @Date: 2022-10-26 08:18:13
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-22 05:38:26
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/config/route.dart';
import 'package:client/service/local_database_service.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await DB.init();

  runApp(MaterialApp.router(
    theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: "YangRenDongZhuShiTi-Light"),
    routerConfig: RouteConfig.routeConfig(),
  ));
}
