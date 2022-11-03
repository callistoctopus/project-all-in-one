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
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5),
        height: 80,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.labelIcon.length,
            itemBuilder: (context, i) {
              String label = widget.labelIcon.keys.elementAt(i);
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

    return IconButton(
      isSelected: widget.selected,
      icon: Icon(icon),
      selectedIcon: Icon(icon),
      onPressed: onPressed,
      style: style,
    );
  }
}

ButtonStyle enabledFilledButtonStyle(bool selected, ColorScheme colors) {
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

void main() {
  runApp(const IconButtonToggleApp());
}

class IconButtonToggleApp extends StatelessWidget {
  const IconButtonToggleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: const Color(0xff6750a4),
        useMaterial3: true,
        // Desktop and web platforms have a compact visual density by default.
        // To see buttons with circular background on desktop/web, the "visualDensity"
        // needs to be set to "VisualDensity.standard".
        visualDensity: VisualDensity.standard,
      ),
      title: 'Icon Button Types',
      home: Scaffold(
        body: IconToggleButtons(
          labelIcon: {'abc': Icons.save},
          onSelect: (n) {}, defaultSelected: 'abc',
        ),
      ),
    );
  }
}
