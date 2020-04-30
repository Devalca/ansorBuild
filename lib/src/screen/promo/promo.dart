import 'package:ansor_build/src/screen/beranda/landing_screen.dart';
import 'package:flutter/material.dart';

class Promo extends StatefulWidget {
  @override
  _PromoState createState() => _PromoState();
}

class _PromoState extends State<Promo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (__) => new LandingPage()));
                }),
            backgroundColor: Colors.white,
            title: Text(
              "Info dan Promo Spesial",
              style: TextStyle(color: Colors.black),
            )),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            height: 150,
            width: double.maxFinite,
            child: Card(
              elevation: 2,
            ),
          ),
        ));
  }
}
