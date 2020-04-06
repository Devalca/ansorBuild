import 'dart:convert';

import 'package:ansor_build/src/model/login_model.dart';
import 'package:ansor_build/src/routes/routes.dart';
import 'package:ansor_build/src/screen/register/register.dart';
import 'package:ansor_build/src/service/login_services.dart';
import 'package:flutter/material.dart';
import 'package:ansor_build/src/screen/beranda/beranda_screen.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String error = "";
  bool _isLoading = false;
  bool _fieldNohp, _fieldPassword;
  TextEditingController _nohpController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  LoginServices _loginServices = LoginServices();

  createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("No HP atau Password anda Salah!!!"),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text("OK"),
                onPressed: () {},
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(12.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                  Widget>[
            Container(height: 70),
            Center(
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 12.0),
                  height: 80.0,
                  width: 190.0,
                  child: Image.asset('lib/src/assets/lapakSahabat.png')),
            ),
            Container(height: 20),
            Container(
                child: Text("No HP",
                    style: new TextStyle(fontSize: 12.0),
                    textAlign: TextAlign.start)),
            TextField(
              controller: _nohpController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Masukkan No HP',
                errorText: _fieldNohp == null || _fieldNohp
                    ? null
                    : "No HP harus diisi",
              ),
              style: new TextStyle(fontSize: 12.0),
              onChanged: (value) {
                bool isFieldValid = value.trim().isNotEmpty;
                if (isFieldValid != _fieldNohp) {
                  setState(() => _fieldNohp = isFieldValid);
                }
              },
            ),
            Container(height: 10),
            Container(
                child: Text("Kata Sandi",
                    style: new TextStyle(fontSize: 12.0),
                    textAlign: TextAlign.start)),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Masukkan Kata Sandi',
                errorText: _fieldPassword == null || _fieldPassword
                    ? null
                    : "Password harus diisi",
              ),
              style: new TextStyle(fontSize: 12.0),
              onChanged: (value) {
                bool isFieldValid = value.trim().isNotEmpty;
                if (isFieldValid != _fieldPassword) {
                  setState(() => _fieldPassword = isFieldValid);
                }
              },
            ),
            Container(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
              ),
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                height: 35,
                child: RaisedButton(
                  child: Text('MASUK',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white)),
                  color: Colors.green,
                  onPressed: () {
                    setState(() => _isLoading = true);

                    String no_hp = _nohpController.text.toString();
                    String password = _passwordController.text.toString();

                    print("no hp: " + no_hp + " password: " + password);

                    PostLogin login =
                        PostLogin(no_hp: no_hp, password: password);

                    _loginServices.postLogin(login).then((response) async {
                      if (response.statusCode == 200) {
                        print("berhasil body: " + response.body);
                        print(response.statusCode);

                        Map data = jsonDecode(response.body);
                        walletId = data["walletId"].toString();
                        userId = data["userId"].toString();
                        print("walletId: " + walletId);
                        print("userId: " + userId);

                        _loginServices
                            .saveWalletId(walletId)
                            .then((bool committed) {
                          print(walletId);
                        });

                        _loginServices
                            .saveUserId(userId)
                            .then((bool committed) {
                          print(userId);
                        });

                        _toLanding();
                        setState(() => _isLoading = false);
                      } else {
                        print("error: " + response.body);
                        print(response.statusCode);

                        Map data = jsonDecode(response.body);
                        message = data["message"].toString();

                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content:
                                    Text("No HP atau Password anda Salah!!!"),
                                actions: <Widget>[
                                  MaterialButton(
                                    elevation: 5.0,
                                    child: Text("OK"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            });
                      }
                    });
                  },
                ),
              ),
            ),
            Container(height: 30),
            Center(
                child: Column(children: <Widget>[
              Container(
                  child: Text("Lupa Password?",
                      style: new TextStyle(
                        fontSize: 12.0,
                        color: Colors.green,
                      ),
                      textAlign: TextAlign.center)),
              Container(height: 10),
              Divider(
                height: 12,
                color: Colors.black,
              ),
              Container(height: 10),
              new GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (__) => new RegisterPage()));
                },
                child: Container(
                    child: RichText(
                  text: TextSpan(
                      text: "Belum Punya Akun?",
                      style: new TextStyle(fontSize: 12.0, color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                            text: " Daftar",
                            style:
                                TextStyle(fontSize: 12.0, color: Colors.green)),
                      ]),
                )),
              )
            ])),
          ])),
    ));
  }
    _toLanding() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.LandingScreen, (Route<dynamic> route) => false);
  }
}
