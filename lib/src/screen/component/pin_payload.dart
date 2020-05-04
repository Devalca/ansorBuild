import 'dart:convert';

import 'package:ansor_build/src/model/pdam_model.dart';
import 'package:ansor_build/src/model/pulsa_model.dart';
import 'package:ansor_build/src/screen/component/loading.dart';
import 'package:ansor_build/src/service/local_service.dart';
import 'package:ansor_build/src/service/pdam_service.dart';
import 'package:ansor_build/src/service/pulsa_service.dart';
import 'package:flutter/material.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PinPayloadPage extends StatefulWidget {
  String status;
  PinPayloadPage(this.status);

  @override
  _PinPayloadPageState createState() => _PinPayloadPageState();
}

class _PinPayloadPageState extends State<PinPayloadPage> {
  String konfirmPin;
  LocalService _localService = LocalService();
  PulsaService _pulsaService = PulsaService();
  PdamService _pdamService = PdamService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context, true);
            }),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 80.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Silahkan Masukkan PIN",
                  style: TextStyle(fontSize: 24, color: Colors.green),
                ),
                Container(
                    margin: EdgeInsets.only(
                        top: 10.0, bottom: 50.0, left: 80, right: 80),
                    child: Text(
                      "Silahkan masukkan PIN Anda untuk melanjutkan pembayaran",
                      textAlign: TextAlign.center,
                    )),
                PinEntryTextField(
                  fields: 6,
                  onSubmit: (String pin) async {
                    var pinStatus = widget.status;
                    setState(() {
                      konfirmPin = pin;
                    });
                    if (pinStatus == "prabayar") {
                      _pulsaPrabayar();
                    } else if (pinStatus == "pascabayar") {
                      _pulsaPascabayar();
                    } else if (pinStatus == "pdam") {
                      _pdamPayLoad();
                    }
                  }
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pdamPayLoad() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int payUserId = prefs.getInt("payUserId");
    String payPelanggan = prefs.getString("payPelanggan");
    String payWilayah = prefs.getString("payWilayah");
    int payTagihan = prefs.getInt("payTagihan");
    PostPdam postPdam = PostPdam(
        userId: payUserId,
        walletId: payUserId,
        noPelanggan: payPelanggan,
        namaWilayah: payWilayah,
        tagihan: payTagihan,
        pin: int.parse(konfirmPin));
    _pdamService.createPdamPay(postPdam).then((response) async {
      var headerUrl = response.headers['location'];
      print("INis attsu code : " + response.body);
      if (response.headers != null) {
        if (response.statusCode == 403) {
          PdamDialog().saldoMinDialog(context);
        } else if (response.statusCode == 422) {
          pinDialog(context);
        } else {
          _localService.saveUrlName(headerUrl).then((bool committed) {
            print("Berhasil");
          });
          PdamDialog().nPdamDialog(context);
        }
      }
    });
  }

  Future<void> _pulsaPascabayar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int payTrans = prefs.getInt("payTrans");
    String payNomor = prefs.getString("payNomor");
    int payUserId = prefs.getInt("payUserId");
    Post post = Post(
        userId: payUserId,
        walletId: payUserId,
        noHp: payNomor,
        transactionId: payTrans,
        pin: int.parse(konfirmPin));
    _pulsaService.createPayPasca(post).then((response) async {
      if (response.statusCode == 200) {
        Map blok = jsonDecode(response.body);
        userUid = blok['id'].toString();
        _localService.saveIdName(userUid).then((bool committed) {
          print("INI USERID :" + userUid);
        });
        PulsaDialog().nPulsaDialog(context);
      } else if (response.statusCode == 409) {
        PulsaDialog().pascaDoneDialog(context);
      } else if (response.statusCode == 403) {
        PulsaDialog().saldoMinDialog(context);
      } else if (response.statusCode == 422) {
        pinDialog(context);
      } else {
        print("INI STATUS CODE: " + response.statusCode.toString());
      }
    });
  }

  Future<void> _pulsaPrabayar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int payTrans = prefs.getInt("payTrans");
    String payNomor = prefs.getString("payNomor");
    int payNominal = prefs.getInt("payNominal");
    int payUserId = prefs.getInt("payUserId");
    String payProvider = prefs.getString("payProvider");

    Post post = Post(
      transactionId: payTrans,
      noHp: payNomor,
      nominal: payNominal,
      userId: payUserId,
      walletId: payUserId,
      provider: payProvider,
      pin: int.parse(konfirmPin),
    );
    print(
        "INI Det : ${payTrans.toString()} ${payNomor.toString()} ${payNominal.toString()} ${payUserId.toString()} $payProvider");
    _pulsaService.createPay(post).then((response) async {
      if (response.statusCode == 200) {
        Map blok = jsonDecode(response.body);
        userUid = blok['id'].toString();
        _localService.saveIdName(userUid).then((bool committed) {
          print("INI USERID :" + userUid);
        });
        PulsaDialog().nPulsaDialog(context);
      } else if (response.statusCode == 403) {
        PulsaDialog().saldoMinDialog(context);
      } else if (response.statusCode == 422) {
        pinDialog(context);
      } else {
        print("INI STATUS CODE: " + response.statusCode.toString());
      }
    });
  }
}
