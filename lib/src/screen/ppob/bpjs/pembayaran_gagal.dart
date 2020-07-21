import 'package:ansor_build/src/screen/beranda/landing_screen.dart';
import 'package:ansor_build/src/screen/ppob/bpjs/bpjs_main.dart';
import 'package:flutter/material.dart';

class PembayaranGagalBpjs extends StatefulWidget {
  final String pesan, jenis;
  final int index;
  PembayaranGagalBpjs({this.pesan, this.jenis, this.index});

  @override
  _PembayaranGagalBpjsState createState() => _PembayaranGagalBpjsState();
}

class _PembayaranGagalBpjsState extends State<PembayaranGagalBpjs> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
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
        bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: SizedBox(
                          width: 150,
                          height: 35,
                          child: RaisedButton(
                              child: Text('COBA LAGI',
                                  style: TextStyle(color: Colors.white)),
                              color: Colors.green,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (__) =>
                                            new Bpjs(index: widget.index)));
                              }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: SizedBox(
                          width: 150,
                          height: 35,
                          child: RaisedButton(
                            child: Text('BATAL',
                                style: TextStyle(color: Colors.black)),
                            color: Colors.white,
                            onPressed: () {
                              setState(() => _isLoading = true);

                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (__) => LandingPage()));
                              setState(() => _isLoading = false);
                            },
                          ),
                        ),
                      )
                    ])),
            elevation: 0),
        body: Center(
          child: widget.pesan == ""
              ? Text("Transaksi Gagal\nSilahkan coba beberapa saat lagi",
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red))
              : Text(
                  widget.jenis == "kesehatan"
                      ? "Transaksi Gagal\n\n" + widget.pesan
                      : "Transaksi Gagal\n\n" + widget.pesan,
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red)),
        ));
  }
}
