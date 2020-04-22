import 'package:ansor_build/src/model/bpjs_model.dart';
import 'package:ansor_build/src/model/wallet_model.dart';
import 'package:ansor_build/src/screen/ppob/bpjs/bpjs_main.dart';
import 'package:ansor_build/src/screen/ppob/bpjs/pembayaran_berhasil.dart';
import 'package:ansor_build/src/service/bpjs_services.dart';
import 'package:ansor_build/src/service/local_service.dart';
import 'package:ansor_build/src/service/wallet_service.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:indonesia/indonesia.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BpjsPembayaran extends StatefulWidget {
  final String jenis;
  final String url, urlkerja;
  final int index;
  BpjsPembayaran({this.jenis, this.url, this.urlkerja, this.index});

  @override
  _BpjsPembayaranState createState() => _BpjsPembayaranState();
}

class _BpjsPembayaranState extends State<BpjsPembayaran> {
  WalletService _walletService = WalletService();
  BpjsServices _bpjsServices = BpjsServices();
  LocalService _localServices = LocalService();

  bool _isLoading = false;

  String _url = "";
  String _urlkerja = "";
  String url = "";
  String noVa2 = "";
  String periode2 = "";
  String periodeByr2 = "";
  String noKtp2 = "";
  int totalSehat2 = 0;
  int totalKerja2 = 0;
  int saldo = 0;

  @override
  void initState() {
    super.initState();

    _url = widget.url;
    _urlkerja = widget.urlkerja;
  }

  Future<DetailKesehatan> fetchPembayaran() async {
    final response = await http.get('http://103.9.125.18:3000' + _url);

    if (response.statusCode == 200) {
      return detailKesehatanFromJson(response.body);
    } else {
      throw Exception('Failed to load Detail BPJS Kesehatan');
    }
  }

