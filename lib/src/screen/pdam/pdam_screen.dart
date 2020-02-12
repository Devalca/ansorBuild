import 'package:ansor_build/src/screen/pdam/pdampay_screen.dart';
import 'package:flutter/material.dart';

class PdamPage extends StatefulWidget {
  @override
  _PdamPageState createState() => _PdamPageState();
}

class _PdamPageState extends State<PdamPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Air PDAM'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                   padding: const EdgeInsets.only(top:15.0),
                  child: Text('Nama Wilayah'),
                ),
                Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    width: 1.0,
                  ))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Text('Pilih Daerah'),
                      ),
                      Container(
                        child: Icon(Icons.arrow_back_ios),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top:15.0),
                  child: Text('Nomor Pelanggan'),
                ),
                Container(
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 400.0,
            padding: const EdgeInsets.all(10.0),
            child: RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: 
                (context) => PdamPayPage()
                ));
              },
              child: Text('BELI'),
            ),
          ),
        ],
      ),
    );
  }
}
