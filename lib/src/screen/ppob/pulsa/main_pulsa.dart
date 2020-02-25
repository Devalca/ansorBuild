import 'package:ansor_build/src/screen/ppob/pulsa/tabbar_pulsa.dart';
import 'package:flutter/material.dart';


class TabBarDemo extends StatefulWidget {
  @override
  _TabBarDemoState createState() => _TabBarDemoState();
}

class _TabBarDemoState extends State<TabBarDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top:80.0),
             child: Column(
               children: <Widget>[
                 Expanded(child: TabBarPulsa()),
               ],
             ),
          ),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(),
              child: new Column(
                children: <Widget>[
                  _buildButtonsRow()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
    Widget _buildButtonsRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 125.0,
        width: 450.0,
        color: Colors.greenAccent,
        child: Text('INI IKLAN LAGI`'),
      ),
    );
  }
}
