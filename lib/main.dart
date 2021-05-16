import 'package:flutter/material.dart';

void main() => runApp(TripCostApp());

class AppTheme {
  static const textScaleFactor = 1.5;
  static const padding = 10.0;
}

enum Currency { USD, EURO, POUND }

Map<Currency, String> currencyMap = {
  Currency.USD: '\$',
  Currency.EURO: '€',
  Currency.POUND: '£',
};

class TripCostApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trip Cost Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Trip Cost'),
          centerTitle: true,
        ),
        body: TripForm(),
      ),
    );
  }
}

class TripForm extends StatefulWidget {
  @override
  _TripFormState createState() => _TripFormState();
}

class _TripFormState extends State<TripForm> {
  var distanceCtrl = TextEditingController();
  var distancePerUnitCtrl = TextEditingController();
  var fuelCostCtrl = TextEditingController();

  var selectedCurrency = Currency.USD;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.padding),
      child: Column(
        children: <Widget>[
          InputText(
            label: 'Distance',
            hint: 'e.g. 124',
            controller: distanceCtrl,
          ),
          InputText(
            label: 'Distance Per Unit',
            hint: 'e.g. 17',
            controller: distancePerUnitCtrl,
          ),
          Row(
            children: [
              Expanded(
                child: InputText(
                  label: 'Fuel Cost',
                  hint: 'e.g. 1.65',
                  controller: fuelCostCtrl,
                ),
              ),
              Expanded(
                child: Center(
                  child: DropdownButton(
                    value: selectedCurrency,
                    onChanged: onCurrencyChanged,
                    items: Currency.values
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
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void onCurrencyChanged(val) {
    setState(() => selectedCurrency = val);
  }
}

class InputText extends StatelessWidget {
  InputText({this.label, this.hint, this.controller});

  final String label;
  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.padding / 2),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
