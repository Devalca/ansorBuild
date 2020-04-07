import 'dart:convert';
import 'package:ansor_build/src/model/bpjs_model.dart';
import 'package:ansor_build/src/routes/routes.dart';
import 'package:ansor_build/src/screen/ppob/bpjs/bpjs_bulan.dart';
import 'package:ansor_build/src/screen/ppob/bpjs/pembayaran_gagal.dart';
import 'package:ansor_build/src/screen/register/register.dart';
import 'package:ansor_build/src/service/bpjs_services.dart';
import 'package:ansor_build/src/service/local_service.dart';
import 'package:ansor_build/src/service/login_services.dart';
import 'package:flutter/material.dart';
import 'package:ansor_build/src/screen/ppob/bpjs/bpjs_pembayaran.dart';

class BpjsKesehatan extends StatefulWidget {
  final String tgl;
  final String nm;
  final String noVa;
  BpjsKesehatan({this.tgl, this.nm, this.noVa});

  @override
  _BpjsKesehatanState createState() => _BpjsKesehatanState();
}

class _BpjsKesehatanState extends State<BpjsKesehatan> {
  @override
  void initState() {
    super.initState();

    print(widget.noVa);

    setState(() {
      _noVAController.text = widget.noVa;
    });
  }

  bool _isLoading = false;
  bool _fieldNoVA;

  String url = "";
  String noVa = "";

  TextEditingController _noVAController = TextEditingController();

  BpjsServices _bpjsServices = BpjsServices();
  LocalService _localServices = LocalService();

  tgl(tgl) {
    return tgl.substring(0, 10);
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    var _onPressed;

    if (widget.tgl != null && widget.nm != null) {
      _onPressed = () {
        setState(() => _isLoading = true);

        if (_noVAController.text.isEmpty) {
          setState(() {
            _isLoading = false;
            _fieldNoVA = true;
          });
        } else {
          String noVa =
              widget.noVa == "" ? _noVAController.text.toString() : widget.noVa;

          PostKesehatan kesehatan =
              PostKesehatan(noVa: noVa, periode: tgl(widget.tgl));

          // PostKesehatan kesehatan = PostKesehatan(noVa: "123456789", periode: "2020-01-01");

          _bpjsServices.postKesehatan(kesehatan).then((response) async {
            if (response.statusCode == 200) {
              // print("berhasil body: " + response.body);
              // print(response.statusCode);

              // Map data = jsonDecode(response.body);
              // transactionId = data['transactionId'].toString();
              // print("transactionId: " + transactionId);

              // url = '/ppob/bpjs/kesehatan/' + transactionId;
              // print("url: " + url);

              // _bpjsServices.saveUrl(url).then((bool committed) {
              //   print(url);
              // });

              // Navigator.push(
              //     context,
              //     new MaterialPageRoute(
              //         builder: (__) => new BpjsPembayaran(jenis: "kesehatan")));
              // setState(() => _isLoading = false);

              print("error: " + response.body);
              print(response.statusCode);

              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (__) => new PembayaranGagal(
                          jenis: "kesehatan", pesan: response.body)));
              setState(() => _isLoading = false);
            } else if (response.statusCode == 302) {
              print("berhasil body: " + response.body);
              print(response.statusCode);

              url = response.headers['location'];
              print("url: " + url);

              _localServices.saveUrl(url).then((bool committed) {
                print(url);
              });

              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (__) =>
                          new BpjsPembayaran(jenis: "kesehatan", url: url)));
              setState(() => _isLoading = false);
            } else {
              print("error: " + response.body);
              print(response.statusCode);

              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (__) => new PembayaranGagal(
                          jenis: "kesehatan", pesan: response.body)));
              setState(() => _isLoading = false);
            }
          });
        }
      };
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            child: Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(
                        width: 150,
                        height: 35,
                        child: RaisedButton(
                          child: Text('LANJUT',
                              style: TextStyle(color: Colors.white)),
                          color: Colors.green,
                          onPressed: _onPressed,
                        ),
                      ),
                    ])),
            elevation: 0),
        body: SingleChildScrollView(
            reverse: true,
            child: Padding(
                padding: EdgeInsets.only(top: 12.0, bottom: bottom),
                child: _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                            Container(
                                child: Text("Nomor VA",
                                    style: new TextStyle(fontSize: 12.0),
                                    textAlign: TextAlign.left)),
                            TextField(
                              controller: _noVAController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                hintText: 'Contoh: 123456789',
                                errorText: _fieldNoVA == null || _fieldNoVA
                                    ? null
                                    : "Kolom Nomor VA harus diisi",
                              ),
                              style: new TextStyle(fontSize: 14.0),
                              onChanged: (value) {
                                bool isFieldValid = value.trim().isNotEmpty;
                                if (isFieldValid != _fieldNoVA) {
                                  setState(() => _fieldNoVA = isFieldValid);
                                }
                              },
                            ),
                            Container(height: 15),
                            Container(
                                child: Text("Bayar Hingga",
                                    style: new TextStyle(fontSize: 12.0),
                                    textAlign: TextAlign.left)),
                            new GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (__) => new BpjsBulan(
                                            jenis: "kesehatan",
                                            noVa: _noVAController.text)));
                              },
                              child: Container(
                                padding: const EdgeInsets.only(top: 10.0),
                                width: double.infinity,
                                height: 40.0,
                                child: Column(
                                  children: <Widget>[
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                                widget.nm == null
                                                    ? "Januari 2020"
                                                    : widget.nm,
                                                style: new TextStyle(
                                                    fontSize: 14.0)),
                                          ),
                                          Container(
                                            child: Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Colors.black,
                                              size: 24.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(height: 12, color: Colors.black),
                            // Container(
                            //     child: Text("Logout",
                            //         style: new TextStyle(fontSize: 12.0),
                            //         textAlign: TextAlign.left)),
                            // new GestureDetector(
                            //   onTap: () {
                            //     walletId = "0";
                            //     userId = "0";
                            //     isLogin = false;

                            //     _localServices
                            //         .saveWalletId(walletId)
                            //         .then((bool committed) {
                            //       print(walletId);
                            //     });

                            //     _localServices
                            //         .saveUserId(userId)
                            //         .then((bool committed) {
                            //       print(userId);
                            //     });

                            //     _localServices
                            //         .isLogin(isLogin)
                            //         .then((bool committed) {
                            //       print(isLogin);
                            //     });

                            //     Navigator.push(
                            //         context,
                            //         new MaterialPageRoute(
                            //             builder: (__) => new RegisterPage()));
                            //   },
                            //   child: Container(
                            //     padding: const EdgeInsets.only(top: 10.0),
                            //     width: double.infinity,
                            //     height: 40.0,
                            //     child: Column(
                            //       children: <Widget>[
                            //         Expanded(
                            //           child: Row(
                            //             mainAxisAlignment:
                            //                 MainAxisAlignment.spaceBetween,
                            //             children: <Widget>[
                            //               Container(
                            //                 child: Text("Logout",
                            //                     style: new TextStyle(
                            //                         fontSize: 14.0)),
                            //               ),
                            //               Container(
                            //                 child: Icon(
                            //                   Icons.keyboard_arrow_down,
                            //                   color: Colors.black,
                            //                   size: 24.0,
                            //                 ),
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          ]))));
  }
}
