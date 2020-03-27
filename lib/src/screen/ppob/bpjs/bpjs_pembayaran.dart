import 'package:ansor_build/src/screen/ppob/bpjs/pembayaran_berhasil.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:indonesia/indonesia.dart';
import 'package:intl/intl.dart';

class BpjsPembayaran extends StatefulWidget {
  final String jenis;
  BpjsPembayaran({this.jenis});

  @override
    _BpjsPembayaranState createState() => _BpjsPembayaranState();
}

class _BpjsPembayaranState extends State<BpjsPembayaran> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Pembayaran',
          style: TextStyle(color: Colors.black),
        )
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 333,
                  height: 35,
                  child: RaisedButton(
                    child: Text('BAYAR', style: TextStyle(color: Colors.white)),
                    color: Colors.green,
                    onPressed: () {
                      setState(() => _isLoading = true);
                      Navigator.push(context, new MaterialPageRoute(builder: (__) => new PembayaranBerhasil(jenis: widget.jenis)));
                      setState(() => _isLoading = false);
                    },
                  ),
                )
              ]
            )
          ),
        
        elevation: 0
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Container(
                height: 70.0,
                child: Row(
                  children: <Widget>[

                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 12.0),
                      height: 90.0,
                      width: 90.0,
                      child: Image.asset("lib/src/assets/BPJS.png"),
                    ),

                    Container(
                      child: widget.jenis == "kesehatan" ? 
                        Text("BPJS Kesehatan" + "\n" + "Nomor" + "\n" + "Nama") : 
                        Text("BPJS Ketenagakerjaan" + "\n" + "Nomor" + "\n" + "Nama" + " - " + "KCP"),
                    ),
                  ]
                ),
              ),

              Container( height: 15 ),

              Text("Detail Pembayaran", textAlign: TextAlign.start, style: new TextStyle(fontSize: 14.0)),

              Container( height: 15 ),

              widget.jenis == "kesehatan" ?
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  width: double.infinity,
                  height: 150.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    border: Border.all(color: Colors.grey[300],width: 1)
                  ),
                  child: Column(
                    children: <Widget>[
                      
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Text("Periode"),
                            ),
                            Container(
                              child: Text("tanggal"),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Text("Jumlah Keluarga"),
                            ),
                            Container(
                              child: Text("jumlah"),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Text("Total Tagihan"),
                            ),
                            Container(
                              child: Text("Rp"),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Text("Biaya Pelayanan"),
                            ),
                            Container(
                              child: Text("Rp"),
                            ),
                          ],
                        ),
                      ),

                      Divider( height: 12, color: Colors.black ),

                      Expanded(
                        child: Row(
                          
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Text("Total"),
                            ),
                            Container(
                              child: Text("Rp"),
                            ),
                          ],
                        ),
                      ),

                    ],
                  )
                ) :
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  width: double.infinity,
                  height: 240.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    border: Border.all(color: Colors.grey[300],width: 1)
                  ),
                  child: Column(
                    children: <Widget>[
                      
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Text("Periode"),
                            ),
                            Container(
                              child: Text("tanggal"),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Text("Jaminan Kecelakaan Kerja"),
                            ),
                            Container(
                              child: Text("Rp"),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Text("Jaminan Kematian"),
                            ),
                            Container(
                              child: Text("Rp"),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Text("Jaminan Hari Tua"),
                            ),
                            Container(
                              child: Text("Rp"),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Text("Total Tagihan"),
                            ),
                            Container(
                              child: Text("Rp"),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Text("Biaya Pelayanan"),
                            ),
                            Container(
                              child: Text("Rp"),
                            ),
                          ],
                        ),
                      ),

                      Divider( height: 12, color: Colors.black ),

                      Expanded(
                        child: Row(
                          
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Text("Total"),
                            ),
                            Container(
                              child: Text("total"),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),

              Container( height: 15 ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                width: double.infinity,
                height: 80.0,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  border: Border.all(color: Colors.grey[300], width: 1)
                ),
                child: Column(
                  children: <Widget>[
                    
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "Un1ty"
                            ),
                          ),
                          Container(
                            child: Icon(
                              Icons.more_vert,
                              color: Colors.green,
                              size: 24.0,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Divider( height: 12, color: Colors.black ),

                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "Saldo Un1ty",
                              style: new TextStyle(color: Colors.green)
                            ),
                          ),
                          Container(
                            child: Text("Rp"),
                            // child: FutureBuilder<Wallet>(
                            //   future: _apiService.getSaldo(),
                            //   builder: (context, snapshot) {
                            //     if (snapshot.hasData) {
                            //       return Text(NumberFormat.simpleCurrency(locale: 'id', decimalDigits: 0).format(snapshot.data.data[0].saldoAkhir));
                            //     } else if (snapshot.hasError) {
                            //       return Text("${snapshot.error}");
                            //     }
                            //     return CircularProgressIndicator();
                            //   },
                            // )
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Container( height: 15 ),

            ]
          )
        ),
      )
    );
  }
}