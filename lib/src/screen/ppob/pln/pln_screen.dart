import 'package:flutter/material.dart';
import 'package:ansor_build/src/screen/ppob/pln/listrik_pascabayar.dart' as pascabayar;
import 'package:ansor_build/src/screen/ppob/pln/listrik_prabayar.dart' as prabayar;

class PlnScreen extends StatefulWidget {

  @override
    _PlnScreenState createState() => _PlnScreenState();
  }

class _PlnScreenState extends State<PlnScreen> with SingleTickerProviderStateMixin{

  TabController controller;

  @override
  void initState() {
    controller = new TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listrik PLN'),
        bottom: new TabBar(
          controller: controller,
          indicatorColor: Colors.green,
          indicatorWeight: 4,
          labelColor: Colors.green,
          unselectedLabelColor: Colors.black38,
          tabs: <Widget>[
            new Tab(text: "Prabayar"),
            new Tab(text: "Pasca Bayar",),
          ],
        ),
      ),
      
      body: new TabBarView(
        controller: controller,
        children: <Widget>[
          new prabayar.ListrikPrabayar(),
          new pascabayar.ListrikPascabayar(),
        ],
      ),
    );
  }
}