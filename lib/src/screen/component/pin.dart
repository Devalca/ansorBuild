import 'dart:convert';

import 'package:ansor_build/src/model/bpjs_model.dart';
import 'package:ansor_build/src/model/login_model.dart';
import 'package:ansor_build/src/model/pln_model.dart';
import 'package:ansor_build/src/routes/routes.dart';
import 'package:ansor_build/src/screen/ppob/bpjs/pembayaran_berhasil.dart';
import 'package:ansor_build/src/screen/ppob/bpjs/pembayaran_gagal.dart';
import 'package:ansor_build/src/screen/ppob/pln/pembayaran_berhasil.dart';
import 'package:ansor_build/src/screen/ppob/pln/pembayaran_gagal.dart';
import 'package:ansor_build/src/service/bpjs_services.dart';
import 'package:ansor_build/src/service/local_service.dart';
import 'package:ansor_build/src/service/login_services.dart';
import 'package:ansor_build/src/service/pln_services.dart';
import 'package:flutter/material.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pin extends StatefulWidget {
  final int periodeByr, nominal;
  final String statusbyr,
      transactionId,
      noVa,
      periode,
      jenis,
      noKtp,
      id,
      noMeter,
      status;
  Pin(
      {this.statusbyr,
      this.transactionId,
      this.noVa,
      this.periode,
      this.jenis,
      this.periodeByr,
      this.noKtp,
      this.id,
      this.noMeter,
      this.nominal,
      this.status});

  @override
  _PinState createState() => _PinState();
}

