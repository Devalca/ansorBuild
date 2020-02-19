import 'dart:convert';

import 'package:ansor_build/src/model/ansor_model.dart';
import 'package:ansor_build/src/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Wallet> getSaldo() async {
  String url = 'http://192.168.10.11:3000/users/wallet/1';
  final response = await http.get(url, headers: {"Accept": "application/json"});

  if (response.statusCode == 200) {
    return Wallet.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}

class Wallet {
  final int walletId;
  final int saldo_akhir;

  Wallet({this.walletId, this.saldo_akhir});

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(saldo_akhir: json['data'][0]['saldo_akhir']);
  }
}

Future<Album> fetchAlbum() async {
  final response = await http.get('http://192.168.10.11:3000/ppob/pulsa/7');

  if (response.statusCode == 200) {
    return Album.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

Album albumFromJson(String str) => Album.fromJson(json.decode(str));

String albumToJson(Album data) => json.encode(data.toJson());

class Album {
  List<Datum> data;
  String message;

  Album({
    this.data,
    this.message,
  });

  factory Album.fromJson(Map<String, dynamic> json) => Album(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class Datum {
  int id;
  int walletId;
  String noHp;
  int nominal;
  int adminFee;
  String provider;
  int totalHarga;

  Datum({
    this.id,
    this.walletId,
    this.noHp,
    this.nominal,
    this.adminFee,
    this.provider,
    this.totalHarga,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        walletId: json["walletId"],
        noHp: json["no_hp"],
        nominal: json["nominal"],
        adminFee: json["admin_fee"],
        provider: json["provider"],
        totalHarga: json["total_harga"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "walletId": walletId,
        "no_hp": noHp,
        "nominal": nominal,
        "admin_fee": adminFee,
        "provider": provider,
        "total_harga": totalHarga,
      };
}

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Future<Album> futureAlbum;
  Future<Wallet> futureSaldo;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
    futureSaldo = getSaldo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Detail Pembayaran Page'),
        ),
        body: Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: 90.0,
                                    width: 90.0,
                                    child: Image.asset(
                                        "lib/src/assets/qr-code.png"),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Pulsa'),
                                        Text(snapshot.data.data[0].noHp),
                                        Text(snapshot.data.data[0].provider)
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
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
                                        child: Text('Total Harga'),
                                      ),
                                      Container(
                                        child: Text(snapshot
                                            .data.data[0].totalHarga
                                            .toString()),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        child: Text('Biaya Pelayanan'),
                                      ),
                                      Container(
                                        child: Text(snapshot
                                            .data.data[0].adminFee
                                            .toString()),
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
                                          child: Text(snapshot
                                              .data.data[0].adminFee
                                              .toString()),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
                                        child: Text('Unity'),
                                      ),
                                      Container(
                                        child: Icon(Icons.menu),
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
                                              child: Icon(
                                                  Icons.account_balance_wallet),
                                            ),
                                            Container(
                                              child: Text('Saldo Unity'),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                          child: FutureBuilder<Wallet>(
                                        future: futureSaldo,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Text(snapshot
                                                .data.saldo_akhir
                                                .toString());
                                          } else if (snapshot.hasError) {
                                            return Text("${snapshot.error}");
                                          }
                                          return CircularProgressIndicator();
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
                        padding: const EdgeInsets.all(16),
                        width: 450.0,
                        child: RaisedButton(
                          onPressed: () {
                            print('move');                           
                          },
                          child: Text('BAYAR'),
                        ),
                      )
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      );
  }
}