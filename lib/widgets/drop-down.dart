import 'package:flutter/material.dart';

import 'package:trip_cost/currency.dart';
import 'package:trip_cost/theme.dart';

class DropDownCurrency extends StatelessWidget {
  DropDownCurrency({this.list, this.selected, this.onChanged});

  final List<Currency> list;
  final Currency selected;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButton<Currency>(
        value: selected,
        onChanged: onChanged,
        items: list
            .map(
              (c) => DropdownMenuItem<Currency>(
                child: Text(
                  currencyMap[c],
                  textScaleFactor: AppTheme.textScaleFactor,
                ),
                value: c,
              ),
            )
            .toList(),
      ),
    );
  }
}
