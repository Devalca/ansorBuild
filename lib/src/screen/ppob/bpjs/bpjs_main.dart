import 'package:ansor_build/src/screen/ppob/pulsa/pascabayar/pulsa_screen_pasca.dart';
import 'package:ansor_build/src/screen/ppob/pulsa/prabayar/pulsa_screen.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context, true);
              }
            ),
            elevation: 0.2,
            backgroundColor: Colors.white,
            title: Text(
              'BPJS',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: Stack(
            fit: StackFit.expand,
            overflow: Overflow.clip,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 0, left: 12.0, right: 12.0),
                child: Scaffold(
                  resizeToAvoidBottomPadding: false,
                  appBar: AppBar(
                    elevation: 0.0,
                    backgroundColor: Colors.white,
                    bottom: PreferredSize(
                      preferredSize: Size(0.5, 0.5),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 7.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          border: Border.all(width: 1, color: Colors.white),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: TabBar(
                          labelColor: Colors.green,
                          indicatorColor: Colors.green,
                          tabs: [
                            Container(
                              child: Tab(text: 'Kesehatan'),
                            ),
                            Container(
                              child: Tab(text: 'Ketenagakerjaan'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  body: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      prabayar.ListrikPrabayar(),
                      pascabayar.ListrikPascabayar(),
                    ],
                  ),
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}