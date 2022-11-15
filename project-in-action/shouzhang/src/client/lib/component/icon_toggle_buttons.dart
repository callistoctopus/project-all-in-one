import 'package:flutter/material.dart';

class IconToggleButtons extends StatefulWidget {
  IconToggleButtons({
    required this.labelIcon,
    required this.onSelect,
    this.isSingle = false,
    required this.defaultSelected,
    super.key,
  });

  final bool isSingle;
  final Map<String, IconData> labelIcon;
  Function(List<String>) onSelect;
  final String defaultSelected;

  List<String> currentIndex = [];

  @override
  State<IconToggleButtons> createState() => _IconToggleButtonsState();
}

class _IconToggleButtonsState extends State<IconToggleButtons> {
  @override
  Widget build(BuildContext context) {
    onEvent(String label, bool isSelected) {
      if (widget.isSingle) {
        widget.currentIndex.clear();
      }

      if (isSelected) {
        widget.currentIndex.add(label);
      } else {
        widget.currentIndex.remove(label);
      }

      widget.onSelect(widget.currentIndex);

      if (widget.isSingle) {
        setState(() {});
      }
    }

    if (widget.currentIndex.isEmpty) {
      widget.currentIndex.add(widget.defaultSelected);
    }

    return Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 1),
        height: 80,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.labelIcon.length,
            itemBuilder: (context, i) {
              String label = widget.labelIcon.keys.elementAt(i);
              return Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        IconToggleButton(
                          isEnabled: true,
                          getDefaultStyle: enabledFilledButtonStyle,
                          icon: widget.labelIcon[label] ?? Icons.device_unknown,
                          label: label,
                          callback: onEvent,
                          selected: widget.currentIndex.contains(label),
                        ),
                        Text(label),
                      ]));
            }));
  }
}

class IconToggleButton extends StatefulWidget {
  IconToggleButton(
      {required this.isEnabled,
      this.getDefaultStyle,
      required this.icon,
      required this.label,
      // this.selectedIndex = 0,
      required this.callback,
      this.selected = false,
      super.key});

  final bool isEnabled;
  final ButtonStyle? Function(bool, ColorScheme)? getDefaultStyle;
  final IconData icon;
  final String label;
  final Function(String label, bool isSelected) callback;
  bool selected;

  @override
  State<IconToggleButton> createState() => _IconToggleButtonState();
}

class _IconToggleButtonState extends State<IconToggleButton> {
  // bool selected = false;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final VoidCallback? onPressed = widget.isEnabled
        ? () {
            setState(() {
              widget.selected = !widget.selected;
              widget.callback(widget.label, widget.selected);
            });
          }
        : null;
    ButtonStyle? style;
    if (widget.getDefaultStyle != null) {
      style = widget.getDefaultStyle!(widget.selected, colors);
    }

    IconData icon = widget.icon;

    return 
    // Ink(
    //     color: widget.selected ? Colors.grey : Colors.white,
    //     child: 
        RawMaterialButton(
          padding: const EdgeInsets.all(2),
            fillColor: Colors.white,
            splashColor: Colors.amber[100],
            shape: const CircleBorder(),
          // isSelected: widget.selected,
          onPressed: onPressed,
          // isSelected: widget.selected,
          child: Icon(icon),
          // style: style,
        // )
        );
  }
}

ButtonStyle enabledFilledButtonStyle(bool selected, ColorScheme colors) {
  return IconButton.styleFrom(
    side: const BorderSide(color: Colors.black),
    foregroundColor: selected ? Colors.black : Colors.white,
    shape:const CircleBorder(),
    backgroundColor: selected ? Colors.black : Colors.white,
  );
}
