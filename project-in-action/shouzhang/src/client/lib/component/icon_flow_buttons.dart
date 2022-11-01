import 'package:flutter/material.dart';

import 'icon_toggle_buttons.dart';

class FlowMenu extends StatefulWidget {
  const FlowMenu({super.key, required this.menuMap});

  final Map<IconData, Function> menuMap;

  @override
  State<FlowMenu> createState() => _FlowMenuState();
}

class _FlowMenuState extends State<FlowMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController menuAnimation;
  IconData lastTapped = Icons.notifications;
  // final List<IconData> menuItems = <IconData>[
  //   Icons.save,
  //   Icons.delete,
  //   Icons.cancel,
  //   // Icons.settings,
  //   // Icons.menu,
  // ];

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
            style: enabledFilledButtonStyle(false, Theme.of(context).colorScheme),
          ))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate:
          FlowMenuDelegate(menuAnimation: menuAnimation, pcontext: context),
      children: widget.menuMap.keys
          .map<Widget>((icon) => flowMenuItem(icon, widget.menuMap[icon]))
          .toList(),
    );
  }
}

class FlowMenuDelegate extends FlowDelegate {
  FlowMenuDelegate({required this.menuAnimation, required this.pcontext})
      : super(repaint: menuAnimation);

  final Animation<double> menuAnimation;
  final BuildContext pcontext;

  @override
  bool shouldRepaint(FlowMenuDelegate oldDelegate) {
    return menuAnimation != oldDelegate.menuAnimation;
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    double dx = 0.0;
    for (int i = 0; i < context.childCount; ++i) {
      var cw = context.getChildSize(i)!.width +10;
      dx = cw * i;
      var x = pcontext.size!.width - context.getChildSize(i)!.width;
      var y = pcontext.size!.height - context.getChildSize(i)!.width;
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

void main() => runApp(const FlowApp());

class FlowApp extends StatelessWidget {
  const FlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flow Example'),
        ),
        // body: const FlowMenu(),
      ),
    );
  }
}
