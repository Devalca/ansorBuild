import 'dart:async';

import 'package:ansor_build/src/model/ansor_model.dart';
import 'package:ansor_build/src/screen/beranda/beranda_screen.dart';
import 'package:ansor_build/src/service/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class SesPulsaPage extends StatefulWidget {
  @override
  _SesPulsaPageState createState() => _SesPulsaPageState();
}

class _SesPulsaPageState extends State<SesPulsaPage> {
  ApiService _apiService = ApiService();
  String _id = "";

  @override
  void initState() {
    _apiService.getNameId().then(updateId);
    super.initState();
  }

  Future<PostTrans> fetchTrans() async {
    String baseUrl = "http://192.168.10.11:3000/ppob/detail/pulsa/";
    final response = await http.get(baseUrl + _id);
    print(response.body);
    if (response.statusCode == 200) {
      print("ID TRANS : " + _id);
      return postTransFromJson(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Transaksi Sukses'),
        ),
        body: FutureBuilder<PostTrans>(
          future: fetchTrans(),
          builder: (context, snapshot) {
          DateTime dateTime = snapshot.data.data[0].periode;
          var formatterDate = DateFormat('dd MMMM yyyy').format(dateTime);
          var formatterTime = DateFormat('HH.mm').format(dateTime);
            if (snapshot.hasData) {
              return Container(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
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
                                height: 130.0,
                                width: 130.0,
                                child:
                                    Image.asset("lib/src/assets/qr-code.png"),
                              ),
                              Container(
                                margin: EdgeInsets.all(12.0),
                                child: Text(
                                  'Transaksi Berhasil',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ),
                              Container(
                                child: Text("${formatterDate.toString()} ${formatterTime.toString()}"),
                              ),
                              Container(
                                child: Text('via Unity'),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 70.0),
                                child: Text('Detail Pembayaran'),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 12.0),
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
                                          margin: EdgeInsets.only(bottom: 12.0),
                                          child: Text('Jenis Layanan'),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(bottom: 12.0),
                                          child: Text(snapshot.data.data[0].status),
                                        ),
                                        Container(),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(bottom: 12.0),
                                          child: Text('Nomor Handphone'),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(bottom: 12.0),
                                          child: Text(snapshot.data.data[0].noHp),
                                        ),
                                        Container(),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(bottom: 12.0),
                                          child: Text('Provider'),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(bottom: 12.0),
                                          child: Text(snapshot.data.data[0].provider),
                                        ),
                                        Container(),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(bottom: 12.0),
                                          child: Text('Nomor Transaksi'),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(bottom: 12.0),
                                          child: Text(snapshot.data.data[0].transactionId.toString()),
                                        ),
                                        Container(),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Text('Total Tagihan'),
                                        ),
                                        Container(
                                          child: Text(snapshot.data.data[0].totalHarga.toString()),
                                        ),
                                        Container(),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      width: 450.0,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: 
                          (context) => BerandaPage()));
                        },
                        child: Text('Selesai'),
                      ),
                    ),
                  ],
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
