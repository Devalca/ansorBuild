
import 'package:ansor_build/src/screen/ppob/pdam/selesai_screen.dart';
import 'package:flutter/material.dart';

class PdamPayPage extends StatefulWidget {
  @override
  _PdamPayPageState createState() => _PdamPayPageState();
}

class _PdamPayPageState extends State<PdamPayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pembayaran'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 90.0,
                          width: 90.0,
                          child: Image.asset("lib/src/assets/qr-code.png"),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Air PDAM Kota Bandung'),
                              Text('Nomor 1234567890'),
                              Text('Toxic - 1234567890')
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Text('Detail Pembayaran'),
                  ),
                  Container(
                    margin: const EdgeInsets.all(16.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: Colors.grey[200]),
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Text('Periode'),
                            ),
                            Container(
                              child: Text('Jan 2020'),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Text('Total Harga'),
                            ),
                            Container(
                              child: Text('Rp 50.000'),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Text('Biaya Pelayanan'),
                            ),
                            Container(
                              child: Text('Rp 2.500'),
                            ),
                          ],
                        ),
                        Divider(),
                        Container(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Text('Total'),
                              ),
                              Container(
                                child: Text('Rp 52.500'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Container ke dua

                  Container(
                    margin: const EdgeInsets.all(16.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(width: 1.0, color: Colors.grey[200]),
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Text('Unity'),
                            ),
                            Container(
                              child: Icon(Icons.menu),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    child: Icon(Icons.account_balance_wallet),
                                  ),
                                  Container(
                                    child: Text('Saldo Unity'),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Text('Rp 1.050.000'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              width: 450.0,
              child: RaisedButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: 
                  (context) => SelesaiPage()
                  ));
                },
                child: Text('BAYAR'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
