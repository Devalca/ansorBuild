import 'package:ansor_build/src/screen/beranda/beranda_screen.dart';
import 'package:flutter/material.dart';
import 'package:ansor_build/src/screen/ppob/pln/listrik.dart';

class PembayaranGagal extends StatefulWidget {
  @override
    _PembayaranGagalState createState() => _PembayaranGagalState();
}

class _PembayaranGagalState extends State<PembayaranGagal> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.close),
          onPressed: () => Navigator.push(context, new MaterialPageRoute(builder: (__) => new BerandaPage())),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Text("Transaksi Gagal", style: new TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.red)),
              
              Container( height: 15 ),
              
              Text("Transaksi gagal silahkan coba beberapa saat lagi", textAlign: TextAlign.center, style: new TextStyle(fontSize: 12.0)),
              
              Container( height: 15 ),

              Container(
                alignment: Alignment.bottomCenter,
                child: Align(
                  child: SizedBox(
                    width :double.infinity,
                    height: 35,
                    child: RaisedButton(
                      child: Text('COBA LAGI', style: TextStyle(color: Colors.white)),
                      color: Colors.green,
                      onPressed: () {
                        setState(() => _isLoading = true);

                        Navigator.push(context, new MaterialPageRoute(builder: (__) => new Listrik()));
                        setState(() => _isLoading = false);
                      },
                    ),
                  ),
                ),
              ),

              Container( height: 15 ),

              Container(
                alignment: Alignment.bottomCenter,
                child: Align(
                  child: SizedBox(
                    width :double.infinity,
                    height: 35,
                    child: RaisedButton(
                      child: Text('BATAL', style: TextStyle(color: Colors.black)),
                      color: Colors.white,
                      onPressed: () {
                        setState(() => _isLoading = true);

                        Navigator.push(context, new MaterialPageRoute(builder: (__) => new Listrik()));
                          setState(() => _isLoading = false);
                      },
                    ),
                  ),
                ),
              ),
            ]
          )
        )
      )
    );
  }
}