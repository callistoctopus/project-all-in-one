/*
 * @Author: gui-qi
 * @Date: 2022-10-31 05:25:13
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-10-31 06:18:53
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */

import 'package:client/add.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../dashboard.dart';

class ActionSheetExample extends StatelessWidget {
  const ActionSheetExample({super.key});

  // This shows a CupertinoModalPopup which hosts a CupertinoActionSheet.
  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder:
          // (BuildContext context) => MaterialApp(
          //   theme: ThemeData(
          //     colorSchemeSeed: const Color(0xff6750a4),
          //     useMaterial3: true,
          //     // Desktop and web platforms have a compact visual density by default.
          //     // To see buttons with circular background on desktop/web, the "visualDensity"
          //     // needs to be set to "VisualDensity.standard".
          //     visualDensity: VisualDensity.standard,
          //   ),
          //   title: 'Navigation Basics',
          //   home: const DashboardPage(),
          // )
          (BuildContext context) => CupertinoActionSheet(
        title: const Text('Title'),
        // message: const Text('Message'),
         message: const AddPage(),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            /// This parameter indicates the action would be a default
            /// defualt behavior, turns the action's text to bold text.
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Default Action'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Action'),
          ),
          CupertinoActionSheetAction(
            /// This parameter indicates the action would perform
            /// a destructive action such as delete or exit and turns
            /// the action's text color to red.
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Destructive Action'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('CupertinoActionSheet Sample'),
      ),
      child: Center(
        child: CupertinoButton(
          onPressed: () => _showActionSheet(context),
          child: const Text('CupertinoActionSheet'),
        ),
      ),
    );
  }
}

void main() => runApp(const ActionSheetApp());

class ActionSheetApp extends StatelessWidget {
  const ActionSheetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: ActionSheetExample(),
    );
  }
}
