/*
 * @Author: gui-qi
 * @Date: 2022-10-26 15:06:57
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-10 08:34:56
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/component/custom_float_button.dart';
import 'package:client/model/persistent_object/account.dart';
import 'package:client/model/persistent_object/account_user.dart';
import 'package:client/service/local_database_service.dart';
import 'package:client/units/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  List<AccountUser> user = DB.accountUsers();
  List<Account> account = DB.allAccounts();
  bool showInvite = false;
  String username = "";
  @override
  Widget build(BuildContext context) {
    return PageWithFloatButton(
        child: ListView.builder(
            itemCount: user.length + account.length + 1,
            itemBuilder: (contextb, i) {
              if (i < account.length) {
                return Card(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("账号"),
                    Text(account[0].account),
                    TextButton(
                        onPressed: () {
                          if (username != "") {
                            AccountUser au = AccountUser(Uuid().v1(), username,
                                DB.currentAccount(), 1, 0, CommonUtils.now());
                            Hive.box<AccountUser>(TABLE.accountUser).add(au);
                          }

                          setState(() {
                            showInvite = !showInvite;
                          });
                        },
                        child: showInvite == true
                            ? const Text("确定")
                            : const Text("邀请"))
                  ],
                ));
              } else if (i == (user.length + account.length)) {
                if (showInvite == false) {
                  return const Divider();
                } else {
                  return Container(
                    height: 70, //这里调整高度即可，建议按照屏幕高度比例来计算
                    padding: const EdgeInsets.only(
                        left: 16, top: 15, right: 16, bottom: 0),
                    // margin: const EdgeInsets.only(top:5),
                    child: TextField(
                      textAlign: TextAlign.justify,
                      textAlignVertical: TextAlignVertical.center,
                      cursorHeight: 25,
                      // scrollPadding: EdgeInsets.all(2.0),
                      decoration: const InputDecoration(
                        // prefixText: "成员名",
                        border: OutlineInputBorder(),
                        hintText: '成员名',
                      ),
                      onChanged: (String text) {
                        // cpo.amount = double.tryParse(text) ?? -1;
                        username = text;
                      },
                    ),
                  );
                }
              } else {
                return Card(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("成员"),
                    Text(user[i - account.length].account),
                    Text(user[i - account.length].user),
                    user[i - 1].state == 0
                        ? const Text("已接受")
                        : (user[i - 1].account == DB.currentAccount()
                            ? const Text("待接受")
                            : TextButton(
                                onPressed: () {
                                  user[i - 1].state = 0;
                                  DB.saveAccountUser(user[i - 1]);
                                  setState(() {
                                    
                                  });
                                }, child: const Text("接受")))
                  ],
                ));
              }
            }));
  }
}
