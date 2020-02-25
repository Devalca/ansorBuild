import 'package:flutter/material.dart';

class BodyTabBar1 extends StatefulWidget {
  @override
  _BodyTabBar1State createState() => _BodyTabBar1State();
}

class _BodyTabBar1State extends State<BodyTabBar1> {
  @override
  Widget build(BuildContext context) {
     return MaterialApp(
       debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            bottom: TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black,
              indicatorColor: Colors.green,
              tabs: [
                Tab(text: "Prabayar"),
                Tab(text: "Pasca Bayar"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Text('INI PRABAYAR'),
              Text('INI PASCA BAYAR')
            ],
          ),
        ),
      ),
    );
  }
}