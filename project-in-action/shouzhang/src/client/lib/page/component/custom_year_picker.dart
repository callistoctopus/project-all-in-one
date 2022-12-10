/*
 * @Author: gui-qi
 * @Date: 2022-12-10 20:41:09
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-12-10 21:21:10
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:flutter/cupertino.dart';

const double _kItemExtent = 32.0;
const List<String> _fruitNames = <String>[
  '2020',
  '2021',
  '2022',
  '2023',
  '2024',
  '2025',
];

class CupertinoPickerExample extends StatefulWidget {
  const CupertinoPickerExample({super.key});

  @override
  State<CupertinoPickerExample> createState() => _CupertinoPickerExampleState();
}

class _CupertinoPickerExampleState extends State<CupertinoPickerExample> {
  int _selectedFruit = 0;

  // This shows a CupertinoModalPopup with a reasonable fixed height which hosts CupertinoPicker.
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 216,
              padding: const EdgeInsets.only(top: 6.0),
              // The Bottom margin is provided to align the popup above the system navigation bar.
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              // Provide a background color for the popup.
              color: CupertinoColors.systemBackground.resolveFrom(context),
              // Use a SafeArea widget to avoid system overlaps.
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: DefaultTextStyle(
        style: TextStyle(
          color: CupertinoColors.label.resolveFrom(context),
          fontSize: 22.0,
        ),
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          // Display a CupertinoPicker with list of fruits.
          onPressed: () => _showDialog(
            CupertinoPicker(
              magnification: 1.22,
              squeeze: 1.2,
              useMagnifier: true,
              itemExtent: _kItemExtent,
              // This is called when selected item is changed.
              onSelectedItemChanged: (int selectedItem) {
                setState(() {
                  _selectedFruit = selectedItem;
                });
              },
              children: List<Widget>.generate(_fruitNames.length, (int index) {
                return Center(
                  child: Text(
                    _fruitNames[index],
                  ),
                );
              }),
            ),
          ),
          // This displays the selected fruit name.
          child: Text(
            "${_fruitNames[_selectedFruit]}年",
            style: const TextStyle(fontSize: 17.0, color: Color(0xFFCCCCCC)),
          ),
        ),
      ),
    );
  }
}