  Future<DetailKetenagakerjaan> fetchKetenagakerjaan() async {
    final response = await http.get('http://103.9.125.18:3000' + _urlkerja);

    if (response.statusCode == 200) {
      return detailKetenagakerjaanFromJson(response.body);
    } else {
      throw Exception('Failed to load Detail BPJS Ketenagakerjaan');
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget middleSection = Expanded(
      child: new Container(
          child: SingleChildScrollView(
        padding: new EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            widget.jenis == "kesehatan"
                ? FutureBuilder<DetailKesehatan>(
                    future: fetchPembayaran(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data.data.isNotEmpty) {
                        DateTime periode = snapshot.data.data[0].periode;

                        noVa2 = snapshot.data.data[0].noVa.toString();
                        periode2 = snapshot.data.data[0].periode
                            .toString()
                            .substring(0, 10);
                        totalSehat2 = snapshot.data.data[0].total;

                        return (Container(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 85.0,
                              child: Row(children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(right: 12.0),
                                  height: 90.0,
                                  width: 50.0,
                                  child: Image.asset("lib/src/assets/BPJS.png"),
                                ),
                                Container(
                                  child: Text("BPJS Kesehatan" +
                                      "\n" +
                                      "Nomor " +
                                      snapshot.data.data[0].noVa.toString() +
                                      "\n" +
                                      snapshot.data.data[0].namaPelanggan),
                                ),
                              ]),
                            ),
                            Container(height: 15),
                            Text("Detail Pembayaran",
                                textAlign: TextAlign.start,
                                style: new TextStyle(fontSize: 14.0)),
                            Container(height: 15),
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                width: double.infinity,
                                height: 150.0,
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    border: Border.all(
                                        color: Colors.grey[300], width: 1)),
                                child: Column(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            child: Text("Periode"),
                                          ),
                                          Container(
                                            child: Text(
                                                tanggal(periode).substring(2)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            child: Text("Jumlah Keluarga"),
                                          ),
                                          Container(
                                            child: Text(snapshot
                                                .data.data[0].jumlahKeluarga
                                                .toString()),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            child: Text("Total Tagihan"),
                                          ),
                                          Container(
                                            child: Text(
                                                NumberFormat.simpleCurrency(
                                                        locale: 'id',
                                                        decimalDigits: 0)
                                                    .format(snapshot.data
                                                        .data[0].totalTagihan)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            child: Text("Biaya Pelayanan"),
                                          ),
                                          Container(
                                            child: Text(
                                                NumberFormat.simpleCurrency(
                                                        locale: 'id',
                                                        decimalDigits: 0)
                                                    .format(snapshot.data
                                                        .data[0].adminFee)),
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
                                            child: Text("Total"),
                                          ),
                                          Container(
                                            child: Text(
                                                NumberFormat.simpleCurrency(
                                                        locale: 'id',
                                                        decimalDigits: 0)
                                                    .format(snapshot
                                                        .data.data[0].total)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                            Container(height: 15),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
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
                                                      .format(snapshot.data
                                                          .data[0].saldoAkhir));
                                            } else if (snapshot.hasError) {
                                              return Text("${snapshot.error}");
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
                            Container(height: 15),
                          ],
                        )));
                      } else if (snapshot.hasError) {
                        return Center(
                            child: Text(
                                "Gagal Memuat Detail Pembayaran Kesehatan"));
                        // return Text("${snapshot.error}");
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  )
                : FutureBuilder<DetailKetenagakerjaan>(
                    future: fetchKetenagakerjaan(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data.data.isNotEmpty) {
                        periodeByr2 =
                            snapshot.data.data[0].periodeByr.toString();
                        noKtp2 = snapshot.data.data[0].noKtp;
                        totalKerja2 = snapshot.data.data[0].total;

                        return (Container(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 85.0,
                              child: Row(children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(right: 12.0),
                                  height: 90.0,
                                  width: 50.0,
                                  child: Image.asset("lib/src/assets/BPJS.png"),
                                ),
                                Container(
                                  child: Text("BPJS Ketenagakerjaan" +
                                      "\n" +
                                      "Nomor " +
                                      snapshot.data.data[0].noKtp.toString() +
                                      "\n" +
                                      snapshot.data.data[0].namaPemilik +
                                      " - " +
                                      snapshot.data.data[0].cabang),
                                ),
                              ]),
                            ),
                            Container(height: 15),
                            Text("Detail Pembayaran",
                                textAlign: TextAlign.start,
                                style: new TextStyle(fontSize: 14.0)),
                            Container(height: 15),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              width: double.infinity,
                              height: 240.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  border: Border.all(
                                      color: Colors.grey[300], width: 1)),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Text("Periode"),
                                        ),
                                        Container(
                                          child: Text(snapshot
                                                  .data.data[0].periodeByr
                                                  .toString() +
                                              " Bulan"),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child:
                                              Text("Jaminan Kecelakaan Kerja"),
                                        ),
                                        Container(
                                          child: Text(
                                              NumberFormat.simpleCurrency(
                                                      locale: 'id',
                                                      decimalDigits: 0)
                                                  .format(snapshot
                                                      .data.data[0].jkk)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Text("Jaminan Kematian"),
                                        ),
                                        Container(
                                          child: Text(
                                              NumberFormat.simpleCurrency(
                                                      locale: 'id',
                                                      decimalDigits: 0)
                                                  .format(snapshot
                                                      .data.data[0].jkm)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Text("Jaminan Hari Tua"),
                                        ),
                                        Container(
                                          child: Text(
                                              NumberFormat.simpleCurrency(
                                                      locale: 'id',
                                                      decimalDigits: 0)
                                                  .format(snapshot
                                                      .data.data[0].jht)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Text("Jaminan Pensiun"),
                                        ),
                                        Container(
                                          child: Text(
                                              NumberFormat.simpleCurrency(
                                                      locale: 'id',
                                                      decimalDigits: 0)
                                                  .format(snapshot
                                                      .data.data[0].jp)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Text("Total Tagihan"),
                                        ),
                                        Container(
                                          child: Text(
                                              NumberFormat.simpleCurrency(
                                                      locale: 'id',
                                                      decimalDigits: 0)
                                                  .format(snapshot.data.data[0]
                                                      .totalTagihan)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Text("Biaya Pelayanan"),
                                        ),
                                        Container(
                                          child: Text(
                                              NumberFormat.simpleCurrency(
                                                      locale: 'id',
                                                      decimalDigits: 0)
                                                  .format(snapshot
                                                      .data.data[0].adminFee)),
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
                                          child: Text("Total"),
                                        ),
                                        Container(
                                          child: Text(
                                              NumberFormat.simpleCurrency(
                                                      locale: 'id',
                                                      decimalDigits: 0)
                                                  .format(snapshot
                                                      .data.data[0].total)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(height: 15),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
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
                                                      .format(snapshot.data
                                                          .data[0].saldoAkhir));
                                            } else if (snapshot.hasError) {
                                              return Text("${snapshot.error}");
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
                            Container(height: 15),
                          ],
                        )));
                      } else if (snapshot.hasError) {
                        return Center(
                            child: Text(
                                "Gagal Memuat Detail Pembayaran Ketenagakerjaan"));
                        // return Text("${snapshot.error}");
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  )
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

            if (widget.jenis == "kesehatan") {
              if (totalSehat2 > saldo) {
                setState(() => _isLoading = false);
                return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Transaksi Gagal",
                            style: TextStyle(color: Colors.green)),
                        content: Text(
                            "Saldo Anda Tidak Cukup. Silahkan Melakukan Pengisian Saldo."),
                        actions: <Widget>[
                          MaterialButton(
                            elevation: 5.0,
                            child: Text("OK",
                                style: TextStyle(color: Colors.green)),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      );
                    });
              } else {
                String transactionId = widget.url.substring(21);
                String noVa = noVa2;
                String periode = periode2;

                SharedPreferences prefs = await SharedPreferences.getInstance();
                String walletId = prefs.getString("walletId");
                String userId = prefs.getString("userId");

                print("transactionId " + transactionId);
                print("noVa " + noVa);
                print("periode " + periode);
                print("userId " + userId);
                print("walletId " + walletId);

                PostPembayaran pembayaran = PostPembayaran(
                    userId: userId,
                    walletId: walletId,
                    transactionId: transactionId,
                    noVa: noVa,
                    periode: periode);

                _bpjsServices.postPembayaran(pembayaran).then((response) async {
                  if (response.statusCode == 200) {
                    print("berhasil body: " + response.body);
                    print(response.statusCode);

                    Map data = jsonDecode(response.body);
                    transactionId = data['transactionId'].toString();
                    print("transactionId: " + transactionId);

                    url = '/ppob/bpjs/detail/kesehatan/' + transactionId;
                    print("url: " + url);

                    _localServices.saveUrl(url).then((bool committed) {
                      print(url);
                    });

                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (__) =>
                                new PembayaranBerhasil(jenis: widget.jenis)));
                    setState(() => _isLoading = false);
                  } else if (response.statusCode == 302) {
                    print("berhasil body: " + response.body);
                    print(response.statusCode);

                    url = response.headers['location'];
                    print("url: " + url);

                    _localServices.saveUrl(url).then((bool committed) {
                      print(url);
                    });

                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (__) =>
                                new PembayaranBerhasil(jenis: widget.jenis)));
                    setState(() => _isLoading = false);
                  } else {
                    print("error: " + response.body);
                    print(response.statusCode);
                  }
                });
              }
            } else {
              if (totalKerja2 > saldo) {
                setState(() => _isLoading = false);
                return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Transaksi Gagal",
                            style: TextStyle(color: Colors.green)),
                        content: Text(
                            "Saldo Anda Tidak Cukup. Silahkan Melakukan Pengisian Saldo."),
                        actions: <Widget>[
                          MaterialButton(
                            elevation: 5.0,
                            child: Text("OK",
                                style: TextStyle(color: Colors.green)),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      );
                    });
              } else {
                String transactionId = widget.urlkerja.substring(27);
                String periodeByr = periodeByr2;
                String noKtp = noKtp2;

                SharedPreferences prefs = await SharedPreferences.getInstance();
                String walletId = prefs.getString("walletId");
                String userId = prefs.getString("userId");

                print("periodeByr " + periodeByr);
                print("noKtp " + noKtp);
                print("userId " + userId);
                print("walletId " + walletId);
                print("transactionId " + transactionId);

                PostBayarKerja bayarKerja = PostBayarKerja(
                  periodeByr: periodeByr,
                  noKtp: noKtp,
                  userId: userId,
                  walletId: walletId,
                  transactionId: transactionId,
                );

                _bpjsServices.postBayarKerja(bayarKerja).then((response) async {
                  if (response.statusCode == 200) {
                    print("berhasil body: " + response.body);
                    print(response.statusCode);

                    Map data = jsonDecode(response.body);
                    transactionId = data['transactionId'].toString();
                    print("transactionId: " + transactionId);

                    url = '/ppob/bpjs/detail/kesehatan/' + transactionId;
                    print("url: " + url);

                    _localServices.saveUrl(url).then((bool committed) {
                      print(url);
                    });

                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (__) =>
                                new PembayaranBerhasil(jenis: widget.jenis)));
                    setState(() => _isLoading = false);
                  } else if (response.statusCode == 302) {
                    print("berhasil body: " + response.body);
                    print(response.statusCode);

                    url = response.headers['location'];
                    print("url: " + url);

                    _localServices.saveUrl(url).then((bool committed) {
                      print(url);
                    });

                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (__) =>
                                new PembayaranBerhasil(jenis: widget.jenis)));
                    setState(() => _isLoading = false);
                  } else {
                    print("error: " + response.body);
                    print(response.statusCode);
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
                        builder: (__) => new Bpjs(
                              index: widget.index,
                            )));
              }),
          backgroundColor: Colors.white,
          title: Text(
            'Pembayaran',
            style: TextStyle(color: Colors.black),
          )),
      body: Padding(
        padding: new EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
        child: body,
      ),
    );
  }
}
