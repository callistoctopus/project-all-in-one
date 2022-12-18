/*
 * @Author: gui-qi
 * @Date: 2022-10-26 15:06:57
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-12-12 06:36:33
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/page/component/custom_snack_bar.dart';
import 'package:client/page/config/route.dart';
import 'package:client/data/dao/setting_dao.dart';
import 'package:client/data/service/http_service.dart';
import 'package:client/units/common_const.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PageLogin extends StatefulWidget {
  PageLogin({super.key});

  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  String user = "";
  String password = "";
  bool isLoginPage = true;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text("丫丫记账", style: TextStyle(fontSize: 55,color: Color(0xFFa61b29)),),
        const SizedBox(height: 20,),
        _VIEW().user((text) {
          user = text;
        }),
        _VIEW().password((text) {
          password = text;
        }),
        if (!isLoginPage)
          _VIEW().repeat((text) {
            password = text;
          }),
        if (isLoginPage)
          _VIEW().autoLogin(() {
            setState(() {});
          }),
        if (isLoginPage)
          _VIEW().login(() async {
            SettingDao.setOfflineMode(false);
            await HttpService.login(user, password);
            if (SettingDao.isLogined()) {
              HttpService.syncData();
              context.go(ROUTE.HOME);
            } else {
              SettingDao.setOfflineMode(true);
              CustomSnackBar().show(context, "好像哪里出了问题，已为您开启离线模式");
              setState(() {});
            }
          }),
        if (isLoginPage)
          _VIEW().siginBtn(() {
            isLoginPage = false;
            setState(() {});
          }),
        if (isLoginPage && SettingDao.isOfflineMode())
          _VIEW().offline(() {
            context.go(ROUTE.HOME);
          }),
        if (!isLoginPage)
          _VIEW().signin(() async {
            SettingDao.setOfflineMode(false);
            await HttpService.sigin(user, password);
            if (SettingDao.isLogined()) {
              context.go(ROUTE.HOME);
            } else {
              CustomSnackBar().show(context, "好像哪里出了问题");
            }
          }),
        if (!isLoginPage)
          _VIEW().back(() {
            isLoginPage = true;
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
          fillColor: Color(0xFFe2e1e4),
          filled: true,
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
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        decoration: const InputDecoration(
          prefixIcon: Icon(ICONS.PASSWORD),
          border: OutlineInputBorder(),
          fillColor: Color(0xFFe2e1e4),
          filled: true,
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
            child: const Text("立即注册")));
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
