import 'dart:convert';

import 'package:ansor_build/src/model/login_model.dart';
import 'package:ansor_build/src/routes/routes.dart';
import 'package:ansor_build/src/screen/beranda/landing_screen.dart';
import 'package:ansor_build/src/screen/component/pin.dart';
import 'package:ansor_build/src/screen/login/reverif.dart';
import 'package:ansor_build/src/screen/register/register.dart';
import 'package:ansor_build/src/service/local_service.dart';
import 'package:ansor_build/src/service/login_services.dart';
import 'package:flutter/material.dart';
import 'package:ansor_build/src/screen/beranda/beranda_screen.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String error = "";

  bool _isLoading = false;
  bool _fieldNohp = true;
  bool _fieldPassword = true;
  bool _obscureText = true;

  TextEditingController _nohpController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  LoginServices _loginServices = LoginServices();
  LocalService _localServices = LocalService();

  Future cekLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getBool("isLogin") == true) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => new LandingPage()));
    }
  }

  login() {
    if (_nohpController.text.isEmpty && _passwordController.text.isEmpty) {
      setState(() => {_fieldNohp = false, _fieldPassword = false});
    } else if (_nohpController.text.isEmpty) {
      setState(() => _fieldNohp = false);
    } else if (_passwordController.text.isEmpty) {
      setState(() => _fieldPassword = false);
    } else {
      setState(() => _isLoading = true);
      String no_hp = _nohpController.text.toString();
      String password = _passwordController.text.toString();

      print("no hp: " + no_hp + " password: " + password);

      PostLogin login = PostLogin(no_hp: no_hp, password: password);

      _loginServices.postLogin(login).then((response) async {
        if (response.statusCode == 200) {
          print("berhasil body: " + response.body);
          print(response.statusCode);

          _localServices.saveNoHp(no_hp).then((bool committed) {
            print(no_hp);
          });

          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (__) => new Pin(statusbyr: "login")));

          setState(() => _isLoading = false);
        } else if (response.statusCode == 403) {
          print("error: " + response.body);
          print(response.statusCode);

          Map data = jsonDecode(response.body);
          message = data["message"].toString();

          walletId = "0";
          userId = "0";
          isLogin = false;
          print("walletId: " + walletId);
          print("userId: " + userId);
          print("isLogin: " + isLogin.toString());

          _localServices.saveWalletId(walletId).then((bool committed) {
            print(walletId);
          });

          _localServices.saveUserId(userId).then((bool committed) {
            print(userId);
          });

          _localServices.isLogin(isLogin).then((bool committed) {
            print(isLogin);
          });

          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Login Gagal",
                      style: TextStyle(color: Colors.green)),
                  content: Text(
                      "Anda Belum melakukan aktivasi. Lakukan verifikasi email"),
                  actions: <Widget>[
                    MaterialButton(
                      elevation: 5.0,
                      child: Text("OK", style: TextStyle(color: Colors.green)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (__) => new Reverif()));
                      },
                    )
                  ],
                );
              });

          setState(() => _isLoading = false);
        } else {
          print("error: " + response.body);
          print(response.statusCode);

          Map data = jsonDecode(response.body);
          message = data["message"].toString();

          walletId = "0";
          userId = "0";
          isLogin = false;
          print("walletId: " + walletId);
          print("userId: " + userId);
          print("isLogin: " + isLogin.toString());

          _localServices.saveWalletId(walletId).then((bool committed) {
            print(walletId);
          });

          _localServices.saveUserId(userId).then((bool committed) {
            print(userId);
          });

          _localServices.isLogin(isLogin).then((bool committed) {
            print(isLogin);
          });

          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Login Gagal",
                      style: TextStyle(color: Colors.green)),
                  content: Text("No HP atau Kata Sandi Salah"),
                  actions: <Widget>[
                    MaterialButton(
                      elevation: 5.0,
                      child: Text("OK", style: TextStyle(color: Colors.green)),
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
    }
  }

  @override
  void initState() {
    super.initState();
    cekLogin();
    _initPackageInfo();
  }

  PackageInfo _packageInfo = PackageInfo(
    version: '0.0.0',
    buildNumber: '0',
  );

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  Widget _modVersion(String version, String bVer) {
   return Text("App Version $version $bVer", style: TextStyle(color: Colors.green),);
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
    print(_obscureText);
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    Widget middleSection = new Expanded(
      child: new Container(
          child: SingleChildScrollView(
        padding: new EdgeInsets.only(
            top: 12.0, left: 12.0, right: 12.0, bottom: bottom),
        child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(height: 70),
              Center(
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 12.0),
                    height: 120.0,
                    width: 230.0,
                    child: Image.asset('lib/src/assets/lapak_sahabat.png')),
              ),
              Container(height: 20),
              Container(
                  child: Text("No HP",
                      style: new TextStyle(fontSize: 14.0),
                      textAlign: TextAlign.start)),
              TextField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(13),
                ],
                controller: _nohpController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Masukkan No HP',
                  errorText:
                      _fieldNohp == null || _fieldNohp ? null : "Wajib diisi",
                ),
                style: new TextStyle(fontSize: 14.0),
                onChanged: (value) {
                  bool isFieldValid = value.trim().isNotEmpty;
                  if (isFieldValid != _fieldNohp) {
                    setState(() => _fieldNohp = isFieldValid);
                  }
                },
                onSubmitted: (value) {
                  login();
                },
              ),
              Container(height: 10),
              Container(
                  child: Text("Kata Sandi",
                      style: new TextStyle(fontSize: 14.0),
                      textAlign: TextAlign.start)),
              TextField(
                controller: _passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      _toggle();
                    },
                  ),
                  hintText: 'Masukkan Kata Sandi',
                  errorText: _fieldPassword == null || _fieldPassword
                      ? null
                      : "Wajib diisi",
                ),
                style: new TextStyle(fontSize: 14.0),
                onChanged: (value) {
                  bool isFieldValid = value.trim().isNotEmpty;
                  if (isFieldValid != _fieldPassword) {
                    setState(() => _fieldPassword = isFieldValid);
                  }
                },
                onSubmitted: (value) {
                  login();
                },
              ),
              Container(height: 10),
              Container(
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
                      login();
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
                          fontSize: 14.0,
                          color: Colors.green,
                        ),
                        textAlign: TextAlign.center)),
                Container(height: 10),
                Divider(
                  height: 12,
                  color: Colors.black54,
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
                        style:
                            new TextStyle(fontSize: 14.0, color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text: " DAFTAR",
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.green)),
                        ]),
                  )),
                )
              ])),
            ]),
      )),
    );

    Widget bottomBanner = new Column(children: <Widget>[
      Center(
          child:_modVersion(_packageInfo.version, _packageInfo.buildNumber)),
      Container(height: 10),
    ]);

    Widget body = new Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        middleSection,
        bottomBanner,
      ],
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Padding(
        padding: new EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
        child: body,
      ),
    );
  }

  _toLanding() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.LandingScreen, (Route<dynamic> route) => false);
  }
}
