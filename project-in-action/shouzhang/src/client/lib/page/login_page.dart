/*
 * @Author: gui-qi
 * @Date: 2022-10-26 15:06:57
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-10 01:34:50
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/service/server_data_access_service.dart';
import 'package:client/service/local_database_service.dart';
import 'package:client/units/common_const.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  String user = "";
  String password = "";

  bool isLoginPage = true;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    bool isAutoLogin = DB.isAutoLogin();

    Widget w1 = Container(
        height: 50, 
        padding: const EdgeInsets.only(left: 16, top: 5, right: 16, bottom: 0),
        child: TextButton(
            onPressed: () async {
              await DataAccessService.login(widget.user, widget.password);
              if (DB.isLogined()) {
                // ignore: use_build_context_synchronously
                context.go(ROUTE.HOME);
              }
            },
            child: const Text("登录")));

    Widget w4 = Container(
        height: 50,
        padding: const EdgeInsets.only(left: 16, top: 5, right: 16, bottom: 0),
        child: TextButton(
            onPressed: () async {
              await DataAccessService.sigin(widget.user, widget.password);
              if (DB.isLogined()) {
                // ignore: use_build_context_synchronously
                context.go(ROUTE.HOME);
              }
            },
            child: const Text("注册")));

    Widget w2 = Container(
        height: 50,
        padding: const EdgeInsets.only(left: 16, top: 5, right: 16, bottom: 0),
        child: TextButton(
            onPressed: () async {
              widget.isLoginPage = false;
              setState(() {});
            },
            child: const Text("注册")));

    Widget w3 = Container(
      height: 70, //这里调整高度即可，建议按照屏幕高度比例来计算
      width: 350,
      padding: const EdgeInsets.only(left: 16, top: 15, right: 16, bottom: 0),
      child: TextField(
        textAlign: TextAlign.justify,
        textAlignVertical: TextAlignVertical.center,
        cursorHeight: 25,
        decoration: const InputDecoration(
          prefixIcon: Icon(ICONS.PASSWORD),
          border: OutlineInputBorder(),
          hintText: '请再次输入密码',
        ),
        onChanged: (String text) {
          widget.password = text;
        },
      ),
    );

    Widget w5 = Container(
        height: 70,
        padding: const EdgeInsets.only(left: 16, top: 0, right: 16, bottom: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("自动登录"),
            Checkbox(
                value: isAutoLogin,
                onChanged: (checked) {
                  isAutoLogin = checked ?? false;
                  DB.setAutoLogin(isAutoLogin);
                  setState(() {});
                })
          ],
        ));
    Widget w6 = Container(
        height: 50,
        padding: const EdgeInsets.only(left: 16, top: 5, right: 16, bottom: 0),
        child: TextButton(
            onPressed: () async {
              widget.isLoginPage = true;
              setState(() {});
            },
            child: const Text("返回")));

    List<Widget> wl = [w1, w2];

    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 70, //这里调整高度即可，建议按照屏幕高度比例来计算
          width: 350,
          padding:
              const EdgeInsets.only(left: 16, top: 15, right: 16, bottom: 0),
          // margin: const EdgeInsets.only(top:5),
          child: TextField(
            textAlign: TextAlign.justify,
            textAlignVertical: TextAlignVertical.center,
            cursorHeight: 25,
            // scrollPadding: EdgeInsets.all(2.0),
            decoration: const InputDecoration(
              // prefixText: "￥",
              prefixIcon: Icon(ICONS.USER),
              border: OutlineInputBorder(),
              hintText: '用户名',
            ),
            onChanged: (String text) {
              widget.user = text;
            },
          ),
        ),
        Container(
          height: 70, //这里调整高度即可，建议按照屏幕高度比例来计算
          width: 350,
          padding:
              const EdgeInsets.only(left: 16, top: 15, right: 16, bottom: 0),
          // margin: const EdgeInsets.only(top:5),
          child: TextField(
            textAlign: TextAlign.justify,
            textAlignVertical: TextAlignVertical.center,
            cursorHeight: 25,
            // scrollPadding: EdgeInsets.all(2.0),
            decoration: const InputDecoration(
              // prefixText: "￥",
              prefixIcon: Icon(ICONS.PASSWORD),
              border: OutlineInputBorder(),
              hintText: '密码',
            ),
            onChanged: (String text) {
              widget.password = text;
            },
          ),
        ),
        if (!widget.isLoginPage) w3,
        if (widget.isLoginPage) w5,
        if (widget.isLoginPage) w1,
        if (widget.isLoginPage) w2,
        if (!widget.isLoginPage) w4,
        if (!widget.isLoginPage) w6,
      ],
    ));
  }
}
