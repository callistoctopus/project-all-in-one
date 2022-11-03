/*
 * @Author: gui-qi
 * @Date: 2022-11-02 14:55:49
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-02 16:20:07
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/component/custom_float_button.dart';
import 'package:flutter/material.dart';

class InkWellPage extends StatelessWidget {
  const InkWellPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWithFloatButton(
      child: const Scaffold(
          body: Center(
        child: InkWellButton(),
      )),
    );
  }
}

class InkWellButton extends StatelessWidget {
  const InkWellButton({super.key});

  @override
  Widget build(BuildContext context) {
    // The InkWell wraps the custom flat button widget.
    return InkWell(
      // When the user taps the button, show a snackbar.
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Tap'),
        ));
      },
      child: const Padding(
        padding: EdgeInsets.all(12.0),
        child: Text('Flat Button'),
      ),
    );
  }
}
