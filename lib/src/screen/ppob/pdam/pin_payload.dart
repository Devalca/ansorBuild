import 'dart:convert';

import 'package:ansor_build/src/model/pulsa_model.dart';
import 'package:ansor_build/src/screen/component/loading.dart';
import 'package:ansor_build/src/service/local_service.dart';
import 'package:ansor_build/src/service/pulsa_service.dart';
import 'package:flutter/material.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PinPayLoad extends StatefulWidget {
  @override
  _PinPayLoadState createState() => _PinPayLoadState();
}

class _PinPayLoadState extends State<PinPayLoad> {
  String konfirmPin;
  PulsaService _pulsaService = PulsaService();
  LocalService _localService = LocalService();

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
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    int payTrans = prefs.getInt("payTrans");
                    String payNomor = prefs.getString("payNomor");
                    int payUserId = prefs.getInt("payUserId");
                    setState(() {
                      konfirmPin = pin;
                    });
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
                        _localService
                            .saveIdName(userUid)
                            .then((bool committed) {
                          print("INI USERID :" + userUid);
                        });
                        PulsaDialog().nPulsaDialog(context);
                      } else if (response.statusCode == 409) {
                        PulsaDialog().pascaDoneDialog(context);
                      } else if (response.statusCode == 403) {
                        PulsaDialog().saldoMinDialog(context);
                      } else if (response.statusCode == 422) {
                        PulsaDialog().pinDialog(context);
                      } else {
                        print("INI STATUS CODE: " +
                            response.statusCode.toString());
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
