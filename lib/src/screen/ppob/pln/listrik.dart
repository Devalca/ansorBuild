import 'package:flutter/material.dart';
import 'package:ansor_build/src/screen/ppob/pln/listrik_pascabayar.dart' as pascabayar;
import 'package:ansor_build/src/screen/ppob/pln/listrik_prabayar.dart' as prabayar;

class Listrik extends StatefulWidget {

  @override
    _ListrikState createState() => _ListrikState();
  }

class _ListrikState extends State<Listrik> with SingleTickerProviderStateMixin{

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
        // backgroundColor: Colors.white,
        title: Text(
          'Listrik PLN',
          style: TextStyle(color: Colors.white),
        ),
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