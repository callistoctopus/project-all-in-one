/*
 * @Author: gui-qi
 * @Date: 2022-11-17 08:06:58
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-29 03:22:41
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/page/component/indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartSample2 extends StatefulWidget {
  const PieChartSample2({super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

List<Color> colors = const [
  Color(0xFF1abc9c),
  Color(0xFF2ecc71),
  Color(0xFF3498db),
  Color(0xFF95a5a6),
  Color(0xFFf1c40f),
  Color(0xFFe67e22),
  Color(0xFFe74c3c),
  Color(0xFF9b59b6),
];

List<String> types = const [
  "食品",
  "衣着",
  "居住",
  "生活服务",
  "交通通信",
  "文教娱乐",
  "医疗保健",
  "其他",
];

class PieChart2State extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    List<double> data = [40.0, 15.5, 15.0, 30.0];

    return AspectRatio(
      aspectRatio: 9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const SizedBox(
            width: 25,
            height: 18,
          ),
          Expanded(
            flex: 1,
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 25,
                  sections: showingSections(data),
                ),
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _CONPOMENT.indicator(types, colors)),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _CONPOMENT.indicator(
                            types.sublist(4, 8), colors.sublist(4, 8)))
                  ])),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections(List<double> data) {
    return List.generate(data.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 30.0 : 28.0;
      return PieChartSectionData(
        color: colors[i],
        value: data[i],
        title: "${data[i].toInt()}%",
        radius: radius,
        // titlePositionPercentageOffset:1,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color:  Colors.black,
        ),
      );
    });
  }
}

class _CONPOMENT {
  static List<Widget> indicator(List<String> text, List<Color> color) {
    return List.generate(4, (i) {
      return Column(children: [
        Indicator(
          color: color[i],
          text: text[i],
          isSquare: true,
        ),
        const SizedBox(
          height: 6,
        )
      ]);
    });
  }
}
