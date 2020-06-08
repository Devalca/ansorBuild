import 'dart:convert';

import 'package:ansor_build/src/model/transfer_model.dart';
import 'package:ansor_build/src/model/wallet_model.dart';
import 'package:ansor_build/src/screen/component/kontak.dart';
import 'package:ansor_build/src/screen/transfer/detailTransfer.dart';
import 'package:ansor_build/src/screen/transfer/transfer.dart';
import 'package:ansor_build/src/service/local_service.dart';
import 'package:ansor_build/src/service/transfer_service.dart';
import 'package:ansor_build/src/service/wallet_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ansor_build/src/service/permissions_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Kesesama extends StatefulWidget {
  @override
  _KesesamaState createState() => _KesesamaState();
}

class _KesesamaState extends State<Kesesama> {
  bool error = true;
  int saldo = 0;
  String errorTextphone = "";
  String errorTextnominal = "";
  String url = "";
  TextEditingController _noPonselController = TextEditingController();
  TextEditingController _nominalController = TextEditingController();

  WalletService _walletService = WalletService();
  TransferServices _transferServices = TransferServices();
  LocalService _localServices = LocalService();

  @override
  Widget build(BuildContext context) {
    kes() async {
      if (_noPonselController.text.isEmpty) {
        setState(() => {error = false, errorTextphone = "Wajib diisi"});
      } else if (_nominalController.text.isEmpty) {
        setState(() => {error = false, errorTextnominal = "Wajib diisi"});
      } else {
        String no_penerima = _noPonselController.text;
        int nominal_trf = int.parse(_nominalController.text);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        String walletId = prefs.getString("walletId");
        String userId = prefs.getString("userId");

        print("walletId: " + walletId);
        print("userId: " + userId);
        print("no_penerima: " + no_penerima.toString());
        print("nominal_trf: " + nominal_trf.toString());

        PostSesama sesama = PostSesama(
            no_penerima: no_penerima,
            nominal_trf: nominal_trf,
            userId: userId,
            walletId: walletId);

        _transferServices.postSesama(sesama).then((response) async {
          if (response.statusCode == 302) {
            print("berhasil body: " + response.body);
            print(response.statusCode);

            url = response.headers['location'];
            print("url: " + url);

            String id = url.substring(17);
            print("id: " + id);

            _localServices.saveTransferId(id).then((bool committed) {
              print(id);
            });

            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (__) => new DetailTransfer(url: url)));
          } else {
            print("error: " + response.body);
            print(response.statusCode);

            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Tranfer Gagal",
                        style: TextStyle(color: Colors.green)),
                    // content: Text(
                    //     "Anda Belum melakukan aktivasi. Lakukan verifikasi email"),
                    actions: <Widget>[
                      MaterialButton(
                        elevation: 5.0,
                        child:
                            Text("OK", style: TextStyle(color: Colors.green)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  );
                });
          }
        });
      }
    }

    Widget middleSection = Expanded(
      child: new Container(
          color: Colors.white,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                    child: Text("Nomor Ponsel",
                        style: new TextStyle(fontSize: 12.0),
                        textAlign: TextAlign.left)),
                TextField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(13),
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  controller: _noPonselController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Contoh: 123456789',
                    errorText: error ? null : errorTextphone,
                    suffixIcon: IconButton(
                      icon: Icon(Icons.contact_phone),
                      onPressed: () async {
                        final PermissionStatus permissionStatus =
                            await PermissionsService().getPermissionContact();
                        if (permissionStatus == PermissionStatus.granted) {
                          final nomor = await Navigator.push(
                            context,
                            CupertinoPageRoute(
                                fullscreenDialog: true,
                                builder: (context) => ContactsPage()),
                          );
                          setState(() {
                            if (nomor != null) {
                              _noPonselController.text = nomor
                                  .toString()
                                  .replaceAll("+62", "0")
                                  .replaceAll("-", "")
                                  .replaceAll(" ", "");
                            }
                          });
                        } else {
                          PermissionsService().requestContactsPermission(
                              onPermissionDenied: () {
                            print('Permission has been denied');
                          });
                        }
                      },
                    ),
                  ),
                  style: new TextStyle(fontSize: 14.0),
                  onChanged: (value) {
                    if (value.length == 0) {
                      return setState(() =>
                          {error = false, errorTextphone = "Wajib diisi"});
                    } else {
                      return setState(() => error = true);
                    }
                  },
                  onSubmitted: (value) {
                    kes();
                  },
                ),
                Container(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  width: double.infinity,
                  height: 50.0,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      border: Border.all(color: Colors.grey[300], width: 1)),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Icon(
                                    Icons.account_balance_wallet,
                                    color: Colors.green,
                                    size: 24.0,
                                  ),
                                  Text(
                                    " Saldo Un1ty",
                                    style: new TextStyle(
                                      color: Colors.green,
                                      fontSize: 12.0,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                child: FutureBuilder<Wallet>(
                              future: _walletService.getSaldo(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  saldo = snapshot.data.data[0].saldoAkhir;
                                  return Text(NumberFormat.simpleCurrency(
                                          locale: 'id', decimalDigits: 0)
                                      .format(
                                          snapshot.data.data[0].saldoAkhir));
                                } else if (snapshot.hasError) {
                                  return Text("${snapshot.error}");
                                }
                                return CircularProgressIndicator();
                              },
                            )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(height: 10),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      border: Border.all(color: Colors.grey[300], width: 1)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        "Masukkan Nominal",
                        style: new TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      TextField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(13),
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        controller: _nominalController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: 'Rp 16.000',
                          errorText: error ? null : errorTextnominal,
                        ),
                        style: new TextStyle(fontSize: 14.0),
                        onChanged: (value) {
                          if (value.length == 0) {
                            return setState(() => {
                                  error = false,
                                  errorTextnominal = "Wajib diisi"
                                });
                          } else {
                            return setState(() => error = true);
                          }
                        },
                        onSubmitted: (value) {
                          kes();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );

    Widget bottomBanner = new Column(children: <Widget>[
      Divider(
        height: 12,
        color: Colors.black26,
      ),
      Container(height: 5),
      Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
        child: SizedBox(
          width: double.infinity,
          height: 35,
          child: RaisedButton(
            child: Text('LANJUT', style: TextStyle(color: Colors.white)),
            color: Colors.green,
            onPressed: () async {
              kes();
            },
          ),
        ),
      ),
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
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (__) => new Transfer()));
              }),
          title: Text(
            "Ke Sesama Unity",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0),
      body: Padding(
        padding: new EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
        child: body,
      ),
    );
  }
}
