/*
 * @Author: gui-qi
 * @Date: 2022-10-26 15:06:57
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-09 12:47:07
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/component/custom_float_button.dart';
import 'package:client/model/persistent_object/account.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    List<Account> accountList = Hive.box<Account>('account').values.toList();
    return PageWithFloatButton(
        child:ListView.builder(
        itemCount: accountList.length,
        itemBuilder: (context, i) {
          return Text(accountList[i].account);
        }));
  }
}
