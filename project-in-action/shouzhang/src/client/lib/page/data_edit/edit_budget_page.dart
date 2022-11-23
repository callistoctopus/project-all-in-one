// /*
//  * @Author: gui-qi
//  * @Date: 2022-10-26 15:06:57
//  * @LastEditors: gui-qi
//  * @LastEditTime: 2022-11-23 07:00:57
//  * @Description: 
//  * 
//  * Copyright (c) 2022, All Rights Reserved. 
//  */
// import 'package:client/page/component/custom_chart.dart';
// import 'package:client/page/component/custom_choice_chip.dart';
// import 'package:client/page/component/custom_float_button.dart';
// import 'package:client/page/component/custom_snack_bar.dart';
// import 'package:client/config/route.dart';
// import 'package:client/dao/budget_dao.dart';
// import 'package:client/dao/setting_dao.dart';
// import 'package:client/model/budget.dart';
// import 'package:client/page/data_model/ParamStore.dart';
// import 'package:client/page/views/financial_reason.dart';
// import 'package:client/page/views/financial_type.dart';
// import 'package:client/units/common_const.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:uuid/uuid.dart';

// class AddBudgetView extends StatefulWidget {
//   const AddBudgetView({super.key, required this.editType});

//   // BudgetInputVO cpo;
//   final int editType;

//   @override
//   State<AddBudgetView> createState() => _AddBudgetViewState();
// }

// class _AddBudgetViewState extends State<AddBudgetView> {
//   saveBudget() {
//     // late Budget b;
//     // if (widget.cpo.editType == 0) {
//     //   b = Budget(
//     //       const Uuid().v1(),
//     //       SettingDao.currentUser(),
//     //       SettingDao.budgetYear().toString(),
//     //       widget.cpo.reason,
//     //       widget.cpo.type,
//     //       widget.cpo.duration,
//     //       widget.cpo.amount,
//     //       widget.cpo.note,
//     //       0,
//     //       DateTime.now());
//     // } else {
//     //   b = PageParamStore.budget!;
//     //   b.reason = widget.cpo.reason;
//     //   b.type = widget.cpo.type;
//     //   b.budget = widget.cpo.amount;
//     //   b.note = widget.cpo.note;
//     // }
//     BudgetDao.saveBudget(b);
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   TextEditingController controller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     if (widget.cpo.editType == 1) {
//       widget.cpo.type = PageParamStore.budget!.type;
//       widget.cpo.reason = PageParamStore.budget!.reason;
//       widget.cpo.amount = PageParamStore.budget!.budget;
//       widget.cpo.note = PageParamStore.budget!.note;
//     }

//     Map<dynamic, Function> para = {
//       ICONS.BACK: () {
//         context.go(ROUTE.HOME);
//       },
//       ICONS.SAVE: () {
//         if (widget.cpo.amount == -1) {
//           return CustomSnackBar().show(context, "请输入金额");
//         }

//         saveBudget();
//         context.go(ROUTE.HOME);
//       }
//     };

//     List<String> duration = ['每天', '工作日', '每周', '每月', '每季度', '半年', '每年'];

//     return PageWithFloatButton(
//         funcIcon: para,
//         child: Scaffold(
//           body: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               child: ListView(
//                 children: <Widget>[
//                   CustomChart(
//                     title: "收支类型",
//                     height: 70,
//                     child: FinancialTypeView(
//                       callback: (int value) {},
//                     ),
//                   ),
//                   const Divider(
//                     color: Colors.grey,
//                     thickness: 0,
//                     height: 10,
//                   ),
//                   CustomChartDynamic(
//                     title: "收支事项",
//                     child: FinancialReasonView(
//                       callback: (reason) {
//                         widget.cpo.reason = reason;
//                       },
//                       reasonType: 0,
//                     ),
//                   ),
//                   const Divider(
//                     color: Colors.grey,
//                     thickness: 0,
//                     height: 12,
//                   ),
//                   const Text(style: TextStyle(fontSize: 12), "预算周期"),
//                   CustomChoiceChip(
//                     dataList: duration,
//                     onSelect: (i) {
//                       widget.cpo.duration = i;
//                       setState(() {});
//                     },
//                     defaultSelect: widget.cpo.duration,
//                     onLongPress: (index) {},
//                   ),
//                   const Divider(
//                     color: Colors.grey,
//                     thickness: 0,
//                     height: 12,
//                   ),
//                   const Text(style: TextStyle(fontSize: 12), "收支金额"),
//                   Container(
//                     padding: const EdgeInsets.only(top: 0),
//                     height: 60,
//                     child: TextField(
//                       keyboardType: TextInputType.number,
//                       controller: TextEditingController.fromValue(
//                           TextEditingValue(
//                               text: widget.cpo.amount == -1
//                                   ? ""
//                                   : widget.cpo.amount.toString())),
//                       textAlign: TextAlign.justify,
//                       textAlignVertical: TextAlignVertical.center,
//                       cursorHeight: 25,
//                       decoration: const InputDecoration(
//                         contentPadding: EdgeInsets.all(2),
//                         fillColor: Colors.grey,
//                         prefixText: "￥",
//                         border: InputBorder.none,
//                         hintText: '金额',
//                       ),
//                       onChanged: (String text) {
//                         widget.cpo.amount = double.tryParse(text) ?? -1;
//                       },
//                     ),
//                   ),
//                   const Divider(
//                     color: Colors.grey,
//                     thickness: 0,
//                     height: 12,
//                   ),
//                   const Text(style: TextStyle(fontSize: 12), "备注信息"),
//                   SizedBox(
//                     child: TextField(
//                       decoration: const InputDecoration(
//                         border: UnderlineInputBorder(),
//                         hintText: '备注',
//                       ),
//                       onChanged: (String text) {
//                         widget.cpo.note = text;
//                       },
//                     ),
//                   ),
//                 ],
//               )),
//         ));
//   }
// }
