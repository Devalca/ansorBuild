import 'package:ansor_build/src/screen/beranda/beranda_screen.dart';
import 'package:flutter/material.dart';
import 'package:ansor_build/src/screen/ppob/pln/listrik.dart';

class PembayaranGagal extends StatefulWidget {
  @override
  final String pesan, jenis;
  PembayaranGagal({this.pesan, this.jenis});

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
            onPressed: () => Navigator.push(context,
                new MaterialPageRoute(builder: (__) => new BerandaPage())),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
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
                                            new Listrik(index: 0,)));
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
                                      builder: (__) => BerandaPage()));
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
                  widget.jenis == "prabayar"
                      ? "Transaksi Gagal\n" + widget.pesan.substring(12, 26)
                      : "Transaksi Gagal\n" + widget.pesan,
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red)),
        ));
  }
}
