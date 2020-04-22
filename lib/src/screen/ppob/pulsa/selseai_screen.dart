import 'dart:async';

import 'package:ansor_build/src/model/pulsa_model.dart';
import 'package:ansor_build/src/routes/routes.dart';
import 'package:ansor_build/src/screen/component/formatIndo.dart';
import 'package:ansor_build/src/service/local_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SesPulsaPage extends StatefulWidget {
  final String koId;
  SesPulsaPage(this.koId);

  @override
  _SesPulsaPageState createState() => _SesPulsaPageState();
}

class _SesPulsaPageState extends State<SesPulsaPage> {
  Future<PostTrans> futureTrans;

  @override
  void initState() {
    super.initState();
    futureTrans = fetchTrans();
  }

  Future<PostTrans> fetchTrans() async {
    // String baseUrl = "http://192.168.10.11:3000/ppob/detail/pulsa/";
    // String baseUrl = "https://afternoon-waters-38775.herokuapp.com/ppob/detail/pulsa/";
    String baseUrl = "http://103.9.125.18:3000/ppob/detail/pulsa/";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String transIdName = prefs.getString("transIdName");
 
    final response = await http.get(baseUrl+transIdName);
    if (response.statusCode == 200) {
      return postTransFromJson(response.body);
    } else {
      print("SATATUS CODENYA: " + response.statusCode.toString());
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
        body: FutureBuilder<PostTrans>(
          future: futureTrans,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              int dotUang = snapshot.data.data[0].totalHarga;
              DateTime dateTime = snapshot.data.data[0].periode;
              // var formatterDate = DateFormat('dd MMMM yyyy').format(dateTime);
              var formatterTime = DateFormat('HH:mm').format(dateTime);
                return Container(
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
                                      EdgeInsets.only(top: 30.0, bottom: 15.0),
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
                                      "${formatTanggal(dateTime)}, ${formatterTime.toString()}"),
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
                                            snapshot.data.data[0].status == "Pascabayar" ? 
                                              Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 12.0),
                                              child: Text('Periode'),
                                            ) : Container(),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 12.0),
                                              child: Text('Jenis Layanan'),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 12.0),
                                              child: Text('Nomor Handphone'),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 12.0),
                                              child: Text('Provider'),
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
                                            snapshot.data.data[0].status == "Pascabayar" ? 
                                              Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 12.0),
                                              child: Text(formatBlnTahun(dateTime)
                                                  .toString())
                                            ) : Container(),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 12.0),
                                              child: Text(
                                                  snapshot.data.data[0].status),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 12.0),
                                              child: Text(
                                                  snapshot.data.data[0].noHp),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 12.0),
                                              child: Text(snapshot
                                                  .data.data[0].provider),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 12.0),
                                              child: Text(snapshot
                                                  .data.data[0].transactionId
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
                            height: 12,
                            color: Colors.grey,
                          ),
                          Container(
                             height: 40.0,
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