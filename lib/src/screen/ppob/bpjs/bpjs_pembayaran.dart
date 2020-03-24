import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:indonesia/indonesia.dart';
import 'package:intl/intl.dart';
import 'package:ansor_build/src/screen/ppob/pln/pembayaran_berhasil.dart';
import 'package:ansor_build/src/screen/ppob/pln/pembayaran_gagal.dart';
import 'package:ansor_build/src/model/pln_model.dart';
import 'package:ansor_build/src/model/wallet_model.dart';
import 'package:ansor_build/src/service/pln_services.dart';
import 'package:ansor_build/src/service/api_service.dart';

class BPJSPembayaran extends StatefulWidget {
  @override
  _BPJSPembayaranState createState() => _BPJSPembayaranState();
}

class _BPJSPembayaranState extends State<BPJSPembayaran> {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              
              
                        Container(
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
                                      child: Text(
                                        "BPJS Kesehatan\n" + "Nomor "+ "123456" + "\n" + "nama"
                                      ),
                                    ),
                                  ]
                                ),
                              ),

                              Container( height: 15 ),

                              Text("Detail Pembayaran", textAlign: TextAlign.start, style: new TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),

                              Container( height: 15 ),

                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                width: double.infinity,
                                height: 140.0,
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
                                            child: Text("tanggal(periode)"),
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
                                            child: Text(NumberFormat.simpleCurrency(locale: 'id', decimalDigits: 0).format("snapshot.data.total")),
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
                                            child: Text(NumberFormat.simpleCurrency(locale: 'id', decimalDigits: 0).format(0)),
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
                                            child: Text(NumberFormat.simpleCurrency(locale: 'id', decimalDigits: 0).format("snapshot.data.total")),
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
                                          // Container(
                                          //   child: FutureBuilder<Wallet>(
                                          //     future: _apiService.getSaldo(),
                                          //     builder: (context, snapshot) {
                                          //       if (snapshot.hasData) {
                                          //         return Text(NumberFormat.simpleCurrency(locale: 'id', decimalDigits: 0).format(snapshot.data.data[0].saldoAkhir));
                                          //       } else if (snapshot.hasError) {
                                          //         return Text("${snapshot.error}");
                                          //       }
                                          //       return CircularProgressIndicator();
                                          //     },
                                          //   )
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ],
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
                                      child: Text('BAYAR', style: TextStyle(color: Colors.white)),
                                      color: Colors.green,
                                      onPressed: () {
                                        setState(() => _isLoading = true);
                                        
                                      },
                                    ),
                                  ),
                                ),
                              )
                            ]
                          ),
                        )
            ]
          )
        ),
      )
    );
  }
}