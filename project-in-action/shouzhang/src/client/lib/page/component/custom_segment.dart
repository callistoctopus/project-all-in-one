/*
 * @Author: gui-qi
 * @Date: 2022-12-13 21:14:31
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-12-13 23:10:38
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */

// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Map<int, Color> skyColors = <int, Color>{
//   0: const Color(0xff191970),
//   1: const Color(0xff40826d),
//   2: const Color(0xff007ba7),
// };

// class SegmentedControlApp extends StatelessWidget {
//   const SegmentedControlApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const CupertinoApp(
//       theme: CupertinoThemeData(brightness: Brightness.light, scaffoldBackgroundColor: Color(0xFFFFFFFF)),
//       home: SegmentedControlExample(),
//     );
//   }
// }

class SegmentedControlApp extends StatefulWidget {
  const SegmentedControlApp({super.key});

  @override
  State<SegmentedControlApp> createState() =>
      _SegmentedControlExampleState();
}

class _SegmentedControlExampleState extends State<SegmentedControlApp> {
  int _selectedSegment = 0;

  @override
  Widget build(BuildContext context) {
    return 
        // CupertinoPageScaffold(
        //   backgroundColor: skyColors[_selectedSegment],
        //   navigationBar:
        NavigationBar(
      // This Cupertino segmented control has the enum "Sky" as the type.
      // middle: CupertinoSegmentedControl<int>(
      //   selectedColor: const Color(0xff007ba7),
      //   // Provide horizontal padding around the children.
      //   padding: const EdgeInsets.symmetric(horizontal: 3),
      //   // This represents a currently selected segmented control.
        selectedIndex: _selectedSegment,
      //   // Callback that sets the selected segmented control.
        onDestinationSelected: (int value) {
          setState(() {
            _selectedSegment = value;
          });
        },
      //   children: const <int, Widget>{
      //     0: 
      //     Padding(
      //       padding: EdgeInsets.symmetric(horizontal: 2),
      //       child: 
      //       Text('食品'),
      //     ),
      //     1: Padding(
      //       padding: EdgeInsets.symmetric(horizontal: 2),
      //       child: Text('衣着'),
      //     ),
      //     2: Padding(
      //       padding: EdgeInsets.symmetric(horizontal: 2),
      //       child: Text('居住'),
      //     ),
      //     3: Padding(
      //       padding: EdgeInsets.symmetric(horizontal: 4),
      //       child: Text('生活服务',maxLines:1,textScaleFactor: 0.8,),
      //     ),
      //     4: Padding(
      //       padding: EdgeInsets.symmetric(horizontal: 4),
      //       child: Text('交通通信',maxLines:1,textScaleFactor: 0.8,),
      //     ),
      //     5: Padding(
      //       padding: EdgeInsets.symmetric(horizontal: 4),
      //       child: Text('文教娱乐',maxLines:1,textScaleFactor: 0.8,),
      //     ),
      //     6: Padding(
      //       padding: EdgeInsets.symmetric(horizontal: 4),
      //       child: Text('医疗保健',maxLines:1,textScaleFactor: 0.8,),
      //     ),
      //     7: Padding(
      //       padding: EdgeInsets.symmetric(horizontal: 2),
      //       child: Text('其他'),
      //     ),
      //   },
      // ), 
      destinations: const [
          
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: 
            Text('食品'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: Text('衣着'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: Text('居住'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Text('生活服务',maxLines:1,textScaleFactor: 0.8,),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Text('交通通信',maxLines:1,textScaleFactor: 0.8,),
          ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Text('文教娱乐',maxLines:1,textScaleFactor: 0.8,),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Text('医疗保健',maxLines:1,textScaleFactor: 0.8,),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: Text('其他'),
          ),
      ],
      // ),
      // child: Center(
      //   child: Text(
      //     'Selected Segment: ${_selectedSegment.name}',
      //     style: const TextStyle(color: CupertinoColors.white),
      //   ),
      // ),
    );
  }
}
