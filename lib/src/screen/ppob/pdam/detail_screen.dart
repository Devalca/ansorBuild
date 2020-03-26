import 'dart:convert';
import 'package:ansor_build/src/model/pdam_model.dart';
import 'package:ansor_build/src/model/pulsa_model.dart';
import 'package:ansor_build/src/model/wallet_model.dart';
import 'package:ansor_build/src/screen/component/loading.dart';
import 'package:ansor_build/src/screen/ppob/pulsa/selseai_screen.dart';
import 'package:ansor_build/src/service/local_service.dart';
import 'package:ansor_build/src/service/pdam_service.dart';
import 'package:ansor_build/src/service/pulsa_service.dart';
import 'package:ansor_build/src/service/wallet_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:indonesia/indonesia.dart';
import 'package:intl/intl.dart';

class DetailPagePdam extends StatefulWidget {
  // final String koId;
  // DetailPagePdam(this.koId);

  @override
  _DetailPagePdamState createState() => _DetailPagePdamState();
}

class _DetailPagePdamState extends State<DetailPagePdam> {
  String _id = "";
  DateTime dateTime;
  Future<DetailPdam> fetchdetail;
  PulsaService _pulsaService = PulsaService();
  PdamService _pdamService = PdamService();
  WalletService _walletService = WalletService();
  LocalService _localService = LocalService();
  final cF = NumberFormat.currency(locale: 'ID');
  List<DetailData> _detail = List<DetailData>();
  List<DetailData> _detailForDisplay = List<DetailData>();

  @override
  void initState() {
    super.initState();
    _pdamService.getDetailId().then((value) {
      setState(() {
        _detail.addAll(value.data);
        _detailForDisplay = _detail;
      });
    });
    _localService.getNameId().then(updateId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
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
          'Pembayaran',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            color: Colors.white,
            child: new FutureBuilder<DetailPdam>(
              future: _pdamService.getDetailId(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return new Text('Press button to start');
                  case ConnectionState.waiting:
                    return new Text('Awaiting result...');
                  default:
                    if (snapshot.hasData) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Column(
                              children: <Widget>[
                                _detailHeader(),
                                _detailBody(),
                                _detailPayment(),
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
                              _detailButton()
                            ],
                          ),
                        ],
                      );
                    } else {
                      return new Text('Result: ${snapshot.error}');
                    }
                }
              },
            )),
      ),
    );
  }

  void updateId(String transId) {
    setState(() {
      this._id = transId;
    });
  }

  Widget _detailHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12.0),
            height: 90.0,
            width: 90.0,
            child: Image.asset("lib/src/assets/PDAM.png"),
          ),
          Container(
            padding: const EdgeInsets.only(top: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Air Bandung Kota Bandung'),
                Text('Nomor ' + _detailForDisplay[0].noPelanggan),
                Text(
                    '${_detailForDisplay[0].namaPelanggan} ${_detailForDisplay[0].noPelanggan}')
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _detailBody() {
    dateTime = _detailForDisplay[0].periode;
    var formatterDate = DateFormat('MMMM yyyy').format(dateTime);
    return Column(
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
            border: Border.all(width: 1.0, color: Colors.grey[200]),
          ),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 16.0),
                    child: Text('Periode'),
                  ),
                  Container(
                    child: Text(tanggal(dateTime).toString()),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 16.0),
                    child: Text('Total Tagihan'),
                  ),
                  Container(
                      child: Text(rupiah(_detailForDisplay[0].tagihan)
                          .replaceAll("Rp ", "Rp"))),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 16.0),
                    child: Text('Biaya Pelayanan'),
                  ),
                  Container(
                    child: Text("Rp0"),
                  ),
                ],
              ),
              Divider(),
              Container(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Text('Total'),
                    ),
                    Container(
                      child: Text(rupiah(_detailForDisplay[0].total)
                          .replaceAll("Rp ", "Rp")),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _detailPayment() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(width: 1.0, color: Colors.grey[200]),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(right: 10.0),
                      child: Icon(
                        Icons.account_balance_wallet,
                        color: Colors.green,
                      ),
                    ),
                    Container(
                      child: Text(
                        'Saldo Un1ty',
                        style: TextStyle(color: Colors.green),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  child: FutureBuilder<Wallet>(
                future: _walletService.getSaldo(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(cF
                        .format(snapshot.data.data[0].saldoAkhir)
                        .replaceAll("IDR", "Rp"));
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
    );
  }

  Widget _detailButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: RaisedButton(
        color: Colors.green,
        onPressed: () {
          loadingDialog(context);
          int transactionId = int.parse(_id.toString());
          String nomor = _detailForDisplay[0].noPelanggan;
          int nominal = int.parse(_detailForDisplay[0].total.toString());
          Post post = Post(
              transactionId: transactionId,
              noHp: nomor,
              nominal: nominal,
              userId: 1,
              walletId: 1);
          _pulsaService.createPayPasca(post).then((response) async {
            if (response.statusCode == 200) {
              Map blok = jsonDecode(response.body);
              var userUid = blok['id'].toString();
              var koId = userUid;
              await Future.delayed(const Duration(seconds: 5));
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => SesPulsaPage(koId)));
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
    );
  }
}
