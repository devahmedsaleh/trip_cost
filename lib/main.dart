import 'package:flutter/material.dart';

void main() => runApp(TripCostApp());

class AppTheme {
  static const textScaleFactor = 1.5;
  static const padding = 10.0;
}

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.padding),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppTheme.padding / 2),
            child: TextField(
              controller: distanceCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Distance',
                hintText: 'e.g. 124',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
