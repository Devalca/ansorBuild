import 'package:ansor_build/src/model/bpjs_model.dart';
import 'package:ansor_build/src/model/wallet_model.dart';
import 'package:ansor_build/src/screen/ppob/bpjs/pembayaran_berhasil.dart';
import 'package:ansor_build/src/service/api_service.dart';
import 'package:ansor_build/src/service/bpjs_services.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:indonesia/indonesia.dart';
import 'package:intl/intl.dart';

class BpjsPembayaran extends StatefulWidget {
  final String jenis;
  final String url, urlkerja;
  BpjsPembayaran({this.jenis, this.url, this.urlkerja});

  @override
  _BpjsPembayaranState createState() => _BpjsPembayaranState();
}

class _BpjsPembayaranState extends State<BpjsPembayaran> {
  ApiService _apiService = ApiService();
  BpjsServices _bpjsServices = BpjsServices();

  bool _isLoading = false;

  String _url = "";
  String _urlkerja = "";
  String noVa2 = "";
  String periode2 = "";
  String url = "";
  String periodeByr2 = "";
  String noKtp2 = "";

  @override
  void initState() {
    super.initState();

    _url = widget.url;
    _urlkerja = widget.urlkerja;

    // _bpjsServices.getUrl().then(updateUrl);
  }

