import 'package:flutter/material.dart';

import 'package:trip_cost/theme.dart';

class Button extends StatelessWidget {
  Button({
    this.label,
    this.onPressed,
    this.margin,
    this.textStyle,
    this.color,
  });

  final String label;
  final Function onPressed;
  final TextStyle textStyle;
  final EdgeInsetsGeometry margin;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: margin,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            label,
            textScaleFactor: AppTheme.textScaleFactor,
            style: textStyle,
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(AppTheme.padding),
            primary: color,
          ),
        ),
      ),
    );
  }
}
