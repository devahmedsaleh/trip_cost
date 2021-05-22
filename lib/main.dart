import 'package:flutter/material.dart';

import 'package:trip_cost/currency.dart';
import 'package:trip_cost/theme.dart';
import 'package:trip_cost/widgets/button.dart';
import 'package:trip_cost/widgets/drop-down.dart';
import 'package:trip_cost/widgets/input-text.dart';

void main() => runApp(TripCostApp());

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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppTheme.padding),
            child: Row(
              children: [
                Button(
                  label: 'Submit',
                  onPressed: onSubmit,
                  margin: EdgeInsets.only(right: AppTheme.padding),
                ),
                Button(
                  label: 'Reset',
                  onPressed: onReset,
                  margin: EdgeInsets.only(left: AppTheme.padding),
                  color: Theme.of(context).buttonColor,
                  textStyle: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
              ],
            ),
          ),
          Text(
            'Total Cost = ${totalCost.toStringAsFixed(2)} ${currencyMap[selectedCurrency]}',
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
