/*
 * @Author: gui-qi
 * @Date: 2022-11-22 15:08:02
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-12-11 22:25:15
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/data/dao/dao.dart';
import 'package:client/data/dao/reason_dao.dart';
import 'package:client/data/dao/setting_dao.dart';
import 'package:client/data/db.dart';
import 'package:client/data/model/financial_reason.dart';
import 'package:client/page/component/custom_choice_chip.dart';
import 'package:client/page/component/custom_snack_bar.dart';
import 'package:client/data/listenable/global_do.dart';
import 'package:client/units/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class FinancialReasonView extends StatefulWidget {
  const FinancialReasonView({super.key});

  @override
  State<StatefulWidget> createState() => _FinancialReasonViewState();
}

class _FinancialReasonViewState extends State<FinancialReasonView> {
  Future<List<FinancialReason>> reasons = ReasonDao.fetchFinancialReason(0);
  bool showAddReason = false;
  String reason = "";

  saveFinancialReason() {
    FinancialReason fr = FinancialReason(
        const Uuid().v1(),
        SettingDao.currentUser(),
        reason,
        context.read<GlobalDO>().type,
        "",
        0,
        0,
        CommonUtils.now());

    Dao.upsert<FinancialReason>(fr, TABLE.financialReason);
  }

  @override
  Widget build(BuildContext context) {
    String selectedReason = context.read<GlobalDO>().reason;

    reasons = ReasonDao.fetchFinancialReason(
        context.read<GlobalDO>().type != context.watch<GlobalDO>().type
            ? context.read<GlobalDO>().type
            : context.watch<GlobalDO>().type);

    TextEditingController controller = TextEditingController();

    return ListView(shrinkWrap: true, children: <Widget>[
      FutureBuilder<List<FinancialReason>>(
          future: reasons,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<String> dataList =
                  snapshot.data!.map((e) => e.reason).toList();
              return CustomChoiceChip(
                enableAdd: true,
                selectedColor: const Color(0xFF336699),
                dataList: dataList,
                onSelect: (i) {
                  context.read<GlobalDO>().reason = dataList[i];
                },
                onAdd: () {
                  setState(() {
                    showAddReason = true;
                  });
                },
                defaultSelect:
                    dataList.indexOf(selectedReason),
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
                                Dao.delete<FinancialReason>(snapshot.data!
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
      Padding(
          padding: const EdgeInsets.only(left: 8),
          child: AnimatedContainer(
              height: showAddReason ? 60 : 0,
              duration: const Duration(milliseconds: 400),
              child: Row(children: [
                Expanded(
                    flex: 4,
                    child: Container(
                        padding: const EdgeInsets.only(right: 8),
                        height: showAddReason ? 40 : 0,
                        child: TextField(
                          style: const TextStyle(fontSize: 20),
                          controller: controller,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 10),
                            border: OutlineInputBorder(
                                gapPadding: 2,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(18.0)),
                                borderSide: BorderSide(
                                    width: 0,
                                    color: showAddReason
                                        ? Colors.white
                                        : Colors.black,
                                    style: BorderStyle.none)),
                          ),
                          onChanged: (value) {
                            reason = value;
                          },
                        ))),
                Expanded(
                    flex: 1,
                    child: SizedBox(
                        height: showAddReason ? 40 : 0,
                        child: TextButton(
                            onPressed: () {
                              if (reason == "") {
                                CustomSnackBar().show(context, "您还没有输入");
                                return;
                              }

                              saveFinancialReason();
                              context.read<GlobalDO>().reason = reason;
                              setState(() {
                                showAddReason = false;
                                reason = "";
                                controller.clear();
                              });
                            },
                            child: 
                            ChoiceChip(label: showAddReason
                                        ? Text("确认")
                                        :Text(""), selected: true, selectedColor: Color(0xFFFFFFFF),side:BorderSide(color: showAddReason
                                        ? Color(0xFF000000)
                                        :Colors.white))
                            // const Text(
                            //   "√",
                            //   style:
                            //       TextStyle(fontSize: 28, color: Colors.black),
                            // )
                            ))),
                Expanded(
                    flex: 1,
                    child: SizedBox(
                        height: showAddReason ? 40 : 0,
                        child: TextButton(
                            // style: TextButton.styleFrom(
                            //     shape: const CircleBorder(
                            //         side: BorderSide(color: Colors.grey))),
                            onPressed: () {
                              setState(() {
                                reason = "";
                                showAddReason = false;
                                controller.clear();
                              });
                            },
                            child:ChoiceChip(label: showAddReason
                                        ? Text("取消")
                                        :Text(""), selected: true, selectedColor: Color(0xFFFFFFFF),side:BorderSide(color: showAddReason
                                        ? Color(0xFF000000)
                                        :Colors.white))
                            //  const Text("X",
                            //     style: TextStyle(
                            //         fontSize: 28, color: Colors.black))
                                    )))
              ])))
    ]);
  }
}
