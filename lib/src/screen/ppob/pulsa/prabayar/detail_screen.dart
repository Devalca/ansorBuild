//Detail Pembayaran Prabayar
import 'dart:convert';
import 'package:ansor_build/src/model/ansor_model.dart';
import 'package:ansor_build/src/model/wallet_model.dart';
import 'package:ansor_build/src/screen/component/loading.dart';
import 'package:ansor_build/src/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../selseai_screen.dart';

class DetailPage extends StatefulWidget {
  final String koId;
  final String namaProv;
  DetailPage(this.koId, this.namaProv);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Future<Album> futureAlbum;
  Future<Wallet> futureWallet;
  bool _isLoading = false;
  ApiService _apiService = ApiService();
  String _id = "";
  final cF = NumberFormat.currency(locale: 'ID');

  @override
  void initState() {
    super.initState();
    _apiService.getNameId().then(updateId);
    futureAlbum = fetchAlbum();
    futureWallet = _apiService.getSaldo();
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
        elevation: 1,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
         leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context,true);
              }),
        backgroundColor: Colors.white,
        title: Text(
          'Pembayaran',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        child: FutureBuilder<Album>(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                              child: Container(
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
                                        Image.asset("lib/src/assets/PULSA.png"),
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
                                              child: Text(cF.format(snapshot.data.data[0].totalHarga).replaceAll("IDR", "Rp"))),
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
                                              child: Text(cF.format(snapshot.data.data[0].totalHarga).replaceAll("IDR", "Rp")),
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
                                        child: Text('Un1ty'),
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
                                                'Saldo Un1ty',
                                                style: TextStyle(
                                                    color: Colors.green),
                                              ),
                                            )
                                          ],
                                        ),
                                      ), 
                                      Container(
                                        child: FutureBuilder<Wallet>(
                                        future: futureWallet,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Text(cF.format(snapshot.data.data[0].saldoAkhir).replaceAll("IDR", "Rp"));
                                          } else if (snapshot.hasError) {
                                            print("${snapshot.error}");
                                            return CircularProgressIndicator();
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
                                LoadingServices.loadingDialog(context);
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
                                    userUid = blok['id'].toString();
                                    var koId = userUid;
                                    _apiService.saveNameId(userUid).then((bool committed) {
                                      print(userUid);
                                    });
                                     await Future.delayed(const Duration(seconds: 5));
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
                ),
              );
            } else if (snapshot.hasError) {
              return CircularProgressIndicator();
            }
            return Container();
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
