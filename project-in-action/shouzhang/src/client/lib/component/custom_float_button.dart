/*
 * @Author: gui-qi
 * @Date: 2022-11-02 15:26:48
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-18 08:37:35
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:client/dao/setting_dao.dart';
import 'package:client/units/common_const.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// ignore: must_be_immutable
class PageWithFloatButton extends StatelessWidget {
  PageWithFloatButton(
      {required this.child, this.funcIcon, super.key, this.defaultForward = true, this.showFloatBottom = true});
  Map<dynamic, Function>? funcIcon;
  bool defaultForward = true;
  bool showFloatBottom;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Map<dynamic, Function> para2 = {
      ICONS.BACK: () {
        context.go('/');
      }
    };

    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        child,
        showFloatBottom ? FlowMenu(menuMap: funcIcon = funcIcon ?? para2, defaultForward: defaultForward):SizedBox(),
      ],
    );
  }
}

class FlowMenu extends StatefulWidget {
  FlowMenu({required this.menuMap, this.defaultForward = true, super.key});

  final Map<dynamic, Function> menuMap;
  bool defaultForward = true;

  @override
  State<FlowMenu> createState() => _FlowMenuState();
}

class _FlowMenuState extends State<FlowMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  void _updateMenu(dynamic icon) {
    setState(() {});
    animationController.status == AnimationStatus.completed
        ? animationController.reverse()
        : animationController.forward();
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    if(widget.defaultForward) {
      animationController.forward();
    }
  }

  Widget flowMenuItem(dynamic icon, Function? func) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0),
        child: GestureDetector(
          onDoubleTap: () {
            _updateMenu(icon);
          },
          onLongPress: () {
            _updateMenu(icon);
          },
          child: RawMaterialButton(
            padding: const EdgeInsets.all(6),
            fillColor: Colors.white,
            splashColor: Colors.amber[100],
            shape: const CircleBorder(),
            // constraints: BoxConstraints.tight(Size(buttonDiameter, buttonDiameter)),
            onPressed: () {
              func!();
            },
            child: SettingDao.isDev() == true
                ? Icon(
                    icon,
                    color: Colors.black,
                    size: 45.0,
                  )
                : CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      icon,
                      maxLines:1,
                      style: const TextStyle(color: Colors.black,fontSize: 13),
                    )),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: _FlowMenuDelegate(
          menuAnimation: animationController, pcontext: context),
      children: widget.menuMap.keys
          .map<Widget>((icon) => flowMenuItem(icon, widget.menuMap[icon]))
          .toList(),
    );
  }
}

class _FlowMenuDelegate extends FlowDelegate {
  _FlowMenuDelegate({required this.menuAnimation, required this.pcontext})
      : super(repaint: menuAnimation);

  final Animation<double> menuAnimation;
  final BuildContext pcontext;

  @override
  bool shouldRepaint(_FlowMenuDelegate oldDelegate) {
    return menuAnimation != oldDelegate.menuAnimation;
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    for (int i = 0; i < context.childCount; ++i) {
      double x = pcontext.size!.width - context.getChildSize(i)!.width - 15;
      double y = pcontext.size!.height - context.getChildSize(i)!.height - 15;
      double tx = 0;
      double ty = 0;
      switch (i) {
        case 0:
          break;
        case 1:
          tx = context.getChildSize(i)!.width;
          break;
        case 2:
          tx = context.getChildSize(i)!.width * 0.6;
          ty = context.getChildSize(i)!.height;
          break;
        case 3:
          tx = -15;
          ty = context.getChildSize(i)!.height * 1.5;
          break;
        case 4:
          break;
        case 5:
          break;
        case 6:
          break;
        case 7:
          break;
        case 8:
          break;
        default:
          break;
      }

      int t = i;
      if (menuAnimation.value == 0) {
        if (i == 0) {
          t = context.childCount - 1;
        }
        if (i == (context.childCount - 1)) {
          t = 0;
        }
      }
      context.paintChild(
        t,
        transform: Matrix4.translationValues(
          x - tx * menuAnimation.value,
          y - ty * menuAnimation.value,
          0,
        ),
      );
    }
  }
}
