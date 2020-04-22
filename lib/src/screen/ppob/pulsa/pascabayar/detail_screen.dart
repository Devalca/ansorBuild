//Detail Pembayaran Pascabayar
import 'dart:convert';
import 'package:ansor_build/src/model/pulsa_model.dart';
import 'package:ansor_build/src/model/wallet_model.dart';
import 'package:ansor_build/src/screen/component/formatIndo.dart';
import 'package:ansor_build/src/screen/component/loading.dart';
import 'package:ansor_build/src/service/local_service.dart';
import 'package:ansor_build/src/service/pulsa_service.dart';
import 'package:ansor_build/src/service/wallet_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../selseai_screen.dart';

class PascaBayarDetailPage extends StatefulWidget {
  final String koId;
  PascaBayarDetailPage(this.koId);

  @override
  _PascaBayarDetailPageState createState() => _PascaBayarDetailPageState();
}

class _PascaBayarDetailPageState extends State<PascaBayarDetailPage> {
  String _idWallet;
  DateTime dateTime;
  Future<Album> futureAlbum;
  PulsaService _pulsaService = PulsaService();
  WalletService _walletService = WalletService();
  LocalService _localService = LocalService();

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
    _localService.getWalletId().then(updateWallet);
  }

  void updateWallet(String idWallet) {
    setState(() {
      this._idWallet = idWallet;
    });
  }

  Future<Album> fetchAlbum() async {
    // String baseUrl = "http://192.168.10.11:3000/ppob/pulsa/";
    // String baseUrl = "https://afternoon-waters-38775.herokuapp.com/ppob/pulsa/";
    String baseUrl = "http://103.9.125.18:3000/ppob/pulsa/";
    final response = await http.get(baseUrl + widget.koId);
    if (response.statusCode == 200) {
      return albumFromJson(response.body);
    } else {
      print("SATATUS CODENYA: " + response.statusCode.toString());
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context, true);
            }),
        backgroundColor: Colors.white,
        title: Text(
          'Pembayaran',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: FutureBuilder<Album>(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              dateTime = snapshot.data.data[0].periode;
              var formatterDate = DateFormat('MMMM yyyy').format(dateTime);
              return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 12.0),
                                  height: 70.0,
                                  width: 70.0,
                                  child: Image.asset(
                                    "lib/src/assets/PULSA.png",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text('Pulsa Pascabayar'),
                                      Text('Nomor ' +
                                          snapshot.data.data[0].noHp),
                                      Text(snapshot.data.data[0].provider)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(left: 16.0),
                                child: Text('Detail Pembayaran'),
                              ),
                              Container(
                                margin: const EdgeInsets.all(16.0),
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1.0, color: Colors.grey[200]),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          padding:
                                              EdgeInsets.only(bottom: 16.0),
                                          child: Text('Periode'),
                                        ),
                                        Container(
                                          child: Text(formatBlnTahun(dateTime)
                                              .toString()),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          padding:
                                              EdgeInsets.only(bottom: 16.0),
                                          child: Text('Total Tagihan'),
                                        ),
                                        Container(
                                            child: Text(formatRupiah(snapshot
                                                    .data.data[0].nominal)
                                                .replaceAll("Rp ", "Rp"))),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          padding:
                                              EdgeInsets.only(bottom: 16.0),
                                          child: Text('Biaya Pelayanan'),
                                        ),
                                        Container(
                                          child: Text(formatRupiah(snapshot
                                                  .data.data[0].adminFee)
                                              .replaceAll("Rp ", "Rp")),
                                        ),
                                      ],
                                    ),
                                    Divider(),
                                    Container(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            child: Text('Total'),
                                          ),
                                          Container(
                                            child: Text(formatRupiah(snapshot
                                                    .data.data[0].totalHarga)
                                                .replaceAll("Rp ", "Rp")),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          // Container ke dua

                          Container(
                            margin: const EdgeInsets.all(16.0),
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(
                                  width: 1.0, color: Colors.grey[200]),
                            ),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      child: Text('Un1ty'),
                                    ),
                                    Container(
                                      child: Icon(
                                        Icons.more_vert,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            padding:
                                                EdgeInsets.only(right: 10.0),
                                            child: Icon(
                                              Icons.account_balance_wallet,
                                              color: Colors.green,
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              'Saldo Un1ty',
                                              style: TextStyle(
                                                  color: Colors.green),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                        child: FutureBuilder<Wallet>(
                                      future: _walletService.getSaldo(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(formatRupiah(snapshot
                                                  .data.data[0].saldoAkhir)
                                              .replaceAll("Rp ", "Rp"));
                                        } else if (snapshot.hasError) {
                                          return Text("${snapshot.error}");
                                        }
                                        return Text("Loading ...");
                                      },
                                    )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 90.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Divider(
                            height: 12,
                            color: Colors.grey,
                          ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: RaisedButton(
                            color: Colors.green,
                            onPressed: () {
                              int transactionId = int.parse(widget.koId);
                              String nomorHp =
                                  snapshot.data.data[0].noHp.toString();
                              int idWallet = int.parse(_idWallet);
                              Post post = Post(
                                userId: idWallet,
                                walletId: idWallet,
                                noHp: nomorHp,
                                transactionId: transactionId,
                              );
                              _pulsaService
                                  .createPayPasca(post)
                                  .then((response) async {
                                if (response.statusCode == 200) {
                                  Map blok = jsonDecode(response.body);
                                  userUid = blok['id'].toString();
                                  _localService
                                      .saveIdName(userUid)
                                      .then((bool committed) {
                                    print("INI USERID :" + userUid);
                                  });
                                  PulsaDialog().nPulsaDialog(context);
                                } else if (response.statusCode == 409) {
                                  PulsaDialog().pascaDoneDialog(context);
                                } else if (response.statusCode == 403) {
                                  PulsaDialog().saldoMinDialog(context);
                                } else {
                                  print("INI STATUS CODE: " +
                                      response.statusCode.toString());
                                }
                              });
                            },
                            child: Text(
                              'BAYAR',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Container(
              alignment: Alignment.center,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
