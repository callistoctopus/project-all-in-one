/*
 * @Author: gui-qi
 * @Date: 2022-11-02 15:26:48
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-13 14:05:43
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// ignore: must_be_immutable
class PageWithFloatButton extends StatelessWidget {
  PageWithFloatButton(
      {required this.child, this.funcIcon, super.key, this.defaultForward});
  Map<IconData, Function>? funcIcon;
  bool? defaultForward = true;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Map<IconData, Function> para2 = {
      Icons.arrow_back: () {
        context.go('/');
      }
    };

    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        child,
        FlowMenu(menuMap: funcIcon = funcIcon ?? para2),
      ],
    );
  }
}

class FlowMenu extends StatefulWidget {
  const FlowMenu({required this.menuMap, super.key});

  final Map<IconData, Function> menuMap;

  @override
  State<FlowMenu> createState() => _FlowMenuState();
}

class _FlowMenuState extends State<FlowMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  void _updateMenu(IconData icon) {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    // animationController.forward();
  }

  Widget flowMenuItem(IconData icon, Function? func) {

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: GestureDetector(
          onDoubleTap: () {
            _updateMenu(icon);
            animationController.status == AnimationStatus.completed
                ? animationController.reverse()
                : animationController.forward();
          },
          child: RawMaterialButton(
            fillColor: Colors.white,
            splashColor: Colors.amber[100],
            shape: const CircleBorder(),
            // constraints: BoxConstraints.tight(Size(buttonDiameter, buttonDiameter)),
            onPressed: () {
              func!();
            },
            child: Icon(
              icon,
              color: Colors.black,
              size: 45.0,
            ),
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
      if(menuAnimation.value == 0){
        if(i == 0){
          t = context.childCount -1;
        }
        if(i == (context.childCount -1)){
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
