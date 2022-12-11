/*
 * @Author: gui-qi
 * @Date: 2022-11-17 08:06:58
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-12-11 21:08:27
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/data/dao/consume_dao.dart';
import 'package:client/page/component/custom_indicator.dart';
import 'package:client/page/component/custom_year_picker.dart';
import 'package:client/units/common_const.dart';
import 'package:client/units/common_utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartSample2 extends StatefulWidget {
  const PieChartSample2({super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

List<Color> colors = const [
  Color(0xFFCCCC33),
  Color(0xFFFFCCCC),
  Color(0xFFCCCCFF),
  Color(0xFFCC99CC),
  Color(0xFF99CCFF),
  Color(0xFFFFCCFF),
  Color(0xFF99CCFF),
  Color(0xFF99CCCC),
];

class PieChart2State extends State {
  int touchedIndex = -1;
  Future fdata = ConsumeDao.getTotalByYearAndCategory(CommonUtils.now().year);

  @override
  Widget build(BuildContext context) {
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
            child: FutureBuilder(
                future: fdata,
                builder: (context, snapshot) {
                  List<double> data = [5, 15, 10, 20, 30, 5, 5, 10];
                  if (snapshot.hasData) {
                    //data = snapshot.data!;
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: PieChart(
                          PieChartData(
                            pieTouchData: PieTouchData(
                              touchCallback:
                                  (FlTouchEvent event, pieTouchResponse) {
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
                            centerSpaceRadius: 35,
                            sections: showingSections(data),
                          ),
                        ),
                      ),
                      const CupertinoPickerExample(),
                    ]);
                  }
                  return const Text("无数据");
                }),
          ),
          Expanded(
              flex: 1,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _CONPOMENT.indicator(consumeKind, colors)),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _CONPOMENT.indicator(
                            consumeKind.sublist(4, 8), colors.sublist(4, 8)))
                  ])),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections(List<double> data) {
    return List.generate(data.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 13.0;
      final radius = isTouched ? 40.0 : 38.0;
      return PieChartSectionData(
        color: colors[i],
        value: data[i],
        title: "${data[i].toInt()}%",
        radius: radius,
        // titlePositionPercentageOffset:1,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF617172),
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
