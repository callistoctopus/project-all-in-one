/*
 * @Author: gui-qi
 * @Date: 2022-11-11 05:08:14
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-12-01 14:00:35
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:flutter/material.dart';

class CustomSnackBar{
  void show(BuildContext context, String message){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Theme.of(context).primaryColor,
              duration: const Duration(milliseconds: 1200),
              shape: const ContinuousRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              padding: const EdgeInsets.only(
                  left: 15, top: 15, right: 15, bottom: 15),
              content: Text(
                message,
                style: const TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
              ),
              behavior: SnackBarBehavior.floating,
              dismissDirection: DismissDirection.up));
  }
}