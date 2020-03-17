import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:ansor_build/src/screen/ppob/pln/pembayaran_berhasil.dart';
import 'package:ansor_build/src/screen/ppob/pln/pembayaran_gagal.dart';
import 'package:ansor_build/src/model/pln_model.dart';
import 'package:ansor_build/src/service/pln_services.dart';

Future<Wallet> getWallet() async {
  String url = 'http://192.168.10.11:3000/users/wallet/1';
  final response = await http.get(url, headers: {"Accept": "application/json"});

  if (response.statusCode == 200) {
    return Wallet.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load wallet');
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

class ListrikPembayaran extends StatefulWidget {
  final String status;
  ListrikPembayaran({this.status});

  @override
    _ListrikPembayaranState createState() => _ListrikPembayaranState();
}

class _ListrikPembayaranState extends State<ListrikPembayaran> {
  bool _isLoading = false;
  PlnServices _plnServices = PlnServices();
  String _transactionId = "";
  String url = "";

  Future<Album> futureAlbum;
  String text_to_show = "";

  TextEditingController _namaController = TextEditingController();

  @override
  void initState() {
    super.initState();

    readData("transactionId");

    _plnServices.getTransactionId().then(updateId);
  }

  void updateId(String transactionId) {
    setState(() {
      this._transactionId = transactionId;
    });
  }

  Future<Album> fetchAlbum() async {
    final response = await http.get('http://192.168.10.11:3000' + _transactionId);

    if (response.statusCode == 200) {
      return albumFromJson(response.body);
    } else {
      throw Exception('Failed to load Detail Pln');
    }
  }

  readData(String text) async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      text_to_show = prefs.getString(text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        title: Text(
          'Pembayaran',
          style: TextStyle(color: Colors.white),
        )
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              
              FutureBuilder<Album>(
                future: fetchAlbum(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if(snapshot.data == null) {
                      return Text("Tidak ada Data");
                    }else{
                      return (
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 50.0,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: 12.0),
                                      height: 90.0,
                                      width: 90.0,
                                      child: Image.asset("lib/src/assets/LISTRIK.png"),
                                    ),
                                    Container(
                                      child: Text(
                                        // "Token Listrik PLN\n" + snapshot.data.data[0].nama_pelanggan + "\n" + "Nomor "+ snapshot.data.data[0].no_meter
                                        "Token Listrik PLN\n" + snapshot.data.nama_pelanggan + "\n" + "Nomor "+ snapshot.data.no_meter
                                      ),
                                    ),
                                  ]
                                ),
                              ),

                              Container( height: 15 ),

                              Text("Detail Pembayaran", textAlign: TextAlign.start, style: new TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),

                              Container( height: 15 ),

                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                width: double.infinity,
                                height: 140.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  border: Border.all(color: Colors.grey[300],width: 1)
                                ),
                                child: Column(
                                  children: <Widget>[
                                    
                                    Expanded(
                                      flex: 1,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            child: Text("Periode"),
                                          ),
                                          Container(
                                            // child: Text(snapshot.data.data[0].createdAt),
                                            child: Text(DateFormat('dd M yyyy').format(snapshot.data.createdAt)),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            child: Text("Total Tagihan"),
                                          ),
                                          Container(
                                            // child: Text("Rp." + snapshot.data.data[0].total.toString()),
                                            child: Text("Rp." + snapshot.data.total.toString()),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            child: Text("Biaya Pelayanan"),
                                          ),
                                          Container(
                                            child: Text("Rp. 0"),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Expanded(
                                      child: Row(
                                        
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            child: Text("Total"),
                                          ),
                                          Container(
                                            // child: Text("Rp." + snapshot.data.data[0].total.toString()),
                                            child: Text("Rp." + snapshot.data.total.toString()),
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),

                              Container( height: 15 ),

                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                width: double.infinity,
                                height: 80.0,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  border: Border.all(color: Colors.grey[300], width: 1)
                                ),
                                child: Column(
                                  children: <Widget>[
                                    
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                              "Un1ty"
                                            ),
                                          ),
                                          Container(
                                            child: Icon(
                                              Icons.more_vert,
                                              color: Colors.green,
                                              size: 24.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                              "Saldo Un1ty",
                                              style: new TextStyle(color: Colors.green)
                                            ),
                                          ),
                                          Container(
                                            child: FutureBuilder<Wallet>(
                                              future: getWallet(),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  return Text("Rp. " + snapshot.data.saldoAkhir.toString());
                                                } else if (snapshot.hasError) {
                                                  return Text("${snapshot.error}");
                                                }
                                                return CircularProgressIndicator();
                                              },
                                            )
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Container( height: 15 ),

                              Container(
                                alignment: Alignment.bottomCenter,
                                child: Align(
                                  child: SizedBox(
                                    width :double.infinity,
                                    height: 35,
                                    child: RaisedButton(
                                      child: Text('BAYAR', style: TextStyle(color: Colors.white)),
                                      color: Colors.green,
                                      onPressed: () {
                                        setState(() => _isLoading = true);
                                        String id = _transactionId;
                                        String transactionId = id.substring(10);
                                        // String noMeter = snapshot.data.data[0].no_meter;
                                        String noMeter = snapshot.data.no_meter;
                                        int nominal = snapshot.data.nominal;

                                        print("transactionId: " + transactionId);
                                        print("noMeter: " + noMeter);

                                        PostPascaTransaction pascaTransaction = PostPascaTransaction(
                                          noMeter: noMeter,
                                          transactionId: transactionId,
                                          userId: 1,
                                          walletId: 1
                                        );

                                        PostPraTransaction praTransaction = PostPraTransaction(
                                          noMeter: noMeter,
                                          nominal: nominal,
                                          transactionId: transactionId,
                                          userId: 1,
                                          walletId: 1
                                        );

                                        if(widget.status == "pascabayar"){
                                          _plnServices.postPascaTransaction(pascaTransaction).then((response) async{
                                            print(response.statusCode);
                                            if(response.statusCode == 302){
                                              print('Berhasil');
                                              url = response.headers['location'];
                                              print("url: " + url);

                                              _plnServices.saveTransactionId(url).then((bool committed) {
                                                print(url);
                                              });
                                              
                                              Navigator.push(context, new MaterialPageRoute(builder: (__) => new PembayaranBerhasil(status: widget.status)));
                                              setState(() => _isLoading = false);
                                            }else if(response.statusCode == 200){
                                              print('Berhasil');

                                              Map data = jsonDecode(response.body);
                                              id = data['id'].toString();
                                              url = '/ppob/detail/pln/' + id;
                                              print("url" + url);
                                              
                                              _plnServices.saveTransactionId(url).then((bool committed) {
                                                print(url);
                                              });

                                              Navigator.push(context, new MaterialPageRoute(builder: (__) => new PembayaranBerhasil(status: widget.status)));
                                              setState(() => _isLoading = false);
                                            }else{
                                              print("Gagal");
                                              print(response.statusCode);

                                              Navigator.push(context, new MaterialPageRoute(builder: (__) => new PembayaranGagal()));
                                              setState(() => _isLoading = false);
                                            }
                                          });
                                        }else{
                                          _plnServices.postPraTransaction(praTransaction).then((response) async{
                                            print(response.statusCode);
                                            if(response.statusCode == 302){
                                              print('Berhasil');
                                              url = response.headers['location'];
                                              print("url: " + url);

                                              _plnServices.saveTransactionId(url).then((bool committed) {
                                                print(url);
                                              });
                                              
                                              Navigator.push(context, new MaterialPageRoute(builder: (__) => new PembayaranBerhasil()));
                                              setState(() => _isLoading = false);
                                            }else if(response.statusCode == 200){
                                              print('Berhasil');

                                              Map data = jsonDecode(response.body);
                                              id = data['id'].toString();
                                              url = '/ppob/detail/pln/' + id;
                                              print("url" + url);
                                              
                                              _plnServices.saveTransactionId(url).then((bool committed) {
                                                print(url);
                                              });

                                              Navigator.push(context, new MaterialPageRoute(builder: (__) => new PembayaranBerhasil()));
                                              setState(() => _isLoading = false);
                                            }else{
                                              print("Gagal");
                                              print(response.statusCode);

                                              Navigator.push(context, new MaterialPageRoute(builder: (__) => new PembayaranGagal()));
                                              setState(() => _isLoading = false);
                                            }
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              )
                            ]
                          ),
                        )
                      );  
                    }
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  return CircularProgressIndicator();
                },
              ),
            ]
          )
        ),
      )
    );
  }
}