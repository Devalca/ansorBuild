import 'package:ansor_build/src/screen/beranda/landing_screen.dart';
import 'package:flutter/material.dart';

class SelesaiPage extends StatefulWidget {
  @override
  _SelesaiPageState createState() => _SelesaiPageState();
}

class _SelesaiPageState extends State<SelesaiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text('Transaksi Selesai'),
              RaisedButton(
                child: Text('Selesai'),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: 
                  (context) => LandingPage()
                  ));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}