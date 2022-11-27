/*
 * @Author: gui-qi
 * @Date: 2022-10-26 15:06:57
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-25 08:52:00
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/page/component/custom_snack_bar.dart';
import 'package:client/page/config/route.dart';
import 'package:client/data/dao/setting_dao.dart';
import 'package:client/data/service/server_data_access_service.dart';
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
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _VIEW().user((text) {
          widget.user = text;
        }),
        _VIEW().password((text) {
          widget.password = text;
        }),
        if (!widget.isLoginPage)
          _VIEW().repeat((text) {
            widget.password = text;
          }),
        if (widget.isLoginPage)
          _VIEW().autoLogin(() {
            setState(() {});
          }),
        if (widget.isLoginPage)
          _VIEW().login(() async {
            SettingDao.setOfflineMode(false);
            await DataAccessService.login(widget.user, widget.password);
            if (SettingDao.isLogined()) {
              DataAccessService.syncData();
              context.go(ROUTE.HOME);
            } else {
              SettingDao.setOfflineMode(true);
              CustomSnackBar().show(context, "好像哪里出了问题，已为您开启离线模式");
              setState(() {});
            }
          }),
        if (widget.isLoginPage)
          _VIEW().siginBtn(() {
            widget.isLoginPage = false;
            setState(() {});
          }),
        if (widget.isLoginPage && SettingDao.isOfflineMode())
          _VIEW().offline(() {
            context.go(ROUTE.HOME);
          }),
        if (!widget.isLoginPage)
          _VIEW().signin(() async {
            SettingDao.setOfflineMode(false);
            await DataAccessService.sigin(widget.user, widget.password);
            if (SettingDao.isLogined()) {
              context.go(ROUTE.HOME);
            } else {
              CustomSnackBar().show(context, "好像哪里出了问题");
            }
          }),
        if (!widget.isLoginPage)
          _VIEW().back(() {
            widget.isLoginPage = true;
            setState(() {});
          }),
      ],
    ));
  }
}

class _VIEW {
  Widget user(Function callback) {
    return Container(
      height: 70, //这里调整高度即可，建议按照屏幕高度比例来计算
      width: 350,
      padding: const EdgeInsets.only(left: 16, top: 15, right: 16, bottom: 0),
      child: TextField(
        textAlign: TextAlign.justify,
        textAlignVertical: TextAlignVertical.center,
        cursorHeight: 25,
        decoration: const InputDecoration(
          prefixIcon: Icon(ICONS.USER),
          border: OutlineInputBorder(),
          hintText: '用户名',
        ),
        onChanged: (String text) {
          callback(text);
        },
      ),
    );
  }

  Widget password(Function callback) {
    return Container(
      height: 70,
      width: 350,
      padding: const EdgeInsets.only(left: 16, top: 15, right: 16, bottom: 0),
      child: TextField(
        textAlign: TextAlign.justify,
        textAlignVertical: TextAlignVertical.center,
        cursorHeight: 25,
        decoration: const InputDecoration(
          prefixIcon: Icon(ICONS.PASSWORD),
          border: OutlineInputBorder(),
          hintText: '密码',
        ),
        onChanged: (String text) {
          callback(text);
        },
      ),
    );
  }

  Widget back(Function callback) {
    return Container(
        height: 50,
        padding: const EdgeInsets.only(left: 16, top: 5, right: 16, bottom: 0),
        child: TextButton(
            onPressed: () async {
              callback();
            },
            child: const Text("返回")));
  }

  Widget login(Function callback) {
    return Container(
        height: 50,
        padding: const EdgeInsets.only(left: 16, top: 5, right: 16, bottom: 0),
        child: TextButton(
            onPressed: () {
              callback();
            },
            child: const Text("登录")));
  }

  Widget offline(Function callback) {
    return Container(
        height: 50,
        padding: const EdgeInsets.only(left: 16, top: 5, right: 16, bottom: 0),
        child: TextButton(
            onPressed: () {
              callback();
            },
            child: const Text("离线模式")));
  }

  Widget autoLogin(Function callback) {
    return Container(
        height: 70,
        padding: const EdgeInsets.only(left: 16, top: 0, right: 16, bottom: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("自动登录"),
            Checkbox(
                value: SettingDao.isAutoLogin(),
                onChanged: (checked) {
                  SettingDao.setAutoLogin(checked ?? false);
                  callback();
                })
          ],
        ));
  }

  Widget repeat(Function callback) {
    return Container(
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
          callback(text);
        },
      ),
    );
  }

  Widget signin(Function callback) {
    return Container(
        height: 50,
        padding: const EdgeInsets.only(left: 16, top: 5, right: 16, bottom: 0),
        child: TextButton(
            onPressed: () {
              callback();
            },
            child: const Text("注册")));
  }

  Widget siginBtn(Function callback) {
    return Container(
        height: 50,
        padding: const EdgeInsets.only(left: 16, top: 5, right: 16, bottom: 0),
        child: TextButton(
            onPressed: () {
              callback();
            },
            child: const Text("注册")));
  }
}
