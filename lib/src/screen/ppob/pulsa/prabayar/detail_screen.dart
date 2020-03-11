//Detail Pembayaran Prabayar
import 'dart:convert';
import 'package:ansor_build/src/model/ansor_model.dart';
import 'package:ansor_build/src/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../selseai_screen.dart';

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
  final int saldoAkhir;

  Wallet({this.walletId, this.saldoAkhir});

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(saldoAkhir: json['data'][0]['saldo_akhir']);
  }
}

class DetailPage extends StatefulWidget {
  final String koId;
  final String namaProv;
  DetailPage(this.koId, this.namaProv);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Future<Album> futureAlbum;
  bool _isLoading = false;
  ApiService _apiService = ApiService();
  String _id = "";

  @override
  void initState() {
    super.initState();
    _apiService.getNameId().then(updateId);
    futureAlbum = fetchAlbum();
  }

  Future<Album> fetchAlbum() async {
    String baseUrl = "http://192.168.10.11:3000/ppob/pulsa/";
    final response = await http.get(baseUrl + widget.koId);
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
        elevation: 0.1,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Detail Pembayaran Page',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
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
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 12.0),
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
                                      Text(snapshot.data.data[0].noHp),
                                      Text(snapshot.data.data[0].provider)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(left: 16.0),
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
                                          padding:
                                              EdgeInsets.only(bottom: 16.0),
                                          child: Text('Total Harga'),
                                        ),
                                        Container(
                                            child: Text("Rp" +
                                                snapshot.data.data[0].totalHarga
                                                    .toString())),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          padding:
                                              EdgeInsets.only(bottom: 16.0),
                                          child: Text('Biaya Pelayanan'),
                                        ),
                                        Container(
                                          // snapshot.data.data[0].adminFee.toString()
                                          child: Text("Rp0"),
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
                                            child: Text("Rp" +
                                                snapshot.data.data[0].totalHarga
                                                    .toString()),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
                                      child: Icon(
                                        Icons.more_vert,
                                        color: Colors.green,
                                      ),
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
                                            padding:
                                                EdgeInsets.only(right: 10.0),
                                            child: Icon(
                                              Icons.account_balance_wallet,
                                              color: Colors.green,
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              'Saldo Unity',
                                              style: TextStyle(
                                                  color: Colors.green),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                        child: FutureBuilder<Wallet>(
                                      future: getSaldo(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text("Rp" +
                                              snapshot.data.saldoAkhir
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
                      height: 90.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Divider(
                          color: Colors.black,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: RaisedButton(
                            color: Colors.green,
                            onPressed: () {
                              // setState(() => _isLoading = true);
                              int transactionId = int.parse(_id.toString());
                              String nomorHp =
                                  snapshot.data.data[0].noHp.toString();
                              int nominal = int.parse(
                                  snapshot.data.data[0].nominal.toString());
                              Post post = Post(
                                  transactionId: transactionId,
                                  noHp: nomorHp,
                                  nominal: nominal,
                                  userId: 1,
                                  walletId: 1,
                                  provider: widget.namaProv);
                              _apiService
                                  .createPay(post)
                                  .then((response) async {
                                if (response.statusCode == 200) {
                                  Map blok = jsonDecode(response.body);
                                  var userUid = blok['id'].toString();
                                  var koId = userUid;
                                  // _apiService.saveNameId(userUid).then((bool committed) {
                                  //   print(userUid);
                                  // });
                                  // //  await new Future.delayed(const Duration(seconds: 5));
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SesPulsaPage(koId)));
                                  //   print(post);
                                  // setState(() => _isLoading = false);
                                } else {
                                  print(response.statusCode);
                                }
                              });
                            },
                            child: Text(
                              'BAYAR',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    _isLoading
                        ? Stack(
                            children: <Widget>[
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

  // Widget _detailPembayaran() {
  //   return TextField(
  //     controller: _controllerNominal,
  //     keyboardType: TextInputType.number,
  //     decoration: InputDecoration(
  //       labelText: "Nominal",
  //       errorText:
  //           _isFieldNominal == null || _isFieldNominal ? null : "WOYYY 1!1!1!",
  //     ),
  //     onChanged: (value) {
  //       bool isFieldValid = value.trim().isNotEmpty;
  //       if (isFieldValid != _isFieldNominal) {
  //         setState(() => _isFieldNominal = isFieldValid);
  //       }
  //     },
  //   );
  // }
}
