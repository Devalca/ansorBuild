import 'dart:convert';

import 'package:ansor_build/src/model/login_model.dart';
import 'package:ansor_build/src/screen/login/login.dart';
import 'package:ansor_build/src/service/login_services.dart';
import 'package:flutter/material.dart';

class Reverif extends StatefulWidget {
  @override
  _ReverifState createState() => _ReverifState();
}

class _ReverifState extends State<Reverif> {
  bool error = true;
  String errorText = "";
  String message;
  TextEditingController _emailController = TextEditingController();

  LoginServices _loginServices = LoginServices();

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(height: 70),
                Center(
                    child: Text("Silahkan Masukkan Email Anda",
                        style:
                            new TextStyle(fontSize: 18.0, color: Colors.green),
                        textAlign: TextAlign.start)),
                Container(height: 50),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Contoh: email@gmail.com',
                    errorText: error ? null : errorText,
                  ),
                  style: new TextStyle(fontSize: 14.0),
                  onChanged: (value) {
                    if (value.length == 0) {
                      return setState(
                          () => {error = false, errorText = "Wajib diisi"});
                    } else {
                      return setState(() => error = true);
                    }
                  },
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: double.infinity,
                    height: 35,
                    child: RaisedButton(
                      child: Text('KIRIM',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white)),
                      color: Colors.green,
                      onPressed: () {
                        String email = _emailController.text.toString();

                        print("email: " + email);

                        PostEmail data = PostEmail(email: email);

                        _loginServices.postEmail(data).then((response) async {
                          if (_emailController.text.isEmpty) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Verifikasi Email",
                                        style: TextStyle(color: Colors.green)),
                                    content:
                                        Text("Silahkan Masukkan Email Anda"),
                                    actions: <Widget>[
                                      MaterialButton(
                                        elevation: 5.0,
                                        child: Text("OK",
                                            style:
                                                TextStyle(color: Colors.green)),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                });
                          } else if (response.statusCode == 200) {
                            print("berhasil body: " + response.body);
                            print(response.statusCode);

                            Map data = jsonDecode(response.body);
                            message = data["message"].toString();

                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Verifikasi Email",
                                        style: TextStyle(color: Colors.green)),
                                    content: Text(
                                        "Silahkan Cek Email Anda dan melakukan Aktifasi akun"),
                                    actions: <Widget>[
                                      MaterialButton(
                                        elevation: 5.0,
                                        child: Text("OK",
                                            style:
                                                TextStyle(color: Colors.green)),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              new MaterialPageRoute(
                                                  builder: (__) =>
                                                      new Login()));
                                        },
                                      )
                                    ],
                                  );
                                });
                          } else {
                            print("error: " + response.body);
                            print(response.statusCode);

                            Map data = jsonDecode(response.body);
                            message = data["message"].toString();
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Verifikasi Email",
                                        style: TextStyle(color: Colors.green)),
                                    content:
                                        Text("Verifikasi Email Anda Gagal"),
                                    actions: <Widget>[
                                      MaterialButton(
                                        elevation: 5.0,
                                        child: Text("OK",
                                            style:
                                                TextStyle(color: Colors.green)),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              new MaterialPageRoute(
                                                  builder: (__) =>
                                                      new Login()));
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
              ],
            ),
          )),
    );
  }
}
