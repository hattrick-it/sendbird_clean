import 'package:flutter/material.dart';

class PatientSelectorScreen extends StatelessWidget {
  static const String routeName = '/patient-selector-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('patient'),
      ),
    );
  }
}
