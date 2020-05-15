import 'package:ansor_build/src/screen/beranda/landing_screen.dart';
import 'package:ansor_build/src/screen/transfer/kesesama.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransferBerhasil extends StatefulWidget {
  @override
  _TransferBerhasilState createState() => _TransferBerhasilState();
}

class _TransferBerhasilState extends State<TransferBerhasil> {
  @override
  Widget build(BuildContext context) {
    Widget middleSection = Expanded(
      child: new Container(
          color: Colors.white,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        border: Border.all(color: Colors.grey[300], width: 1)),
                  ),
                ),
                Container(height: 10),
                Center(
                  child: Text("Transaksi Berhasil",
                      style: new TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green)),
                ),
                Container(height: 15),
                Center(
                  child: Text(
                      NumberFormat.simpleCurrency(
                              locale: 'id', decimalDigits: 0)
                          .format(0),
                      style: new TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green)),
                ),
                Container(height: 5),
                Center(
                  child: Text("tgl",
                      style:
                          new TextStyle(fontSize: 12.0, color: Colors.black)),
                ),
                Center(
                  child: Text("No Transaksi",
                      style:
                          new TextStyle(fontSize: 12.0, color: Colors.black)),
                ),
                Container(height: 15),
                Text("Dari",
                    style: new TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold)),
                Container(height: 5),
                Row(children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 12.0),
                    child: Image.asset("lib/src/assets/BPJS.png"),
                  ),
                  Container(
                    child: Text("nama" + "\n" + "un1ty - nomor",
                        style:
                            new TextStyle(color: Colors.black, fontSize: 12.0)),
                  ),
                ]),
                Container(height: 5),
                Divider(
                  height: 12,
                  color: Colors.black26,
                ),
                Container(height: 5),
                Text("Penerima",
                    style: new TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold)),
                Container(height: 5),
                Row(children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 12.0),
                    child: Image.asset("lib/src/assets/BPJS.png"),
                  ),
                  Container(
                    child: Text("nama" + "\n" + "un1ty - nomor",
                        style:
                            new TextStyle(color: Colors.black, fontSize: 12.0)),
                  ),
                ]),
                Container(height: 5),
                Divider(
                  height: 12,
                  color: Colors.black26,
                ),
              ],
            ),
          )),
    );

    Widget bottomBanner = new Column(children: <Widget>[
      Divider(
        height: 12,
        color: Colors.black26,
      ),
      Container(height: 5),
      Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
        child: SizedBox(
          width: double.infinity,
          height: 40,
          child: RaisedButton(
            child: Text('SELESAI',
                style: TextStyle(color: Colors.green, fontSize: 16.0)),
            color: Colors.white,
            onPressed: () {},
          ),
        ),
      ),
      Container(height: 10),
    ]);

    Widget body = new Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        middleSection,
        bottomBanner,
      ],
    );

    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.close),
          onPressed: () => Navigator.push(context,
              new MaterialPageRoute(builder: (__) => new LandingPage())),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0.2,
      ),
      body: Padding(
        padding: new EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
        child: body,
      ),
    );
  }
}
