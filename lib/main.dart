import 'package:flutter/material.dart';

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
          title: Text(
            'Trip Cost',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