  // void updateUrl(String updateUrl) {
  //   setState(() {
  //     this._url = updateUrl;
  //   });
  // }

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
    return Scaffold(
        appBar: AppBar(
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
            )),
        bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            child: Padding(
                padding: const EdgeInsets.all(12.0),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: <
                        Widget>[
                  SizedBox(
                    width: 333,
                    height: 35,
                    child: RaisedButton(
                      child:
                          Text('BAYAR', style: TextStyle(color: Colors.white)),
                      color: Colors.green,
                      onPressed: () {
                        setState(() => _isLoading = true);

                        if (widget.jenis == "kesehatan") {
                          String transactionId = widget.url.substring(21);
                          String noVa = noVa2;
                          String periode = periode2;

                          print("transactionId " + transactionId);
                          print("noVa " + noVa);
                          print("periode " + periode);

                          PostPembayaran pembayaran = PostPembayaran(
                              userId: 1,
                              walletId: 1,
                              transactionId: transactionId,
                              noVa: noVa,
                              periode: periode);

                          _bpjsServices
                              .postPembayaran(pembayaran)
                              .then((response) async {
                            if (response.statusCode == 200) {
                              print("berhasil body: " + response.body);
                              print(response.statusCode);

                              Map data = jsonDecode(response.body);
                              transactionId = data['transactionId'].toString();
                              print("transactionId: " + transactionId);

                              url = '/ppob/bpjs/detail/kesehatan/' +
                                  transactionId;
                              print("url: " + url);

                              _bpjsServices.saveUrl(url).then((bool committed) {
                                print(url);
                              });

                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (__) => new PembayaranBerhasil(
                                          jenis: widget.jenis)));
                              setState(() => _isLoading = false);
                            } else if (response.statusCode == 302) {
                              print("berhasil body: " + response.body);
                              print(response.statusCode);

                              url = response.headers['location'];
                              print("url: " + url);

                              _bpjsServices.saveUrl(url).then((bool committed) {
                                print(url);
                              });

                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (__) => new PembayaranBerhasil(
                                          jenis: widget.jenis)));
                              setState(() => _isLoading = false);
                            } else {
                              print("error: " + response.body);
                              print(response.statusCode);
                            }
                          });
                        } else {
                          String transactionId = widget.urlkerja.substring(27);
                          String periodeByr = periodeByr2;
                          String noKtp = noKtp2;

                          print("transactionId " + transactionId);
                          print("periodeByr " + periodeByr);
                          print("noKtp " + noKtp);

                          PostBayarKerja bayarKerja = PostBayarKerja(
                            periodeByr: periodeByr,
                            noKtp: noKtp,
                            userId: 1,
                            walletId: 1,
                            transactionId: transactionId,
                          );

                          _bpjsServices
                              .postBayarKerja(bayarKerja)
                              .then((response) async {
                            if (response.statusCode == 200) {
                              print("berhasil body: " + response.body);
                              print(response.statusCode);

                              Map data = jsonDecode(response.body);
                              transactionId = data['transactionId'].toString();
                              print("transactionId: " + transactionId);

                              url = '/ppob/bpjs/detail/kesehatan/' +
                                  transactionId;
                              print("url: " + url);

                              _bpjsServices.saveUrl(url).then((bool committed) {
                                print(url);
                              });

                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (__) => new PembayaranBerhasil(
                                          jenis: widget.jenis)));
                              setState(() => _isLoading = false);
                            } else if (response.statusCode == 302) {
                              print("berhasil body: " + response.body);
                              print(response.statusCode);

                              url = response.headers['location'];
                              print("url: " + url);

                              _bpjsServices.saveUrl(url).then((bool committed) {
                                print(url);
                              });

                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (__) => new PembayaranBerhasil(
                                          jenis: widget.jenis)));
                              setState(() => _isLoading = false);
                            } else {
                              print("error: " + response.body);
                              print(response.statusCode);
                            }
                          });
                        }
                      },
                    ),
                  )
                ])),
            elevation: 0),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    widget.jenis == "kesehatan"
                        ? FutureBuilder<DetailKesehatan>(
                            future: fetchPembayaran(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData &&
                                  snapshot.data.data.isNotEmpty) {
                                DateTime periode =
                                    snapshot.data.data[0].periode;

                                noVa2 = snapshot.data.data[0].noVa.toString();
                                periode2 = snapshot.data.data[0].periode
                                    .toString()
                                    .substring(0, 10);

                                // if (snapshot.data.data.isNotEmpty) {
                                //   return Text("Tidak ada Data");
                                // } else {
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
                                          child: Image.asset(
                                              "lib/src/assets/BPJS.png"),
                                        ),
                                        Container(
                                          child: Text("BPJS Kesehatan" +
                                              "\n" +
                                              snapshot.data.data[0].noVa
                                                  .toString() +
                                              "\n" +
                                              snapshot
                                                  .data.data[0].namaPelanggan),
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                            border: Border.all(
                                                color: Colors.grey[300],
                                                width: 1)),
                                        child: Column(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 1,
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
                                                        .substring(1)),
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
                                                        Text("Jumlah Keluarga"),
                                                  ),
                                                  Container(
                                                    child: Text(snapshot.data
                                                        .data[0].jumlahKeluarga
                                                        .toString()),
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
                                                        Text("Total Tagihan"),
                                                  ),
                                                  Container(
                                                    child: Text(NumberFormat
                                                            .simpleCurrency(
                                                                locale: 'id',
                                                                decimalDigits:
                                                                    0)
                                                        .format(snapshot.data
                                                            .data[0].total)),
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
                                                                decimalDigits:
                                                                    0)
                                                        .format(0)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Divider(
                                                height: 12,
                                                color: Colors.black),
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
                                                                decimalDigits:
                                                                    0)
                                                        .format(snapshot.data
                                                            .data[0].total)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )),
                                    Container(height: 15),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      width: double.infinity,
                                      height: 80.0,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
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
                                          Divider(
                                              height: 12, color: Colors.black),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                  child: Text("Saldo Un1ty",
                                                      style: new TextStyle(
                                                          color: Colors.green)),
                                                ),
                                                Container(
                                                    child:
                                                        FutureBuilder<Wallet>(
                                                  future:
                                                      _apiService.getSaldo(),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      return Text(NumberFormat
                                                              .simpleCurrency(
                                                                  locale: 'id',
                                                                  decimalDigits:
                                                                      0)
                                                          .format(snapshot
                                                              .data
                                                              .data[0]
                                                              .saldoAkhir));
                                                    } else if (snapshot
                                                        .hasError) {
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
                                    Container(height: 15),
                                  ],
                                )));
                                // }
                              } else if (snapshot.hasError) {
                                // return Center(
                                // child: Text("Gagal Memuat Detail Pembayaran"));
                                return Text("${snapshot.error}");
                              }
                              return Center(child: CircularProgressIndicator());
                            },
                          )
                        : FutureBuilder<DetailKetenagakerjaan>(
                            future: fetchKetenagakerjaan(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData &&
                                  snapshot.data.data.isNotEmpty) {
                                periodeByr2 =
                                    snapshot.data.data[0].periodeByr.toString();
                                noKtp2 = snapshot.data.data[0].noKtp;

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
                                          child: Image.asset(
                                              "lib/src/assets/BPJS.png"),
                                        ),
                                        Container(
                                          child: Text("BPJS Ketenagakerjaan" +
                                              "\n" +
                                              snapshot.data.data[0].noKtp
                                                  .toString() +
                                              "\n" +
                                              snapshot
                                                  .data.data[0].namaPemilik +
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      width: double.infinity,
                                      height: 240.0,
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
                                            flex: 1,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                  child: Text("Periode"),
                                                ),
                                                Container(
                                                  child: Text(snapshot.data
                                                          .data[0].periodeByr
                                                          .toString() +
                                                      " Bulan"),
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
                                                  child: Text(
                                                      "Jaminan Kecelakaan Kerja"),
                                                ),
                                                Container(
                                                  child: Text(NumberFormat
                                                          .simpleCurrency(
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                  child:
                                                      Text("Jaminan Kematian"),
                                                ),
                                                Container(
                                                  child: Text(NumberFormat
                                                          .simpleCurrency(
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                  child:
                                                      Text("Jaminan Hari Tua"),
                                                ),
                                                Container(
                                                  child: Text(NumberFormat
                                                          .simpleCurrency(
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                  child:
                                                      Text("Jaminan Pensiun"),
                                                ),
                                                Container(
                                                  child: Text(NumberFormat
                                                          .simpleCurrency(
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                  child: Text("Total Tagihan"),
                                                ),
                                                Container(
                                                  child: Text(NumberFormat
                                                          .simpleCurrency(
                                                              locale: 'id',
                                                              decimalDigits: 0)
                                                      .format(snapshot
                                                          .data
                                                          .data[0]
                                                          .totalTagihan)),
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
                                              height: 12, color: Colors.black),
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      width: double.infinity,
                                      height: 80.0,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
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
                                          Divider(
                                              height: 12, color: Colors.black),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                  child: Text("Saldo Un1ty",
                                                      style: new TextStyle(
                                                          color: Colors.green)),
                                                ),
                                                Container(
                                                    child:
                                                        FutureBuilder<Wallet>(
                                                  future:
                                                      _apiService.getSaldo(),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      return Text(NumberFormat
                                                              .simpleCurrency(
                                                                  locale: 'id',
                                                                  decimalDigits:
                                                                      0)
                                                          .format(snapshot
                                                              .data
                                                              .data[0]
                                                              .saldoAkhir));
                                                    } else if (snapshot
                                                        .hasError) {
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
                                    Container(height: 15),
                                  ],
                                )));
                              } else if (snapshot.hasError) {
                                return Center(
                                    child:
                                        Text("Gagal Memuat Detail Pembayaran"));
                                // return Text("${snapshot.error}");
                              }
                              return Center(child: CircularProgressIndicator());
                            },
                          )
                  ])),
        ));
  }
}
