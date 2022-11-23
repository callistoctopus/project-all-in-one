/*
 * @Author: gui-qi
 * @Date: 2022-11-22 15:08:02
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-22 16:28:01
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/dao/reason_dao.dart';
import 'package:client/dao/setting_dao.dart';
import 'package:client/model/financial_reason.dart';
import 'package:client/page/component/custom_choice_chip.dart';
import 'package:client/units/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class FinancialReasonView extends StatefulWidget {
  FinancialReasonView(
      {super.key, required this.reasonType, required this.callback});

  int reasonType;
  String currentReason = "";
  void Function(String) callback;

  @override
  State<StatefulWidget> createState() => _FinancialReasonViewState();
}

class _FinancialReasonViewState extends State<FinancialReasonView> {
  late Future<List<FinancialReason>> reasons;
  bool showAddReason = false;
  String reason = "";

  saveFinancialReason() {
    FinancialReason fr = FinancialReason(
        const Uuid().v1(),
        SettingDao.currentUser(),
        reason,
        widget.reasonType,
        "",
        0,
        CommonUtils.now());

    ReasonDao.saveFinancialReason(fr);
  }

  @override
  Widget build(BuildContext context) {
    reasons = widget.reasonType == 0
        ? ReasonDao.fetchFinancialReasonOut()
        : ReasonDao.fetchFinancialReasonIn();

    TextEditingController controller = TextEditingController();

    return ListView(children: <Widget>[
      FutureBuilder<List<FinancialReason>>(
          future: reasons,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<String> dataList =
                  snapshot.data!.map((e) => e.reason).toList();
              dataList.add("+追加");
              if (dataList.length > 1 &&
                  !dataList.contains(widget.currentReason)) {
                widget.currentReason = dataList[0];
              }
              return CustomChoiceChip(
                backgroundColor: Colors.green,
                dataList: dataList,
                onSelect: (i) {
                  if (i == (dataList.length - 1)) {
                    setState(() {
                      showAddReason = true;
                    });
                  }
                  widget.currentReason = dataList[i];
                  widget.callback(dataList[i]);
                },
                defaultSelect: dataList.indexOf(widget.currentReason),
                onLongPress: (index) {
                  showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('确定删除？'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('确定'),
                              onPressed: () {
                                ReasonDao.deleteFinancialReason(snapshot.data!
                                    .where((element) =>
                                        element.reason == dataList[index])
                                    .toList()[0]);
                                Navigator.of(context).pop();
                                setState(() {});
                              },
                            ),
                            TextButton(
                              child: const Text('取消'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      });
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const CircularProgressIndicator();
          }),
      AnimatedContainer(
          height: showAddReason ? 70 : 0,
          duration: const Duration(milliseconds: 400),
          child: Row(children: [
            Expanded(
                flex: 1,
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        gapPadding: 2,
                        borderSide: BorderSide(
                            width: 0,
                            color: showAddReason ? Colors.white : Colors.black,
                            style: BorderStyle.none)),
                  ),
                  onChanged: (value) {
                    reason = value;
                  },
                )),
            TextButton(
                onPressed: () {
                  setState(() {
                    showAddReason = false;
                    saveFinancialReason();
                    widget.currentReason = reason;
                    widget.callback(reason);
                    reason = "";
                    controller.clear();
                  });
                },
                child: const Text("确定")),
            TextButton(
                onPressed: () {
                  setState(() {
                    reason = "";
                    showAddReason = false;
                    controller.clear();
                  });
                },
                child: const Text("取消"))
          ]))
    ]);
  }
}
