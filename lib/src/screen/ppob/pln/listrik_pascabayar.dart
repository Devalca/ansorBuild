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
  String errorText = "";

  bool _isLoading = false;
  bool _fieldNoMeter;
  bool error = true;

  PlnServices _plnServices = PlnServices();

  TextEditingController _noMeterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    pas() async {
      if (_noMeterController.text.isEmpty) {
        setState(() => {error = false, errorText = "Wajib diisi"});
      } else if (_noMeterController.text.length < 12 &&
          _noMeterController.text.length != null) {
        return setState(
            () => {error = false, errorText = "Format Nomor Salah"});
      } else {
        setState(() {
          _isLoading = true;
        });

        String noMeter = _noMeterController.text.toString();

        SharedPreferences prefs = await SharedPreferences.getInstance();
        String walletId = prefs.getString("walletId");
        String userId = prefs.getString("userId");

        print("walletId" + walletId);
        print("userId" + userId);

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
            print("berhasil body: " + response.body);
            print(response.statusCode);

            Map data = jsonDecode(response.body);
            transactionId = data['transactionId'].toString();
            message = data['message'];

            if (message != null) {
              print("message" + message);

              print("response body: " + response.body);
              print(response.statusCode);

              return setState(() => {
                    error = false,
                    errorText = "Nomor tidak terdaftar",
                    _isLoading = false
                  });

              // Navigator.push(
              //     context,
              //     new MaterialPageRoute(
              //         builder: (__) => new PembayaranGagal(
              //             jenis: "pascabayar",
              //             pesan: response.body,
              //             index: 1)));
              // setState(() => _isLoading = false);
            } else if (transactionId != null) {
              print("transactionId: " + transactionId);

              url = '/ppob/pln/' + transactionId;
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
            }
          } else {
            print("error: " + response.body);
            print(response.statusCode);

            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (__) => new PembayaranGagalPln(
                        jenis: "pascabayar", pesan: response.body)));
            setState(() => _isLoading = false);
          }
        });
      }
    }

    Widget middleSection = new Expanded(
      child: new Container(
          child: SingleChildScrollView(
        padding: new EdgeInsets.only(top: 8.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
                child: Text("Nomor Meter/ID Pelanggan",
                    style: new TextStyle(fontSize: 14.0),
                    textAlign: TextAlign.left)),
            TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(12),
                WhitelistingTextInputFormatter.digitsOnly
              ],
              controller: _noMeterController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Contoh: 123456789',
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
              onSubmitted: (value) {
                pas();
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
                child:
                    Text("Keterangan", style: new TextStyle(fontSize: 14.0))),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                        bottomRight: const Radius.circular(10.0))),
                width: double.infinity,
                child: Text(
                    "2. Total tagihan listrik yang tertera sudah termasuk denda (bila ada)",
                    style: new TextStyle(fontSize: 13.0),
                    textAlign: TextAlign.left)),
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
      Container(
        height: 35.0,
        alignment: Alignment.bottomCenter,
        child: Row(
          verticalDirection: VerticalDirection.down,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[],
              ),
            ),
            Container(
              child: SizedBox(
                width: 155,
                height: 35,
                child: RaisedButton(
                  child: Text('LANJUT', style: TextStyle(color: Colors.white)),
                  color: Colors.green,
                  // onPressed: _onPressed,
                  onPressed: () async {
                    pas();
                  },
                ),
              ),
            ),
          ],
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
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Padding(
        padding: new EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
        child: body,
      ),
    );
  }
}
