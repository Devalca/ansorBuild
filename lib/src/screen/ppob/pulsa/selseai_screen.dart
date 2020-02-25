import 'package:flutter/material.dart';

class SesPulsaPage extends StatefulWidget {
  @override
  _SesPulsaPageState createState() => _SesPulsaPageState();
}

class _SesPulsaPageState extends State<SesPulsaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaksi Sukses'),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 60.0, bottom: 15.0),
                        height: 130.0,
                        width: 130.0,
                        child: Image.asset("lib/src/assets/qr-code.png"),
                      ),
                      Container(
                        margin: EdgeInsets.all(12.0),
                        child: Text(
                          'Transaksi Berhasil',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Container(
                        child: Text('20 Jan 2020, 10.24'),
                      ),
                      Container(
                        child: Text('via Unity'),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 70.0),
                        child: Text('Detail Pembayaran'),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 12.0),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          border:
                              Border.all(width: 1.0, color: Colors.grey[200]),
                        ),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(bottom: 12.0),
                                  child: Text('Jenis Layanan'),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 12.0),
                                  child: Text('Jenis Layanan'),
                                ),
                                Container(),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(bottom: 12.0),
                                  child: Text('Nomor Handphone'),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 12.0),
                                  child: Text('Nomor Handphone'),
                                ),
                                Container(),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(bottom: 12.0),
                                  child: Text('Provider'),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 12.0),
                                  child: Text('Provider'),
                                ),
                                Container(),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(bottom: 12.0),
                                  child: Text('Nomor Transaksi'),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 12.0),
                                  child: Text('Nomor Transaksi'),
                                ),
                                Container(),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: Text('Total Tagihan'),
                                ),
                                Container(
                                  child: Text('Total Tagihan'),
                                ),
                                Container(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(16),
              width: 450.0,
              child: RaisedButton(
                onPressed: () {
                  print("object");
                },
                child: Text('Selesai'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
