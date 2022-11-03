/*
 * @Author: gui-qi
 * @Date: 2022-11-02 15:26:48
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-02 16:25:19
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */

/*
 * @Author: gui-qi
 * @Date: 2022-11-02 15:13:26
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-02 15:13:29
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PageWithFloatButton extends StatelessWidget {
  PageWithFloatButton(
      {required this.child, this.funcIcon, super.key});
  Map<IconData, Function>? funcIcon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Map<IconData, Function> para2 = {
      Icons.arrow_back: () {
        Navigator.pop(context);
      }
    };

    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        child,
        _FlowMenu(menuMap: funcIcon = funcIcon ?? para2),
      ],
    );
  }
}

class _FlowMenu extends StatefulWidget {
  const _FlowMenu({super.key, required this.menuMap});

  final Map<IconData, Function> menuMap;

  @override
  State<_FlowMenu> createState() => _FlowMenuState();
}

class _FlowMenuState extends State<_FlowMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController menuAnimation;
  IconData lastTapped = Icons.notifications;

  void _updateMenu(IconData icon) {
    if (icon != Icons.menu) {
      setState(() => lastTapped = icon);
    }
  }

  @override
  void initState() {
    super.initState();
    menuAnimation = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
  }

  Widget flowMenuItem(IconData icon, Function? func) {
    return Stack(children: <Widget>[
      Positioned.fill(
        child: Container(
          margin: const EdgeInsets.all(
              5), // Modify this till it fills the color properly
          color: Colors.white, // Color
        ),
      ),
      GestureDetector(
          onDoubleTap: () {
            _updateMenu(icon);
            menuAnimation.status == AnimationStatus.completed
                ? menuAnimation.reverse()
                : menuAnimation.forward();
          },
          child: IconButton(
            icon: Icon(
              icon,
              size: 40,
            ),
            onPressed: () {
              func!();
            },
            style: _enabledFilledButtonStyle(false, Theme.of(context).colorScheme),
          ))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate:
          _FlowMenuDelegate(menuAnimation: menuAnimation, pcontext: context),
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
    double dx = 0.0;
    for (int i = 0; i < context.childCount; ++i) {
      var cw = context.getChildSize(i)!.width +10;
      dx = cw * i;
      var x = pcontext.size!.width - context.getChildSize(i)!.width -15;
      var y = pcontext.size!.height - context.getChildSize(i)!.width -15;
      context.paintChild(
        i,
        transform: Matrix4.translationValues(
          x - dx * menuAnimation.value,
          y,
          0,
        ),
      );
    }
  }
}

ButtonStyle _enabledFilledButtonStyle(bool selected, ColorScheme colors) {
  return IconButton.styleFrom(
    foregroundColor: selected ? colors.onPrimary : colors.primary,
    backgroundColor: selected ? colors.primary : colors.surfaceVariant,
    disabledForegroundColor: colors.onSurface.withOpacity(0.38),
    disabledBackgroundColor: colors.onSurface.withOpacity(0.12),
    hoverColor: selected
        ? colors.onPrimary.withOpacity(0.08)
        : colors.primary.withOpacity(0.08),
    focusColor: selected
        ? colors.onPrimary.withOpacity(0.12)
        : colors.primary.withOpacity(0.12),
    highlightColor: selected
        ? colors.onPrimary.withOpacity(0.12)
        : colors.primary.withOpacity(0.12),
  );
}