/*
 * @Author: gui-qi
 * @Date: 2022-10-26 08:18:13
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-23 08:37:32
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/config/route.dart';
import 'package:client/page/data_model/bill_vo.dart';
import 'package:client/service/local_database_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await DB.init();

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<BillVO>(create: (_) => BillVO()),
      ],
      child: MaterialApp.router(
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            fontFamily: "YangRenDongZhuShiTi-Light"),
        routerConfig: RouteConfig.routeConfig(),
      )));
}
