import 'dart:convert';
import 'package:ansor_build/src/screen/ppob/pln/pembayaran_gagal.dart';
import 'package:flutter/material.dart';
import 'package:ansor_build/src/screen/ppob/pln/listrik_pembayaran.dart';
import 'package:ansor_build/src/service/pln_services.dart';
import 'package:ansor_build/src/model/pln_model.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListrikPascabayar extends StatefulWidget {
  @override
  _ListrikPascabayarState createState() => _ListrikPascabayarState();
}

class _ListrikPascabayarState extends State<ListrikPascabayar> {
  String url = "";

  bool _isLoading = false;
  bool _fieldNoMeter;

  PlnServices _plnServices = PlnServices();

  TextEditingController _noMeterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    var _onPressed;

    if (_noMeterController.text.isNotEmpty) {
      _onPressed = () async {
        setState(() {
          _isLoading = true;
        });

        String noMeter = _noMeterController.text.toString();

        SharedPreferences prefs = await SharedPreferences.getInstance();
        String walletId = prefs.getString("walletId");
        String userId = prefs.getString("userId");

        PostPascabayar pascabayar = PostPascabayar(
            noMeter: noMeter, userId: userId, walletId: walletId);

        _plnServices.postPascabayar(pascabayar).then((response) async {
          if (response.statusCode == 302) {
            print("berhasil body: " + response.body);
            print(response.statusCode);

            url = response.headers['location'];
            print("url: " + url);

            _plnServices.saveTransactionId(url).then((bool committed) {
              print(url);
            });

            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (__) =>
                        new ListrikPembayaran(status: "pascabayar")));
            setState(() => _isLoading = false);
          } else if (response.statusCode == 200) {
            // print("berhasil body: " + response.body);
            // print(response.statusCode);

            // Map data = jsonDecode(response.body);
            // transactionId = data['transactionId'].toString();
            // print("transactionId: " + transactionId);

            // url = '/ppob/pln/' + transactionId;
            // print("url: " + url);

            // _plnServices.saveTransactionId(url).then((bool committed) {
            //   print(url);
            // });

            // Navigator.push(
            //     context,
            //     new MaterialPageRoute(
            //         builder: (__) =>
            //             new ListrikPembayaran(status: "pascabayar")));
            // setState(() => _isLoading = false);

            print("error: " + response.body);
            print(response.statusCode);

            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (__) => new PembayaranGagal(
                        jenis: "pascabayar", pesan: response.body, index: 1)));
            setState(() => _isLoading = false);
          } else {
            print("error: " + response.body);
            print(response.statusCode);

            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (__) => new PembayaranGagal(
                        jenis: "pascabayar", pesan: response.body)));
            setState(() => _isLoading = false);
          }
        });
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
                                child: Text("Nomor Meter/ID Pelanggan",
                                    style: new TextStyle(fontSize: 14.0),
                                    textAlign: TextAlign.left)),
                            TextField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(13),
                              ],
                              controller: _noMeterController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                hintText: 'Contoh: 123456789',
                                errorText:
                                    _fieldNoMeter == null || _fieldNoMeter
                                        ? null
                                        : "Kolom Nomor Meter harus diisi",
                              ),
                              style: new TextStyle(fontSize: 14.0),
                              onChanged: (value) {
                                bool isFieldValid = value.trim().isNotEmpty;
                                if (isFieldValid != _fieldNoMeter) {
                                  setState(() => _fieldNoMeter = isFieldValid);
                                }
                              },
                            ),
                            Container(height: 15),
                            Container(
                                padding: const EdgeInsets.all((10.0)),
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    shape: BoxShape.rectangle,
                                    borderRadius: new BorderRadius.only(
                                        topLeft: const Radius.circular(10.0),
                                        topRight: const Radius.circular(10.0))),
                                width: double.infinity,
                                child: Text("Keterangan",
                                    style: new TextStyle(fontSize: 14.0))),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              width: double.infinity,
                              color: Colors.grey[300],
                              child: Text(
                                "1. Pembayaran tagihan listrik dapat dilakukan pada pukul 23.45 - 00.30 sesuai dengan ketentuan PLN",
                                style: new TextStyle(fontSize: 13.0),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                                padding: const EdgeInsets.only(
                                    left: 10.0, bottom: 10.0, right: 10.0),
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    shape: BoxShape.rectangle,
                                    borderRadius: new BorderRadius.only(
                                        bottomLeft: const Radius.circular(10.0),
                                        bottomRight:
                                            const Radius.circular(10.0))),
                                width: double.infinity,
                                child: Text(
                                    "2. Total tagihan listrik yang tertera sudah termasuk denda (bila ada)",
                                    style: new TextStyle(fontSize: 13.0),
                                    textAlign: TextAlign.left)),
                            // Container(height: 260),
                            // Divider(
                            //   height: 12,
                            //   color: Colors.black,
                            // ),
                            // SizedBox(
                            //   width: double.infinity,
                            //   height: 35,
                            //   child: RaisedButton(
                            //     child: Text('LANJUT',
                            //         style: TextStyle(color: Colors.white)),
                            //     color: Colors.green,
                            //     onPressed: () {
                            //       setState(() {
                            //         _isLoading = true;
                            //       });

                            //       if (_noMeterController.text.isEmpty) {
                            //         setState(() {
                            //           _isLoading = false;
                            //           _fieldNoMeter = false;
                            //         });
                            //       } else {
                            //         String noMeter =
                            //             _noMeterController.text.toString();

                            //         PostPascabayar pascabayar = PostPascabayar(
                            //             noMeter: noMeter,
                            //             userId: 1,
                            //             walletId: 1);

                            //         _plnServices
                            //             .postPascabayar(pascabayar)
                            //             .then((response) async {
                            //           if (response.statusCode == 302) {
                            //             print(
                            //                 "berhasil body: " + response.body);
                            //             print(response.statusCode);

                            //             url = response.headers['location'];
                            //             print("url: " + url);

                            //             _plnServices
                            //                 .saveTransactionId(url)
                            //                 .then((bool committed) {
                            //               print(url);
                            //             });

                            //             Navigator.push(
                            //                 context,
                            //                 new MaterialPageRoute(
                            //                     builder: (__) =>
                            //                         new ListrikPembayaran(
                            //                             status: "pascabayar")));
                            //             setState(() => _isLoading = false);
                            //           } else if (response.statusCode == 200) {
                            //             print(
                            //                 "berhasil body: " + response.body);
                            //             print(response.statusCode);

                            //             Map data = jsonDecode(response.body);
                            //             transactionId =
                            //                 data['transactionId'].toString();
                            //             print(
                            //                 "transactionId: " + transactionId);

                            //             url = '/ppob/pln/' + transactionId;
                            //             print("url: " + url);

                            //             _plnServices
                            //                 .saveTransactionId(url)
                            //                 .then((bool committed) {
                            //               print(url);
                            //             });

                            //             Navigator.push(
                            //                 context,
                            //                 new MaterialPageRoute(
                            //                     builder: (__) =>
                            //                         new ListrikPembayaran(
                            //                             status: "pascabayar")));
                            //             setState(() => _isLoading = false);
                            //           } else {
                            //             print("error: " + response.body);
                            //             print(response.statusCode);

                            //             Navigator.push(
                            //                 context,
                            //                 new MaterialPageRoute(
                            //                     builder: (__) =>
                            //                         new PembayaranGagal(
                            //                             jenis: "pascabayar",
                            //                             pesan: response.body)));
                            //             setState(() => _isLoading = false);
                            //           }
                            //         });
                            //       }
                            //     },
                            //   ),
                            // ),
                          ]))));
  }
}
