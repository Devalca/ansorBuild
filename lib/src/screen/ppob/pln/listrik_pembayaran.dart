import 'package:ansor_build/src/screen/ppob/pln/listrik.dart';
import 'package:ansor_build/src/service/wallet_service.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:indonesia/indonesia.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:ansor_build/src/screen/ppob/pln/pembayaran_berhasil.dart';
import 'package:ansor_build/src/screen/ppob/pln/pembayaran_gagal.dart';
import 'package:ansor_build/src/model/pln_model.dart';
import 'package:ansor_build/src/model/wallet_model.dart';
import 'package:ansor_build/src/service/pln_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListrikPembayaran extends StatefulWidget {
  final String status;
  final int index;
  ListrikPembayaran({this.status, this.index});

  @override
  _ListrikPembayaranState createState() => _ListrikPembayaranState();
}

class _ListrikPembayaranState extends State<ListrikPembayaran> {
  bool _isLoading = false;

  PlnServices _plnServices = PlnServices();
  WalletService _walletService = WalletService();

  String _transactionId = "";
  String url = "";
  String noMeter2 = "";
  int total2 = 0;
  int saldo = 0;

  int nominal2 = 0;

  Future<Album> futureAlbum;

  TextEditingController _namaController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _plnServices.getTransactionId().then(updateId);
  }

  void updateId(String transactionId) {
    setState(() {
      this._transactionId = transactionId;
    });
  }

  Future<Album> fetchAlbum() async {
    final response =
        await http.get('http://103.9.125.18:3000' + _transactionId);

    if (response.statusCode == 200) {
      return albumFromJson(response.body);
    } else {
      throw Exception('Failed to load Detail Pln');
    }
  }

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
                FutureBuilder<Album>(
                  future: fetchAlbum(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      DateTime periode = snapshot.data.createdAt;

                      noMeter2 = snapshot.data.no_meter;
                      nominal2 = snapshot.data.nominal;
                      total2 = snapshot.data.total;

                      return (Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 70.0,
                                child: Row(children: <Widget>[
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 12.0),
                                    child: Image.asset(
                                        "lib/src/assets/LISTRIK.png",
                                        scale: 0.9),
                                  ),
                                  Container(
                                    child: Text("Token Listrik PLN\n" +
                                        "Nomor " +
                                        snapshot.data.no_meter +
                                        "\n" +
                                        snapshot.data.nama_pelanggan +
                                        " - " +
                                        snapshot.data.tarif +
                                        '/' +
                                        snapshot.data.daya),
                                  ),
                                ]),
                              ),
                              Container(height: 15),
                              Text("Detail Pembayaran",
                                  textAlign: TextAlign.start,
                                  style: new TextStyle(fontSize: 14.0)),
                              Container(height: 15),
                              widget.status == "prabayar"
                                  ? Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      width: double.infinity,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          border: Border.all(
                                              color: Colors.grey[300],
                                              width: 1)),
                                      child: Column(
                                        children: <Widget>[
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                  child: Text("Total Harga"),
                                                ),
                                                Container(
                                                  child: Text(NumberFormat
                                                          .simpleCurrency(
                                                              locale: 'id',
                                                              decimalDigits: 0)
                                                      .format(snapshot
                                                          .data.nominal)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                  child:
                                                      Text("Biaya Pelayanan"),
                                                ),
                                                Container(
                                                  child: Text(NumberFormat
                                                          .simpleCurrency(
                                                              locale: 'id',
                                                              decimalDigits: 0)
                                                      .format(1500)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Divider(
                                              height: 12,
                                              color: Colors.black87),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                  child: Text("Total"),
                                                ),
                                                Container(
                                                  child: Text(NumberFormat
                                                          .simpleCurrency(
                                                              locale: 'id',
                                                              decimalDigits: 0)
                                                      .format(
                                                          snapshot.data.total)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      width: double.infinity,
                                      height: 140.0,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          border: Border.all(
                                              color: Colors.grey[300],
                                              width: 1)),
                                      child: Column(
                                        children: <Widget>[
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                  child: Text("Periode"),
                                                ),
                                                Container(
                                                  child: Text(tanggal(periode)
                                                      .substring(2)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                  child: Text("Total Harga"),
                                                ),
                                                Container(
                                                  child: Text(NumberFormat
                                                          .simpleCurrency(
                                                              locale: 'id',
                                                              decimalDigits: 0)
                                                      .format(snapshot
                                                          .data.nominal)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                  child:
                                                      Text("Biaya Pelayanan"),
                                                ),
                                                Container(
                                                  child: Text(NumberFormat
                                                          .simpleCurrency(
                                                              locale: 'id',
                                                              decimalDigits: 0)
                                                      .format(1500)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Divider(
                                              height: 12,
                                              color: Colors.black87),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                  child: Text("Total"),
                                                ),
                                                Container(
                                                  child: Text(NumberFormat
                                                          .simpleCurrency(
                                                              locale: 'id',
                                                              decimalDigits: 0)
                                                      .format(
                                                          snapshot.data.total)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                              Container(height: 15),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                width: double.infinity,
                                height: 80.0,
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    shape: BoxShape.rectangle,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    border: Border.all(
                                        color: Colors.grey[300], width: 1)),
                                child: Column(
                                  children: <Widget>[
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            child: Text("Un1ty"),
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
                                    Divider(height: 12, color: Colors.black87),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: 10,
                                            child: Icon(
                                              Icons.account_balance_wallet,
                                              color: Colors.green,
                                              size: 24.0,
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                right: 95.0),
                                            child: Text("Saldo Un1ty",
                                                style: new TextStyle(
                                                    color: Colors.green)),
                                          ),
                                          Container(
                                              child: FutureBuilder<Wallet>(
                                            future: _walletService.getSaldo(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                saldo = snapshot
                                                    .data.data[0].saldoAkhir;
                                                return Text(
                                                    NumberFormat.simpleCurrency(
                                                            locale: 'id',
                                                            decimalDigits: 0)
                                                        .format(snapshot
                                                            .data
                                                            .data[0]
                                                            .saldoAkhir));
                                              } else if (snapshot.hasError) {
                                                return Text(
                                                    "${snapshot.error}");
                                              }
                                              return CircularProgressIndicator();
                                            },
                                          )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Container(height: 160),
                              // Container(
                              //   alignment: Alignment.bottomCenter,
                              //   child: Align(
                              //     child: SizedBox(
                              //       width: double.infinity,
                              //       height: 35,
                              //       child: RaisedButton(
                              //         child: Text('BAYAR',
                              //             style: TextStyle(
                              //                 color: Colors.white)),
                              //         color: Colors.green,
                              //         onPressed: () {
                              //           setState(() => _isLoading = true);
                              //           String id = _transactionId;
                              //           String transactionId =
                              //               id.substring(10);
                              //           String noMeter =
                              //               snapshot.data.no_meter;
                              //           int nominal =
                              //               snapshot.data.nominal;

                              //           print("transactionId: " +
                              //               transactionId);
                              //           print("noMeter: " + noMeter);

                              //           PostPascaTransaction
                              //               pascaTransaction =
                              //               PostPascaTransaction(
                              //                   noMeter: noMeter,
                              //                   transactionId:
                              //                       transactionId,
                              //                   userId: 1,
                              //                   walletId: 1);

                              //           PostPraTransaction
                              //               praTransaction =
                              //               PostPraTransaction(
                              //                   noMeter: noMeter,
                              //                   nominal: nominal,
                              //                   transactionId:
                              //                       transactionId,
                              //                   userId: 1,
                              //                   walletId: 1);

                              //           if (widget.status ==
                              //               "pascabayar") {
                              //             _plnServices
                              //                 .postPascaTransaction(
                              //                     pascaTransaction)
                              //                 .then((response) async {
                              //               print(response.statusCode);
                              //               if (response.statusCode ==
                              //                   302) {
                              //                 print('Berhasil');
                              //                 url = response
                              //                     .headers['location'];
                              //                 print("url: " + url);

                              //                 _plnServices
                              //                     .saveTransactionId(url)
                              //                     .then((bool committed) {
                              //                   print(url);
                              //                 });

                              //                 Navigator.push(
                              //                     context,
                              //                     new MaterialPageRoute(
                              //                         builder: (__) =>
                              //                             new PembayaranBerhasil(
                              //                                 status: widget
                              //                                     .status)));
                              //                 setState(() =>
                              //                     _isLoading = false);
                              //               } else if (response
                              //                       .statusCode ==
                              //                   200) {
                              //                 print('Berhasil');

                              //                 Map data = jsonDecode(
                              //                     response.body);
                              //                 id = data['id'].toString();
                              //                 url = '/ppob/detail/pln/' +
                              //                     id;
                              //                 print("url" + url);

                              //                 _plnServices
                              //                     .saveTransactionId(url)
                              //                     .then((bool committed) {
                              //                   print(url);
                              //                 });

                              //                 Navigator.push(
                              //                     context,
                              //                     new MaterialPageRoute(
                              //                         builder: (__) =>
                              //                             new PembayaranBerhasil(
                              //                                 status: widget
                              //                                     .status)));
                              //                 setState(() =>
                              //                     _isLoading = false);
                              //               } else {
                              //                 print("Gagal");
                              //                 print(response.statusCode);

                              //                 Navigator.push(
                              //                     context,
                              //                     new MaterialPageRoute(
                              //                         builder: (__) =>
                              //                             new PembayaranGagal()));
                              //                 setState(() =>
                              //                     _isLoading = false);
                              //               }
                              //             });
                              //           } else {
                              //             _plnServices
                              //                 .postPraTransaction(
                              //                     praTransaction)
                              //                 .then((response) async {
                              //               print(response.statusCode);
                              //               if (response.statusCode ==
                              //                   302) {
                              //                 print('Berhasil');
                              //                 url = response
                              //                     .headers['location'];
                              //                 print("url: " + url);

                              //                 _plnServices
                              //                     .saveTransactionId(url)
                              //                     .then((bool committed) {
                              //                   print(url);
                              //                 });

                              //                 Navigator.push(
                              //                     context,
                              //                     new MaterialPageRoute(
                              //                         builder: (__) =>
                              //                             new PembayaranBerhasil(
                              //                                 status: widget
                              //                                     .status)));
                              //                 setState(() =>
                              //                     _isLoading = false);
                              //               } else if (response
                              //                       .statusCode ==
                              //                   200) {
                              //                 print('Berhasil');

                              //                 Map data = jsonDecode(
                              //                     response.body);
                              //                 id = data['id'].toString();
                              //                 url = '/ppob/detail/pln/' +
                              //                     id;
                              //                 print("url" + url);

                              //                 _plnServices
                              //                     .saveTransactionId(url)
                              //                     .then((bool committed) {
                              //                   print(url);
                              //                 });

                              //                 Navigator.push(
                              //                     context,
                              //                     new MaterialPageRoute(
                              //                         builder: (__) =>
                              //                             new PembayaranBerhasil(
                              //                                 status: widget
                              //                                     .status)));
                              //                 setState(() =>
                              //                     _isLoading = false);
                              //               } else {
                              //                 print("Gagal");
                              //                 print(response.statusCode);

                              //                 Navigator.push(
                              //                     context,
                              //                     new MaterialPageRoute(
                              //                         builder: (__) =>
                              //                             new PembayaranGagal()));
                              //                 setState(() =>
                              //                     _isLoading = false);
                              //               }
                              //             });
                              //           }
                              //         },
                              //       ),
                              //     ),
                              //   ),
                              // )
                            ]),
                      ));
                    } else if (snapshot.hasError) {
                      return Text("Gagal Memuat Detail Pembayaran Listrik");
                    }

                    return Center(child: CircularProgressIndicator());
                  },
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
      SizedBox(
        width: 333,
        height: 35,
        child: RaisedButton(
          child: Text('BAYAR', style: TextStyle(color: Colors.white)),
          color: Colors.green,
          onPressed: () async {
            setState(() => _isLoading = true);
            if (total2 > saldo) {
              setState(() => _isLoading = false);
              return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Transaksi Gagal",
                          style: TextStyle(color: Colors.green)),
                      content: Text(
                          "Saldo Anda tidak cukup. Silahkan melakukan pengisian saldo."),
                      actions: <Widget>[
                        MaterialButton(
                          elevation: 5.0,
                          child:
                              Text("OK", style: TextStyle(color: Colors.green)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  });
            } else {
              String id = _transactionId;
              String transactionId = id.substring(10);
              String noMeter = noMeter2;
              int nominal = nominal2;

              SharedPreferences prefs = await SharedPreferences.getInstance();
              String walletId = prefs.getString("walletId");
              String userId = prefs.getString("userId");

              print("transactionId: " + transactionId);
              print("noMeter: " + noMeter);
              print("walletId: " + walletId);
              print("userId: " + userId);

              PostPascaTransaction pascaTransaction = PostPascaTransaction(
                  noMeter: noMeter,
                  transactionId: transactionId,
                  userId: userId,
                  walletId: walletId);

              PostPraTransaction praTransaction = PostPraTransaction(
                  noMeter: noMeter,
                  nominal: nominal,
                  transactionId: transactionId,
                  userId: userId,
                  walletId: walletId);

              if (widget.status == "pascabayar") {
                _plnServices
                    .postPascaTransaction(pascaTransaction)
                    .then((response) async {
                  print(response.statusCode);
                  if (response.statusCode == 302) {
                    print('Berhasil');
                    url = response.headers['location'];
                    print("url: " + url);

                    _plnServices.saveTransactionId(url).then((bool committed) {
                      print(url);
                    });

                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (__) =>
                                new PembayaranBerhasil(status: widget.status)));
                    setState(() => _isLoading = false);
                  } else if (response.statusCode == 200) {
                    print('Berhasil');

                    Map data = jsonDecode(response.body);
                    id = data['id'].toString();
                    url = '/ppob/detail/pln/' + id;
                    print("url: " + url);

                    _plnServices.saveTransactionId(url).then((bool committed) {
                      print(url);
                    });

                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (__) =>
                                new PembayaranBerhasil(status: widget.status)));
                    setState(() => _isLoading = false);
                  } else {
                    print("Gagal");
                    print(response.statusCode);

                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (__) => new PembayaranGagal()));
                    setState(() => _isLoading = false);
                  }
                });
              } else {
                _plnServices
                    .postPraTransaction(praTransaction)
                    .then((response) async {
                  print(response.statusCode);
                  if (response.statusCode == 302) {
                    print('Berhasil');
                    url = response.headers['location'];
                    print("url: " + url);

                    _plnServices.saveTransactionId(url).then((bool committed) {
                      print(url);
                    });

                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (__) =>
                                new PembayaranBerhasil(status: widget.status)));
                    setState(() => _isLoading = false);
                  } else if (response.statusCode == 200) {
                    print('Berhasil');

                    Map data = jsonDecode(response.body);
                    id = data['id'].toString();
                    url = '/ppob/detail/pln/' + id;
                    print("url: " + url);

                    _plnServices.saveTransactionId(url).then((bool committed) {
                      print(url);
                    });

                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (__) =>
                                new PembayaranBerhasil(status: widget.status)));
                    setState(() => _isLoading = false);
                  } else {
                    print("Gagal");
                    print(response.statusCode);

                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (__) => new PembayaranGagal()));
                    setState(() => _isLoading = false);
                  }
                });
              }
            }
          },
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
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (__) => Listrik(
                              index: widget.index,
                            )));
              }),
          elevation: 0.2,
          backgroundColor: Colors.white,
          title: Text(
            'Pembayaran',
            style: TextStyle(color: Colors.black),
          )),
      body: new Padding(
        padding: new EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
        child: body,
      ),
    );
  }
}
