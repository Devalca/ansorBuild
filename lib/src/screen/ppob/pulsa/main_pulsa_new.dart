import 'package:ansor_build/src/screen/ppob/pulsa/pascabayar/pulsa_screen_pasca.dart';
import 'package:ansor_build/src/screen/ppob/pulsa/prabayar/pulsa_screen.dart';
import 'package:flutter/material.dart';

class MainPulsa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.1,
            backgroundColor: Colors.white,
            bottom: TabBar(
              labelColor: Colors.black,
              indicatorColor: Colors.green,
              tabs: [
                Tab(text: "PraBayar",),
                Tab(text: "PascaBayar",)
              ],
            ),
            title: Text('PPOB PULSA', style: TextStyle(color: Colors.black),),
          ),
          body: TabBarView(
             physics: NeverScrollableScrollPhysics(),
            children: [
              PulsaPage(),
              PulsaPascaPage()
            ],
          ),
        ),
      ),
    );
  }
}