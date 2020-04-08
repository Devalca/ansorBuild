import 'package:ansor_build/src/routes/routes.dart';
import 'package:ansor_build/src/screen/component/iklan_ppob.dart';
import 'package:ansor_build/src/screen/ppob/pulsa/pascabayar/pulsa_screen_pasca.dart';
import 'package:ansor_build/src/screen/ppob/pulsa/prabayar/pulsa_screen.dart';
import 'package:flutter/material.dart';

class MainPulsa extends StatefulWidget {
  final String noValue;
  final String noValue2;
  MainPulsa(this.noValue, this.noValue2);

  @override
  _MainPulsaState createState() => _MainPulsaState();
}

class _MainPulsaState extends State<MainPulsa> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String noValue = widget.noValue;
    String noValue2 = widget.noValue2;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
          // resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  _toLanding();
                }),
            elevation: 0.2,
            backgroundColor: Colors.white,
            title: Text(
              'Pulsa',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              height: 770,
              child: Stack(
                fit: StackFit.expand,
                overflow: Overflow.clip,
                children: <Widget>[
                  Container(
                    color: Colors.white,
                  ),
                  Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: 220,
                            color: Colors.white,
                          ),
                          Positioned(
                            top: 16,
                            left: 0,
                            right: 0,
                            bottom: 16,
                            child: Container(
                              height: 150,
                              child: IklanPpob(),
                            ),
                          )
                        ],
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 180, left: 16.0, right: 16.0),
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
                          PulsaPage(noValue),
                          PulsaPascaPage(noValue2),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }

  _toLanding() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.LandingScreen, (Route<dynamic> route) => false);
  }
}
