import 'package:flutter/material.dart';

class PulsaPage extends StatefulWidget {
  @override
  _PulsaPageState createState() => _PulsaPageState();
}

class _PulsaPageState extends State<PulsaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PPOB Pulsa'),
      ),
      body: Container(
        child: Text('Pulsa'),
      ),
    );
  }
}