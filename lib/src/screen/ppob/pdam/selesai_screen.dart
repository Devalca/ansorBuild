import 'dart:async';

import 'package:ansor_build/src/model/pdam_model.dart';
import 'package:ansor_build/src/routes/routes.dart';
import 'package:ansor_build/src/screen/component/formatIndo.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SesPdamPage extends StatefulWidget {
  final String headerUrl;
  SesPdamPage(this.headerUrl);

  @override
  _SesPdamPageState createState() => _SesPdamPageState();
}

class _SesPdamPageState extends State<SesPdamPage> {
  Future<DetailTrans> futureTrans;

  Future<DetailTrans> getDetailTrans() async {
    // String baseUrl = "https://afternoon-waters-38775.herokuapp.com";
    String baseUrl = "http://103.9.125.18:3000";
    final response = await http.get(baseUrl + widget.headerUrl);
    if (response.statusCode == 200) {
      return detailTransFromJson(response.body);
    } else {
      print("SATATUS Response: " + response.toString());
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          leading: Container(
            child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  _toLanding();
                }),
          ),
        ),
        body: FutureBuilder<DetailTrans>(
          future: getDetailTrans(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              int dotUang = snapshot.data.data[0].total;
              DateTime datePeriode = snapshot.data.data[0].periode;
              DateTime dateLunas = snapshot.data.data[0].tglBayar;
              var formatterTime = DateFormat('HH:mm').format(dateLunas);
              return SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin:
                                      EdgeInsets.only(top: 60.0, bottom: 15.0),
                                  height: 100.0,
                                  width: 100.0,
                                  color: Colors.grey[300],
                                ),
                                Container(
                                  margin: EdgeInsets.all(12.0),
                                  child: Text(
                                    'Transaksi Berhasil',
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.green),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                      "${formatTanggal(dateLunas)}, ${formatterTime.toString()}"),
                                ),
                                Container(
                                  child: Text('via Un1ty'),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 70.0),
                                  child: Text('Detail'),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 12.0),
                                  padding: const EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1.0, color: Colors.grey[200]),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 12.0),
                                              child: Text('Jenis Layanan'),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 12.0),
                                              child: Text('Nama Pelanggan'),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 12.0),
                                              child:
                                                  Text("No Meter/ID Pelanggan"),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 12.0),
                                              child: Text('Periode'),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 12.0),
                                              child: Text('Pelunasan'),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 12.0),
                                              child: Text('Nomor Transaksi'),
                                            ),
                                            Container(
                                              child: Text('Total Tagihan'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 12.0),
                                              child: Text('PDAM ' +
                                                  snapshot.data.data[0]
                                                      .namaWilayah),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 12.0),
                                              child: Text(snapshot
                                                  .data.data[0].namaPelanggan),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 12.0),
                                              child: Text(snapshot
                                                  .data.data[0].noPelanggan),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 12.0),
                                              child: Text(formatBlnTahun(datePeriode)
                                                  .toString()),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 12.0),
                                              child: Text(formatTanggal(dateLunas)
                                                  .toString()),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 12.0),
                                              child: Text(snapshot
                                                  .data.data[0].noTransaksi
                                                  .toString()),
                                            ),
                                            Container(
                                              child: Text(formatRupiah(dotUang)
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
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Divider(
                            color: Colors.black,
                          ),
                          Container(
                            height: 50.0,
                            margin: EdgeInsets.only(
                                left: 16.0, right: 16.0, bottom: 20.0),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.green),
                                borderRadius: BorderRadius.circular(5.0)),
                            child: FlatButton(
                              onPressed: () {
                                _toLanding();
                              },
                              child: Text(
                                'Selesai'.toUpperCase(),
                                style: TextStyle(
                                    color: Colors.green, fontSize: 20.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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
        ));
  }

  _toLanding() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.LandingScreen, (Route<dynamic> route) => false);
  }
}