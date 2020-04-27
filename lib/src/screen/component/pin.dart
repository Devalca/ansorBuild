import 'dart:convert';

import 'package:ansor_build/src/model/login_model.dart';
import 'package:ansor_build/src/routes/routes.dart';
import 'package:ansor_build/src/service/local_service.dart';
import 'package:ansor_build/src/service/login_services.dart';
import 'package:flutter/material.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';

class Pin extends StatefulWidget {
  final String noHp;
  Pin({this.noHp});

  @override
  _PinState createState() => _PinState();
}

class _PinState extends State<Pin> {
  bool _isLoading = false;
  LoginServices _loginServices = LoginServices();
  LocalService _localServices = LocalService();
  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
            reverse: true,
            child: Padding(
                padding: EdgeInsets.only(
                    top: 12.0, left: 12.0, right: 12.0, bottom: bottom),
                child: _isLoading
                    ? Center(
                        heightFactor: 30, child: CircularProgressIndicator())
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                            Container(height: 50),
                            Center(
                                child: Text("Silahkan Masukkan PIN Anda",
                                    style: new TextStyle(
                                        fontSize: 18.0, color: Colors.green),
                                    textAlign: TextAlign.start)),
                            // Container(height: 5),
                            // Center(
                            //     child: Text(
                            //         "Silahkan Masukkan PIN Anda dibawah ini",
                            //         style: new TextStyle(fontSize: 14.0),
                            //         textAlign: TextAlign.start)),
                            Container(height: 50),
                            PinEntryTextField(
                              fields: 6,
                              onSubmit: (String pin) {
                                // showDialog(
                                //     context: context,
                                //     builder: (context) {
                                //       return AlertDialog(
                                //         title: Text("Pin"),
                                //         content: Text('Pin entered is $pin'),
                                //       );
                                //     });

                                print("no hp: " + widget.noHp);
                                print("pin: " + pin);

                                LoginPin loginPin = LoginPin(
                                    noHp: widget.noHp, pin: int.parse(pin));

                                _loginServices
                                    .loginPin(loginPin)
                                    .then((response) async {
                                  if (response.statusCode == 200) {
                                    print("berhasil body: " + response.body);
                                    print(response.statusCode);

                                    List<dynamic> data =
                                        json.decode(response.body);
                                    // print(data[0]['walletId']);

                                    walletId = data[0]['walletId'].toString();
                                    userId = data[0]['userId'].toString();
                                    pin = data[0]['pin'].toString();
                                    isLogin = true;
                                    print("walletId: " + walletId);
                                    print("userId: " + userId);
                                    print("pin: " + pin);
                                    print("isLogin: " + isLogin.toString());

                                    _localServices
                                        .saveWalletId(walletId)
                                        .then((bool committed) {
                                      print(walletId);
                                    });

                                    _localServices
                                        .saveUserId(userId)
                                        .then((bool committed) {
                                      print(userId);
                                    });

                                    _localServices
                                        .saveUserId(pin)
                                        .then((bool committed) {
                                      print(pin);
                                    });

                                    _localServices
                                        .isLogin(isLogin)
                                        .then((bool committed) {
                                      print(isLogin);
                                    });

                                    setState(() => _isLoading = true);

                                    _toLanding();

                                    setState(() => _isLoading = false);
                                  } else {
                                    print("error: " + response.body);
                                    print(response.statusCode);

                                    Map data = jsonDecode(response.body);
                                    message = data["message"].toString();

                                    walletId = "0";
                                    userId = "0";
                                    pin = "0";
                                    isLogin = false;
                                    print("walletId: " + walletId);
                                    print("userId: " + userId);
                                    print("pin: " + pin);
                                    print("isLogin: " + isLogin.toString());

                                    _localServices
                                        .saveWalletId(walletId)
                                        .then((bool committed) {
                                      print(walletId);
                                    });

                                    _localServices
                                        .saveUserId(userId)
                                        .then((bool committed) {
                                      print(userId);
                                    });

                                    _localServices
                                        .saveUserId(pin)
                                        .then((bool committed) {
                                      print(pin);
                                    });

                                    _localServices
                                        .isLogin(isLogin)
                                        .then((bool committed) {
                                      print(isLogin);
                                    });

                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text("Pin Gagal",
                                                style: TextStyle(
                                                    color: Colors.green)),
                                            content: Text(
                                                "Konfirmasi pin Anda salah"),
                                            actions: <Widget>[
                                              MaterialButton(
                                                elevation: 5.0,
                                                child: Text("OK",
                                                    style: TextStyle(
                                                        color: Colors.green)),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              )
                                            ],
                                          );
                                        });

                                    setState(() => _isLoading = false);
                                  }
                                });
                              },
                            ),
                          ]))));
  }

  _toLanding() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.LandingScreen, (Route<dynamic> route) => false);
  }
}
