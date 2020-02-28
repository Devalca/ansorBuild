import 'package:ansor_build/src/screen/ppob/pulsa/pascabayar/pulsa_screen_pasca.dart';
import 'package:ansor_build/src/screen/ppob/pulsa/prabayar/detail_screen.dart';
import 'package:ansor_build/src/screen/ppob/pulsa/prabayar/pulsa_screen.dart';
import 'package:flutter/material.dart';

class TabBarPulsa extends StatefulWidget {
  @override
  _TabBarPulsaState createState() => _TabBarPulsaState();
}

class _TabBarPulsaState extends State<TabBarPulsa> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.grey[200],
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
          body: Container(
            child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              PulsaPage(), 
              PulsaPascaPage()
            ],
          ),
          )
        ),
      ),
    );
  }
}
