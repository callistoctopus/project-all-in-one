/*
 * @Author: gui-qi
 * @Date: 2022-10-26 08:18:13
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-12-01 05:52:23
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/page/config/route.dart';
import 'package:client/data/listenable/global_do.dart';
import 'package:client/data/db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await DB.init();

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<GlobalDO>(create: (_) => GlobalDO()),
      ],
      child: MaterialApp.router(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
            primaryColor: Colors.white,
            scaffoldBackgroundColor: Colors.white,
            // fontFamily: "YangRenDongZhuShiTi-Regular"
            ),
        routerConfig: RouteConfig.routeConfig(),
      )));
}
