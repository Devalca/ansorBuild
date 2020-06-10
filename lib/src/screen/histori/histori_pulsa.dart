import 'dart:async';

import 'package:ansor_build/src/model/pdam_model.dart';
import 'package:ansor_build/src/model/pulsa_model.dart';
import 'package:ansor_build/src/routes/routes.dart';
import 'package:ansor_build/src/screen/component/formatIndo.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoriPulsaPage extends StatefulWidget {
  final String headerUrl;
  HistoriPulsaPage(this.headerUrl);

  @override
  _HistoriPulsaPageState createState() => _HistoriPulsaPageState();
}

class _HistoriPulsaPageState extends State<HistoriPulsaPage> {
  Future<PostTrans> fetchTrans() async {
    final response = await http.get(widget.headerUrl);
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
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context, true);
                }),
          ),
        ),
        body: FutureBuilder<PostTrans>(
            future: fetchTrans(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                int dotUang = snapshot.data.data[0].totalHarga;
                DateTime dateTime = snapshot.data.data[0].periode;
                var formatterTime = DateFormat('HH:mm').format(dateTime);
                return Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin:
                                    EdgeInsets.only(top: 20.0, bottom: 15.0),
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
                                margin: EdgeInsets.only(top: 35.0),
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
                                          snapshot.data.data[0].status ==
                                                  "Pascabayar"
                                              ? Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 12.0),
                                                  child: Text('Periode'),
                                                )
                                              : Container(),
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
                                          snapshot.data.data[0].status ==
                                                  "Pascabayar"
                                              ? Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 12.0),
                                                  child: Text(
                                                      formatBlnTahun(dateTime)
                                                          .toString()))
                                              : Container(),
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
                                            child: Text(snapshot.data.data[0].id
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
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Stack(
                        children: <Widget>[
                          Divider(
                            height: 12,
                            color: Colors.grey,
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: 5.0, bottom: 15.0, top: 15.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(flex: 1, child: Icon(Icons.message)),
                                Expanded(
                                    flex: 8,
                                    child: Container(
                                        padding: EdgeInsets.only(bottom: 5.0),
                                        child: Text("Butuh Bantuan ?"))),
                                Expanded(
                                    flex: 1,
                                    child: Icon(Icons.arrow_forward_ios)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              }
              return Container(
                alignment: Alignment.center,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }));
  }

  _toLanding() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.LandingScreen, (Route<dynamic> route) => false);
  }
}
