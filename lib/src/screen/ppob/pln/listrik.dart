import 'package:ansor_build/src/screen/ppob/pulsa/pascabayar/pulsa_screen_pasca.dart';
import 'package:ansor_build/src/screen/ppob/pulsa/prabayar/pulsa_screen.dart';
import 'package:flutter/material.dart';
import 'package:ansor_build/src/screen/ppob/pln/listrik_pascabayar.dart'
    as pascabayar;
import 'package:ansor_build/src/screen/ppob/pln/listrik_prabayar.dart'
    as prabayar;

class Listrik extends StatefulWidget {
  final int index;
  Listrik({this.index});

  @override
  _ListrikState createState() => _ListrikState();
}

class _ListrikState extends State<Listrik> with SingleTickerProviderStateMixin {
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
        initialIndex: widget.index == null ? 0 : widget.index,
        length: 2,
        child: Scaffold(
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pop(context, true);
                  }),
              elevation: 0.2,
              backgroundColor: Colors.white,
              title: Text(
                'Listrik PLN',
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
                                child: Tab(text: 'Prabayar'),
                              ),
                              Container(
                                child: Tab(text: 'Pascabayar'),
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
            )),
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: Colors.white,
    //     iconTheme: IconThemeData(
    //       color: Colors.black,
    //     ),
    //     title: Text(
    //       'Listrik PLN',
    //       style: TextStyle(color: Colors.black),
    //     ),
    //     bottom: new TabBar(
    //       controller: controller,
    //       indicatorColor: Colors.green,
    //       indicatorWeight: 4,
    //       labelColor: Colors.black,
    //       unselectedLabelColor: Colors.black38,
    //       tabs: <Widget>[
    //         new Tab(text: "Prabayar"),
    //         new Tab(text: "Pascabayar",),
    //       ],
    //     ),
    //   ),

    //   body: new TabBarView(
    //     controller: controller,
    //     children: <Widget>[
    //       new prabayar.ListrikPrabayar(),
    //       new pascabayar.ListrikPascabayar(),
    //     ],
    //   ),
    // );
  }
}
