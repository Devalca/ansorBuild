import 'package:ansor_build/src/screen/topup/atm_screen.dart';
import 'package:ansor_build/src/screen/topup/banking_screen.dart';
import 'package:flutter/material.dart';

class TopupPage extends StatefulWidget {
  @override
  _TopupPageState createState() => _TopupPageState();
}

class _TopupPageState extends State<TopupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Up'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
              height: 80.0,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.account_balance_wallet),
                        Text('Saldo Unity')
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Text(
                      'Rp 1.050.000',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Center(
                  child: Text('Maksimal saldo unity cash adalah Rp20.000.000')),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(left: 16.0, top: 15.0),
                        child: Text('QR Code Kamu'),
                      ),
                      Container()
                    ],
                  ),
                  Container(
                    height: 300.0,
                    child: Center(
                        child: Image.asset("lib/src/assets/qr-code.png")),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                    child: Center(
                      child: Text(
                        'asd sadsa dsad sadsadsadsa sadsa asdsad sadsa dsads adsa das dsa dsa d sad sa dsa ds adsadsadsadsa dsa dsa dsa dasdsadsad sadsad saddas dsad sad sa das das d asd sad sad sa dsa dsa dsa das das d',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
              child: Column(
                children: <Widget>[
                  Text('Metode Top Up Lainnya'),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: 
                      (context) => AtmPage()
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(color: Colors.black, width: 1.0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Container(
                                    height: 50.0,
                                    width: 50.0,
                                    child: Icon(Icons.add_a_photo)),
                                Container(
                                  child: Text(
                                    'ATM',
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 50.0,
                            width: 50.0,
                            child: Icon(Icons.arrow_back_ios),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: 
                      (context) => BankingPage()
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(color: Colors.black, width: 1.0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Container(
                                    height: 50.0,
                                    width: 50.0,
                                    child: Icon(Icons.attach_money)),
                                Container(
                                  child: Text(
                                    'Internet/Mobile Banking',
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 50.0,
                            width: 50.0,
                            child: Icon(Icons.arrow_back_ios),
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
    );
  }
}
