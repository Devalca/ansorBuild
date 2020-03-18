import 'dart:async';
import 'dart:convert';

import 'package:ansor_build/src/model/ansor_model.dart';
import 'package:ansor_build/src/screen/beranda/beranda_screen.dart';
import 'package:ansor_build/src/screen/component/loading.dart';
import 'package:ansor_build/src/service/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:indonesia/indonesia.dart';
import 'package:intl/intl.dart';

class SesPulsaPage extends StatefulWidget {
  final String koId;
  SesPulsaPage(this.koId);

  @override
  _SesPulsaPageState createState() => _SesPulsaPageState();
}

class _SesPulsaPageState extends State<SesPulsaPage> {
  String _id = "";
  Future<PostTrans> futureTrans;
  ApiService _apiService = ApiService();
  final cF = NumberFormat.currency(locale: 'ID');
  @override
  void initState() {
    super.initState();
    _apiService.getNameId().then(updateId);
    futureTrans = fetchTrans();
  }

  Future<PostTrans> fetchTrans() async {
    String baseUrl = "http://192.168.10.11:3000/ppob/detail/pulsa/";
    final response = await http.get(baseUrl + widget.koId);
    print("SATATUS CODENYA: " + response.statusCode.toString());
    if (response.statusCode == 200) {
      print("SATATUS CODENYA: " + response.statusCode.toString());
      return postTransFromJson(response.body);
    } else {
      print("SATATUS CODENYA: " + response.statusCode.toString());
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          leading: Icon(Icons.close),
        ),
        body: FutureBuilder<PostTrans>(
          future: futureTrans,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              int dotUang = snapshot.data.data[0].totalHarga;
              DateTime dateTime = snapshot.data.data[0].periode;
              // var formatterDate = DateFormat('dd MMMM yyyy').format(dateTime);
              // var formatterTime = DateFormat('HH.mm').format(dateTime);
              return SingleChildScrollView(
                              child: Container(
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
                                  child: Text(tanggal(dateTime)),
                                ),
                                Container(
                                  child: Text('via Unity'),
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
                                              child: Text(
                                                  snapshot.data.data[0].provider),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 12.0),
                                              child: Text(snapshot
                                                  .data.data[0].transactionId
                                                  .toString()),
                                            ),
                                            Container(
                                              child: Text(cF.format(dotUang).replaceAll("IDR", "Rp. ")),
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
                                border: Border.all(width: 1, color: Colors.green),
                                borderRadius: BorderRadius.circular(5.0)),
                            child: FlatButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BerandaPage()));
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

            return CircularProgressIndicator();
          },
        ));
  }

  void updateId(String transId) {
    setState(() {
      this._id = transId;
    });
  }
}