class _PinState extends State<Pin> {
  bool _isLoading = false;
  String url = "";
  String transactionId = "";
  LoginServices _loginServices = LoginServices();
  LocalService _localServices = LocalService();
  BpjsServices _bpjsServices = BpjsServices();
  PlnServices _plnServices = PlnServices();
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
                            Container(height: 50),
                            PinEntryTextField(
                              fields: 6,
                              onSubmit: (String pin) async {
                                if (widget.statusbyr == "login" ||
                                    widget.statusbyr == null) {
                                  SharedPreferences pref =
                                      await SharedPreferences.getInstance();
                                  String noHp = pref.getString('noHp');

                                  print("no hp: " + noHp);
                                  print("pin: " + pin);

                                  LoginPin loginPin =
                                      LoginPin(noHp: noHp, pin: int.parse(pin));

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
                                          .savePin(pin)
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
                                      String message =
                                          data["message"].toString();

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
                                          .savePin(pin)
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
                                } else if (pin == 000000) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("Pin Gagal",
                                              style: TextStyle(
                                                  color: Colors.green)),
                                          content: Text(
                                              "Anda belum mengatur pin Anda. Silahkan registrasi ulang"),
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
                                } else if (widget.statusbyr ==
                                    "bpjskesehatan") {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  String walletId = prefs.getString("walletId");
                                  String userId = prefs.getString("userId");

                                  print(
                                      "transactionId " + widget.transactionId);
                                  print("noVa " + widget.noVa);
                                  print("periode " + widget.periode);
                                  print("userId " + userId);
                                  print("walletId " + walletId);

                                  PostPembayaran pembayaran = PostPembayaran(
                                      userId: userId,
                                      walletId: walletId,
                                      transactionId: widget.transactionId,
                                      noVa: widget.noVa,
                                      periode: widget.periode,
                                      pin: int.parse(pin));

                                  _bpjsServices
                                      .postPembayaran(pembayaran)
                                      .then((response) async {
                                    if (response.statusCode == 200) {
                                      print("berhasil body: " + response.body);
                                      print(response.statusCode);

                                      Map data = jsonDecode(response.body);
                                      transactionId =
                                          data['transactionId'].toString();
                                      print("transactionId: " + transactionId);

                                      url = '/ppob/bpjs/detail/kesehatan/' +
                                          transactionId;
                                      print("url: " + url);

                                      _localServices
                                          .saveUrl(url)
                                          .then((bool committed) {
                                        print(url);
                                      });

                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (__) =>
                                                  new PembayaranBerhasilBpjs(
                                                      jenis: widget.jenis)));
                                      setState(() => _isLoading = false);
                                    } else if (response.statusCode == 302) {
                                      print("berhasil body: " + response.body);
                                      print(response.statusCode);

                                      url = response.headers['location'];
                                      print("url: " + url);

                                      _localServices
                                          .saveUrl(url)
                                          .then((bool committed) {
                                        print(url);
                                      });

                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (__) =>
                                                  new PembayaranBerhasilBpjs(
                                                      jenis: widget.jenis)));
                                      setState(() => _isLoading = false);
                                    } else if (response.statusCode == 422) {
                                      setState(() => _isLoading = true);
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
                                    } else {
                                      print("error: " + response.body);
                                      print(response.statusCode);

                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (__) =>
                                                  new PembayaranGagalBpjs(
                                                      jenis: "kesehatan",
                                                      index: 0)));
                                      setState(() => _isLoading = false);
                                    }
                                  });
                                } else if (widget.statusbyr ==
                                    "bpjsketenagakerjaan") {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  String walletId = prefs.getString("walletId");
                                  String userId = prefs.getString("userId");

                                  print("periodeByr " +
                                      widget.periodeByr.toString());
                                  print("noKtp " + widget.noKtp);
                                  print("userId " + userId);
                                  print("walletId " + walletId);
                                  print(
                                      "transactionId " + widget.transactionId);

                                  PostBayarKerja bayarKerja = PostBayarKerja(
                                      periodeByr: widget.periodeByr,
                                      noKtp: widget.noKtp,
                                      userId: userId,
                                      walletId: walletId,
                                      transactionId: widget.transactionId,
                                      pin: int.parse(pin));

                                  _bpjsServices
                                      .postBayarKerja(bayarKerja)
                                      .then((response) async {
                                    if (response.statusCode == 200) {
                                      print("berhasil body: " + response.body);
                                      print(response.statusCode);

                                      Map data = jsonDecode(response.body);
                                      transactionId =
                                          data['transactionId'].toString();
                                      print("transactionId: " + transactionId);

                                      url = '/ppob/bpjs/detail/kesehatan/' +
                                          transactionId;
                                      print("url: " + url);

                                      _localServices
                                          .saveUrl(url)
                                          .then((bool committed) {
                                        print(url);
                                      });

                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (__) =>
                                                  new PembayaranBerhasilBpjs(
                                                      jenis: widget.jenis)));
                                      setState(() => _isLoading = false);
                                    } else if (response.statusCode == 302) {
                                      print("berhasil body: " + response.body);
                                      print(response.statusCode);

                                      url = response.headers['location'];
                                      print("url: " + url);

                                      _localServices
                                          .saveUrl(url)
                                          .then((bool committed) {
                                        print(url);
                                      });

                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (__) =>
                                                  new PembayaranBerhasilBpjs(
                                                      jenis: widget.jenis)));
                                      setState(() => _isLoading = false);
                                    } else if (response.statusCode == 422) {
                                      setState(() => _isLoading = true);
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
                                    } else {
                                      print("error: " + response.body);
                                      print(response.statusCode);

                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (__) =>
                                                  new PembayaranGagalBpjs(
                                                      jenis: "kesehatan",
                                                      index: 0)));
                                      setState(() => _isLoading = false);
                                    }
                                  });
                                } else if (widget.statusbyr == "pln") {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  String walletId = prefs.getString("walletId");
                                  String userId = prefs.getString("userId");

                                  print(
                                      "transactionId: " + widget.transactionId);
                                  print("noMeter: " + widget.noMeter);
                                  print("walletId: " + walletId);
                                  print("userId: " + userId);

                                  PostPascaTransaction pascaTransaction =
                                      PostPascaTransaction(
                                          noMeter: widget.noMeter,
                                          transactionId: widget.transactionId,
                                          userId: userId,
                                          walletId: walletId,
                                          pin: int.parse(pin));

                                  PostPraTransaction praTransaction =
                                      PostPraTransaction(
                                          noMeter: widget.noMeter,
                                          nominal: widget.nominal,
                                          transactionId: widget.transactionId,
                                          userId: userId,
                                          walletId: walletId,
                                          pin: int.parse(pin));

                                  if (widget.status == "pascabayar") {
                                    _plnServices
                                        .postPascaTransaction(pascaTransaction)
                                        .then((response) async {
                                      print(response.statusCode);
                                      if (response.statusCode == 302) {
                                        print('Berhasil');
                                        url = response.headers['location'];
                                        print("url: " + url);

                                        _plnServices
                                            .saveTransactionId(url)
                                            .then((bool committed) {
                                          print(url);
                                        });

                                        Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (__) =>
                                                    new PembayaranBerhasilPln(
                                                        status:
                                                            widget.status)));
                                        setState(() => _isLoading = false);
                                      } else if (response.statusCode == 200) {
                                        print('Berhasil');

                                        Map data = jsonDecode(response.body);
                                        id = data['id'].toString();
                                        url = '/ppob/detail/pln/' + id;
                                        print("url: " + url);

                                        _plnServices
                                            .saveTransactionId(url)
                                            .then((bool committed) {
                                          print(url);
                                        });

                                        Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (__) =>
                                                    new PembayaranBerhasilPln(
                                                        status:
                                                            widget.status)));
                                        setState(() => _isLoading = false);
                                      } else {
                                        print("Gagal");
                                        print(response.statusCode);

                                        Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (__) =>
                                                    new PembayaranGagalPln()));
                                        setState(() => _isLoading = false);
                                      }
                                    });
                                  } else {
                                    _plnServices
                                        .postPraTransaction(praTransaction)
                                        .then((response) async {
                                      print(response.statusCode);
                                      if (response.statusCode == 302) {
                                        print('Berhasil');
                                        url = response.headers['location'];
                                        print("url: " + url);

                                        _plnServices
                                            .saveTransactionId(url)
                                            .then((bool committed) {
                                          print(url);
                                        });

                                        Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (__) =>
                                                    new PembayaranBerhasilPln(
                                                        status:
                                                            widget.status)));
                                        setState(() => _isLoading = false);
                                      } else if (response.statusCode == 200) {
                                        print('Berhasil');

                                        Map data = jsonDecode(response.body);
                                        id = data['id'].toString();
                                        url = '/ppob/detail/pln/' + id;
                                        print("url: " + url);

                                        _plnServices
                                            .saveTransactionId(url)
                                            .then((bool committed) {
                                          print(url);
                                        });

                                        Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (__) =>
                                                    new PembayaranBerhasilPln(
                                                        status:
                                                            widget.status)));
                                        setState(() => _isLoading = false);
                                      } else {
                                        print("Gagal");
                                        print(response.statusCode);

                                        Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (__) =>
                                                    new PembayaranGagalPln()));
                                        setState(() => _isLoading = false);
                                      }
                                    });
                                  }
                                }
                              },
                            ),
                          ]))));
  }

  _toLanding() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.LandingScreen, (Route<dynamic> route) => false);
  }
}
