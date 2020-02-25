import 'dart:convert';

import 'package:ansor_build/src/model/ansor_model.dart';
import 'package:ansor_build/src/screen/beranda/beranda_screen.dart';
import 'package:ansor_build/src/screen/ppob/pulsa/selseai_screen.dart';
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

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _isLoading = false;
  ApiService _apiService = ApiService();
  String _id = "";

  @override
  void initState() {
    _apiService.getNameId().then(updateId);
    super.initState();
  }

  Future<Album> fetchAlbum() async {
    String baseUrl = "http://192.168.10.11:3000/ppob/pulsa/";
    final response =
        await http.get(baseUrl + _id);
    print(response.body);
    if (response.statusCode == 200) {
      return albumFromJson(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pembayaran Page'),
      ),
      body: Center(
        child: FutureBuilder<Album>(
          future: fetchAlbum(),
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
                                  child:
                                      Image.asset("lib/src/assets/qr-code.png"),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text('Pulsa'),
                                      Text((snapshot.data.data[0].noHp) != null ? snapshot.data.data[0].noHp : "Proses" ),
                                      Text((snapshot.data.data[0].provider) != null ? snapshot.data.data[0].provider : "Proses" )
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
                                      child: Text((snapshot.data.data[0].totalHarga) != null ? snapshot.data.data[0].totalHarga.toString() : "Proses" )
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
                                      child: Text((snapshot.data.data[0].adminFee) != null ? snapshot.data.data[0].adminFee.toString() : "Proses" ),
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
                                        child: Text((snapshot.data.data[0].totalHarga) != null ? snapshot.data.data[0].totalHarga.toString() : "Proses" ),
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
                                      future: getSaldo(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(snapshot.data.saldo_akhir
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
                          setState(() => _isLoading = true);
                          int transactionId = int.parse(_id.toString());
                          String nomorHp =
                              snapshot.data.data[0].noHp.toString();
                          int nominal = int.parse(
                              snapshot.data.data[0].nominal.toString());
                          Post post = Post(
                              transactionId: transactionId,
                              noHp: nomorHp,
                              nominal: nominal);
                          _apiService.createPay(post).then((response) async {
                            if (response.statusCode == 200) {
                              print(response.statusCode);
                              print('Berhasil');
                              print(response.body);
                              Map blok = jsonDecode(response.body);
                              userUid = blok['id'].toString();
                              _apiService.saveNameId(userUid).then((bool committed) {
                                print(userUid);
                              });
                              //  await new Future.delayed(const Duration(seconds: 5));
                               Navigator.pushReplacement(context, MaterialPageRoute(builder: 
                               (context) => SesPulsaPage()
                               ));
                                print(post);
                              setState(() => _isLoading = false);
                            } else {
                              print(response.statusCode);
                            }
                          });
                        },
                        child: Text('BAYAR'),
                      ),
                    ),
                    _isLoading
                        ? Stack(
                            children: <Widget>[
                              Opacity(
                                opacity: 0.3,
                                child: ModalBarrier(
                                  dismissible: false,
                                  color: Colors.grey,
                                ),
                              ),
                              Center(
                                child: CircularProgressIndicator(),
                              ),
                            ],
                          )
                        : Container(),
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

  void updateId(String transId) {
    setState(() {
      this._id = transId;
    });
  }
}
