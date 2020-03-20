import 'package:ansor_build/src/model/wallet_model.dart';
import 'package:ansor_build/src/screen/topup/atm_screen.dart';
import 'package:ansor_build/src/screen/topup/banking_screen.dart';
import 'package:ansor_build/src/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TopupPage extends StatefulWidget {
  @override
  _TopupPageState createState() => _TopupPageState();
}

class _TopupPageState extends State<TopupPage> {
  ApiService _apiService = ApiService();
  final cF = NumberFormat.currency(locale: 'ID');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context, true);
            }),
        backgroundColor: Colors.white,
        title: Text(
          'Top Up',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
              child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(20.0),
                height: 60.0,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                              padding:
                                  const EdgeInsets.only(left: 16.0, right: 10.0),
                              child: Icon(
                                Icons.account_balance_wallet,
                                color: Colors.green,
                              )),
                          Text(
                            'Saldo Unity',
                            style: TextStyle(color: Colors.green),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: FutureBuilder<Wallet>(
                        future: _apiService.getSaldo(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            if (snapshot.hasData)
                              return Center(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.centerRight,
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                              cF
                                                  .format(snapshot
                                                      .data.data[0].saldoAkhir)
                                                  .replaceAll("IDR", "Rp"),
                                              style: TextStyle(fontSize: 16.0)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          return Text('MOHON TUNGGU...');
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Center(
                    child: Text(
                  'Maksimal saldo unity cash adalah Rp20.000.000',
                  style: TextStyle(color: Colors.black45),
                )),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Text('QR Code Kamu'),
                        ),
                        Container()
                      ],
                    ),
                    Container(
                      height: 200.0,
                      child: Center(
                          child: Image.asset("lib/src/assets/qr-code.png")),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Center(
                        child: Text(
                          'asd sadsa dsad sadsadsadsa sadsa asdsad sadsa dsads adsa das dsa dsa d sad sa dsa ds adsadsadsadsa dsa dsa dsa dasdsadsad sadsad saddas dsad sad sa das das d asd sad sad sa dsa dsa dsa das das d',
                          style: TextStyle(color: Colors.black45),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Metode Top Up Lainnya'),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => AtmPage()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.black12, width: 1.0)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        border: Border.all(
                                            width: 1, color: Colors.grey[200]),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    height: 35.0,
                                    width: 35.0,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      'ATM',
                                      style: TextStyle(fontSize: 12.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 50.0,
                              width: 50.0,
                              child: Icon(Icons.arrow_forward_ios),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BankingPage()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.black12, width: 1.0)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        border: Border.all(
                                            width: 1, color: Colors.grey[200]),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    height: 35.0,
                                    width: 35.0,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      'Internet/Mobile Banking',
                                      style: TextStyle(fontSize: 12.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 50.0,
                              width: 50.0,
                              child: Icon(Icons.arrow_forward_ios),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
