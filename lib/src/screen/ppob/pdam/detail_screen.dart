import 'dart:convert';

import 'package:ansor_build/src/model/pdam_model.dart';
import 'package:ansor_build/src/model/wallet_model.dart';
import 'package:ansor_build/src/screen/component/formatIndo.dart';
import 'package:ansor_build/src/screen/component/loading.dart';
import 'package:ansor_build/src/screen/ppob/pdam/selesai_screen.dart';
import 'package:ansor_build/src/service/local_service.dart';
import 'package:ansor_build/src/service/pdam_service.dart';
import 'package:ansor_build/src/service/wallet_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailPagePdam extends StatefulWidget {
  final String koId;
  DetailPagePdam(this.koId);

  @override
  _DetailPagePdamState createState() => _DetailPagePdamState();
}

class _DetailPagePdamState extends State<DetailPagePdam> {
  String _idWallet;
  DateTime dateTime;
  PdamService _pdamService = PdamService();
  WalletService _walletService = WalletService();
  LocalService _localService = LocalService();
  List<DetailData> _detail = List<DetailData>();
  List<DetailData> _detailForDisplay = List<DetailData>();

  Future<DetailPdam> getDetailId() async {
    String baseUrl = "http://103.9.125.18:3000/ppob/pdam/";
    final response = await http.get(
      baseUrl + widget.koId,
    );
    if (response.statusCode == 200) {
      return detailPdamFromJson(response.body);
    } else {
      throw Exception('Failed to load album dan SATATUS CODE : ' +
          response.statusCode.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _localService.getWalletId().then(updateWallet);
    getDetailId().then((value) {
      setState(() {
        _detail.addAll(value.data);
        _detailForDisplay = _detail;
      });
    });
  }

  void updateWallet(String idWallet) {
    setState(() {
      this._idWallet = idWallet;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
        body: FutureBuilder<DetailPdam>(
          future: getDetailId(),
          builder: (context, snapshot) {
            if (_detailForDisplay.length == 0) {
              return centerLoading();
              // return Text('Result: ${snapshot.error}');
            } else {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  // return Text('Mulai');
                  return Center(child: Text('${snapshot.error}'));
                case ConnectionState.waiting:
                  return centerLoading();
                // return Text('Result: ${snapshot.error}');
                default:
                  if (snapshot.hasData) {
                    return Container(
                        color: Colors.white,
                        child: Column(
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
                                  height: 12,
                                  color: Colors.grey,
                                ),
                                _detailButton()
                              ],
                            ),
                          ],
                        ));
                  } else {
                    return Center(child: Text('${snapshot.error}'));
                  }
              }
            }
          },
        ));
  }

  Widget _detailHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12.0),
            height: 70.0,
            width: 70.0,
            child: Image.asset(
              "lib/src/assets/PDAM.png",
              fit: BoxFit.fill,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Air PDAM ' + _detailForDisplay[0].namaWilayah),
                Text('Nomor ' + _detailForDisplay[0].noPelanggan),
                Text(
                    '${_detailForDisplay[0].namaPelanggan} - ${_detailForDisplay[0].noPelanggan}')
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _detailBody() {
    dateTime = _detailForDisplay[0].periode;
    // var formatterDate = DateFormat('MMMM yyyy').format(dateTime);
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
                    child: Text(formatBlnTahun(dateTime).toString()),
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
                      child: Text(formatRupiah(_detailForDisplay[0].tagihan)
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
                      child: Text(formatRupiah(_detailForDisplay[0].adminFee)
                          .replaceAll("Rp ", "Rp"))),
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
                      child: Text(formatRupiah(_detailForDisplay[0].total)
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
                    return Text(formatRupiah(snapshot.data.data[0].saldoAkhir)
                        .replaceAll("Rp ", "Rp"));
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
          String nomor = _detailForDisplay[0].noPelanggan;
          String wilayah = _detailForDisplay[0].namaWilayah;
          int tagihan = _detailForDisplay[0].tagihan;
          int idWallet = int.parse(_idWallet);
          PostPdam postPdam = PostPdam(
              userId: idWallet,
              walletId: idWallet,
              noPelanggan: nomor,
              namaWilayah: wilayah,
              tagihan: tagihan);
          _pdamService.createPdamPay(postPdam).then((response) async {
            var headerUrl = response.headers['location'];
            if (response.headers != null) {
              if (response.statusCode == 403) {
                PdamDialog().saldoMinDialog(context);
              } else {
                _localService.saveUrlName(headerUrl).then((bool committed) {});
                PdamDialog().nPdamDialog(context);
              }
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
