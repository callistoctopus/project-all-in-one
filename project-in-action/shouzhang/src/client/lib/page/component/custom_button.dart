/*
 * @Author: gui-qi
 * @Date: 2022-11-21 03:13:24
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-12-11 21:58:13
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:flutter/material.dart';

class ComponentButton extends StatelessWidget {
  const ComponentButton(
      {super.key,
      required this.btnName,
      this.callback,});

  final String btnName;
  final void Function()? callback;
  
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            textStyle: MaterialStateProperty.resolveWith<TextStyle?>((states) =>
                const TextStyle(color: Color(0xFF000000), fontSize: 14)),
            backgroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return const Color(0xFFFFFFFF);
                }
                return const Color(0xFFFFFFFF); // defer to the defaults
              },
            ),
            fixedSize: MaterialStateProperty.resolveWith<Size?>(
                (states) => const Size(150, 50)),
            shape: MaterialStateProperty.resolveWith<OutlinedBorder?>((states) {
              return const RoundedRectangleBorder(
                  side: BorderSide(color: Color(0xFFC2C2C2)),
                  borderRadius: BorderRadius.all(Radius.circular(4)));
            })),
        onPressed: callback,
        child: Text(
          btnName,
          style: const TextStyle(color: Color(0xFF000000), fontSize: 18),
        ));
  }
}