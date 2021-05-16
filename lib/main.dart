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
  num totalCost = 0;

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
                child: DropDownCurrency(
                  list: Currency.values,
                  selected: selectedCurrency,
                  onChanged: onCurrencyChanged,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: onSubmit,
                  child: Text(
                    'Submit',
                    textScaleFactor: AppTheme.textScaleFactor,
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(AppTheme.padding),
                  ),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: onReset,
                  child: Text(
                    'Reset',
                    textScaleFactor: AppTheme.textScaleFactor,
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).buttonColor,
                    padding: EdgeInsets.all(AppTheme.padding),
                  ),
                ),
              ),
            ],
          ),
          Text(
            'Total Cost = $totalCost ${currencyMap[selectedCurrency]}',
            textScaleFactor: AppTheme.textScaleFactor,
          ),
        ],
      ),
    );
  }

  void onCurrencyChanged(val) {
    setState(() => selectedCurrency = val);
  }

  void onSubmit() {
    double distance = double.tryParse(distanceCtrl.text);
    double distancePerUnit = double.tryParse(distancePerUnitCtrl.text);
    double fuelCost = double.tryParse(fuelCostCtrl.text);

    if (distance != null && distancePerUnit != null && fuelCost != null) {
      setState(() => totalCost = distance / distancePerUnit * fuelCost);
    }
  }

  void onReset() {
    distanceCtrl.text = '';
    distancePerUnitCtrl.text = '';
    fuelCostCtrl.text = '';

    setState(() => totalCost = 0);
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

class DropDownCurrency extends StatelessWidget {
  DropDownCurrency({this.list, this.selected, this.onChanged});

  final List<Currency> list;
  final Currency selected;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButton(
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
