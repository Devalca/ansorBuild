import 'dart:async';

import 'package:ansor_build/src/model/pdam_model.dart';
import 'package:ansor_build/src/model/pulsa_model.dart';
import 'package:ansor_build/src/screen/beranda/landing_screen.dart';
import 'package:ansor_build/src/screen/component/loading.dart';
import 'package:ansor_build/src/service/local_service.dart';
import 'package:ansor_build/src/service/pdam_service.dart';
import 'package:ansor_build/src/service/pulsa_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:indonesia/indonesia.dart';
import 'package:intl/intl.dart';

class SelesaiPage extends StatefulWidget {
  final String koId;
  final String headerUrl;
  SelesaiPage(this.koId, this.headerUrl);

  @override
  _SelesaiPageState createState() => _SelesaiPageState();
}

class _SelesaiPageState extends State<SelesaiPage> {
  Future<DetailTrans> futureTrans;
  final cF = NumberFormat.currency(locale: 'ID');

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
  void initState() {
    super.initState();
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
          leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LandingPage()));
              }),
        ),
        body: FutureBuilder<DetailTrans>(
          future: getDetailTrans(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              int dotUang = snapshot.data.data[0].total;
              DateTime dateLunas = snapshot.data.data[0].periode;
              DateTime datePeriode = snapshot.data.data[0].tglBayar;
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
                                  child:  Text("${tanggal(dateLunas)} ${formatterTime.toString()}"),
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
                                              child: Text('Tanggal Lunas'),
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
                                              child: Text(
                                                  'Air PDAM ' + snapshot.data.data[0].namaWilayah),
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
                                              child: Text(tanggal(datePeriode)
                                                  .toString()),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 12.0),
                                              child: Text(tanggal(dateLunas)
                                                  .toString()),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 12.0),
                                              child: Text(
                                                  snapshot.data.data[0].id.toString()),
                                            ),
                                            Container(
                                             child: Text(rupiah(dotUang).replaceAll("Rp ", "Rp")),
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
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LandingPage()));
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
    // body: FutureBuilder<DetailTrans>(
    //   future: futureTrans,
    //   builder: (context, snapshot) {
    //      if (_detailForDisplay.length == 0) {
    //        print(_detailForDisplay.length);
    //        print(snapshot.data.data[0].namaWilayah);
    //        print(snapshot.data.data.length);
    //       return centerLoading();
    //     } else {
    //     switch (snapshot.connectionState) {
    //       case ConnectionState.none:
    //         return Text("Koneksi Terputus");
    //       case ConnectionState.waiting:
    //         return centerLoading();
    //       default:
    //         if (snapshot.hasData) {
    //           return SingleChildScrollView(
    //             child: Container(
    //               color: Colors.white,
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: <Widget>[_transHeader(), _transFooter()],
    //               ),
    //             ),
    //           );
    //         } else {
    //           return Text("${snapshot.error}");
    //         }
    //     }
    //     }
    //   },
    // ));
  }

  // Widget _transHeader() {
  //   // int dotUang = snapshot.data.data[0].totalHarga;
  //   DateTime datePeriode = _detailForDisplay[0].periode;
  //   DateTime dateLunas = _detailForDisplay[0].tglBayar;
  //   var formatterTime = DateFormat('HH.mm').format(dateLunas);
  //   return Column(
  //     children: <Widget>[
  //       Container(
  //         child: Column(
  //           children: <Widget>[
  //             Container(
  //               margin: EdgeInsets.only(top: 60.0, bottom: 15.0),
  //               height: 100.0,
  //               width: 100.0,
  //               color: Colors.grey[300],
  //             ),
  //             Container(
  //               margin: EdgeInsets.all(12.0),
  //               child: Text(
  //                 'Transaksi Berhasil',
  //                 style: TextStyle(fontSize: 20.0, color: Colors.green),
  //               ),
  //             ),
  //             Container(
  //               child: Text("-"),
  //             ),
  //             Container(
  //               child: Text('via Un1ty'),
  //             ),
  //           ],
  //         ),
  //       ),
  //       Container(
  //         padding: EdgeInsets.symmetric(horizontal: 16.0),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: <Widget>[
  //             Container(
  //               margin: EdgeInsets.only(top: 70.0),
  //               child: Text('Detail'),
  //             ),
  //             Container(
  //               margin: EdgeInsets.symmetric(vertical: 12.0),
  //               padding: const EdgeInsets.all(16.0),
  //               decoration: BoxDecoration(
  //                 border: Border.all(width: 1.0, color: Colors.grey[200]),
  //               ),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: <Widget>[
  //                   Container(
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: <Widget>[
  //                         Container(
  //                           margin: EdgeInsets.only(bottom: 12.0),
  //                           child: Text('Jenis Layanan'),
  //                         ),
  //                         Container(
  //                           margin: EdgeInsets.only(bottom: 12.0),
  //                           child: Text('Nama Pelanggan'),
  //                         ),
  //                         Container(
  //                           margin: EdgeInsets.only(bottom: 12.0),
  //                           child: Text("No Meter/ID Pelanggan"),
  //                         ),
  //                         Container(
  //                           margin: EdgeInsets.only(bottom: 12.0),
  //                           child: Text('Periode'),
  //                         ),
  //                         Container(
  //                           margin: EdgeInsets.only(bottom: 12.0),
  //                           child: Text('Tanggal Lunas'),
  //                         ),
  //                         Container(
  //                           margin: EdgeInsets.only(bottom: 12.0),
  //                           child: Text('Nomor Transaksi'),
  //                         ),
  //                         Container(
  //                           child: Text('Total Tagihan'),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   Container(
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.end,
  //                       children: <Widget>[
  //                         Container(
  //                           margin: EdgeInsets.only(bottom: 12.0),
  //                           child: Text("Tidak Ada Dalam Database"),
  //                         ),
  //                         Container(
  //                           margin: EdgeInsets.only(bottom: 12.0),
  //                           child: Text(_detailForDisplay[0].namaPelanggan),
  //                         ),
  //                         Container(
  //                           margin: EdgeInsets.only(bottom: 12.0),
  //                           child: Text(_detailForDisplay[0].noPelanggan),
  //                         ),
  //                         Container(
  //                           margin: EdgeInsets.only(bottom: 12.0),
  //                           child: Text(tanggal(datePeriode).toString()),
  //                         ),
  //                         Container(
  //                           margin: EdgeInsets.only(bottom: 12.0),
  //                           child: Text(tanggal(dateLunas).toString()),
  //                         ),
  //                         Container(
  //                           margin: EdgeInsets.only(bottom: 12.0),
  //                           child: Text("Tidak Ada Dalam Database"),
  //                         ),
  //                         Container(
  //                           margin: EdgeInsets.only(bottom: 12.0),
  //                           child: Text(_detailForDisplay[0].total.toString()),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget _transFooter() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.stretch,
  //     children: <Widget>[
  //       Divider(
  //         color: Colors.black,
  //       ),
  //       Container(
  //         height: 50.0,
  //         margin: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),
  //         decoration: BoxDecoration(
  //             border: Border.all(width: 1, color: Colors.green),
  //             borderRadius: BorderRadius.circular(5.0)),
  //         child: FlatButton(
  //           onPressed: () {
  //             Navigator.pushReplacement(context,
  //                 MaterialPageRoute(builder: (context) => LandingPage()));
  //           },
  //           child: Text(
  //             'Selesai'.toUpperCase(),
  //             style: TextStyle(color: Colors.green, fontSize: 20.0),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
