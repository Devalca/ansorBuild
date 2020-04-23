import 'dart:convert';
import 'package:ansor_build/src/screen/ppob/pln/pembayaran_gagal.dart';
import 'package:flutter/material.dart';
import 'package:ansor_build/src/model/pln_model.dart';
import 'package:ansor_build/src/service/pln_services.dart';
import 'package:ansor_build/src/screen/ppob/pln/listrik_pembayaran.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListrikPrabayar extends StatefulWidget {
  @override
  _ListrikPrabayarState createState() => _ListrikPrabayarState();
}

class _ListrikPrabayarState extends State<ListrikPrabayar> {
  bool _fieldNoMeter = true;
  PlnServices _plnServices = PlnServices();
  String url = "";
  int total = 0;
  bool press1 = false;
  bool press2 = false;
  bool press3 = false;
  bool press4 = false;
  bool press5 = false;
  bool press6 = false;
  bool error = true;
  bool stotal = false;

  String nominal = "";
  String errorText = "";

  TextEditingController _noMeterController = TextEditingController();
  TextEditingController _nominalController = TextEditingController();

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    Widget middleSection = new Expanded(
      child: new Container(
        padding: new EdgeInsets.only(top: 8.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text("Nomor Meter/ID Pelanggan",
                style: new TextStyle(fontSize: 14.0)),
            TextFormField(
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
            ),
            Container(height: 14),
            Text("Nominal Token", style: new TextStyle(fontSize: 14.0)),
            Container(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new GestureDetector(
                    onTap: () {
                      setState(() {
                        this.press1 = !press1;
                        this.press2 = false;
                        this.press3 = false;
                        this.press4 = false;
                        this.press5 = false;
                        this.press6 = false;
                        this.total = 21500;
                        this.nominal = "20000";
                        this.stotal = true;
                      });
                    },
                    child: new Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius:
                                new BorderRadius.all(Radius.circular(10.0)),
                            border: Border.all(
                                color: press1 ? Colors.green : Colors.grey[300],
                                width: 1)),
                        width: 158,
                        padding: const EdgeInsets.all(10.0),
                        child: SingleChildScrollView(
                            child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text("20.000",
                                style: TextStyle(
                                    fontSize: 18,
                                    color:
                                        press1 ? Colors.green : Colors.black)),
                            new Text(
                                NumberFormat.simpleCurrency(
                                        locale: 'id', decimalDigits: 0)
                                    .format(21500),
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 12)),
                          ],
                        )))),
                new GestureDetector(
                    onTap: () {
                      setState(() {
                        this.press2 = !press2;
                        this.press1 = false;
                        this.press3 = false;
                        this.press4 = false;
                        this.press5 = false;
                        this.press6 = false;
                        this.total = 51500;
                        this.nominal = "50000";
                        this.stotal = true;
                      });
                    },
                    child: new Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius:
                                new BorderRadius.all(Radius.circular(10.0)),
                            border: Border.all(
                                color: press2 ? Colors.green : Colors.grey[300],
                                width: 1)),
                        width: 158,
                        padding: const EdgeInsets.all(10.0),
                        child: SingleChildScrollView(
                            child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text("50.000",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 18,
                                    color:
                                        press2 ? Colors.green : Colors.black)),
                            new Text(
                                NumberFormat.simpleCurrency(
                                        locale: 'id', decimalDigits: 0)
                                    .format(51500),
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 12)),
                          ],
                        )))),
              ],
            ),
            Container(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new GestureDetector(
                    onTap: () {
                      setState(() {
                        this.press3 = !press3;
                        this.press1 = false;
                        this.press2 = false;
                        this.press4 = false;
                        this.press5 = false;
                        this.press6 = false;
                        this.total = 101500;
                        this.nominal = "100000";
                        this.stotal = true;
                      });
                    },
                    child: new Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius:
                                new BorderRadius.all(Radius.circular(10.0)),
                            border: Border.all(
                                color: press3 ? Colors.green : Colors.grey[300],
                                width: 1)),
                        width: 158,
                        padding: const EdgeInsets.all(10.0),
                        child: SingleChildScrollView(
                            child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text("100.000",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 18,
                                    color:
                                        press3 ? Colors.green : Colors.black)),
                            new Text(
                                NumberFormat.simpleCurrency(
                                        locale: 'id', decimalDigits: 0)
                                    .format(101500),
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 12)),
                          ],
                        )))),
                new GestureDetector(
                    onTap: () {
                      setState(() {
                        this.press4 = !press4;
                        this.press1 = false;
                        this.press2 = false;
                        this.press3 = false;
                        this.press5 = false;
                        this.press6 = false;
                        this.total = 251500;
                        this.nominal = "250000";
                        this.stotal = true;
                      });
                    },
                    child: new Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius:
                                new BorderRadius.all(Radius.circular(10.0)),
                            border: Border.all(
                                color: press4 ? Colors.green : Colors.grey[300],
                                width: 1)),
                        width: 158,
                        padding: const EdgeInsets.all(10.0),
                        child: SingleChildScrollView(
                            child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text("250.000",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 18,
                                    color:
                                        press4 ? Colors.green : Colors.black)),
                            new Text(
                                NumberFormat.simpleCurrency(
                                        locale: 'id', decimalDigits: 0)
                                    .format(251500),
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 12)),
                          ],
                        )))),
              ],
            ),
            Container(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new GestureDetector(
                    onTap: () {
                      setState(() {
                        this.press5 = !press5;
                        this.press1 = false;
                        this.press2 = false;
                        this.press3 = false;
                        this.press4 = false;
                        this.press6 = false;
                        this.total = 501500;
                        this.nominal = "500000";
                        this.stotal = true;
                      });
                    },
                    child: new Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius:
                                new BorderRadius.all(Radius.circular(10.0)),
                            border: Border.all(
                                color: press5 ? Colors.green : Colors.grey[300],
                                width: 1)),
                        width: 158,
                        padding: const EdgeInsets.all(10.0),
                        child: SingleChildScrollView(
                            child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text("500.000",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 18,
                                    color:
                                        press5 ? Colors.green : Colors.black)),
                            new Text(
                                NumberFormat.simpleCurrency(
                                        locale: 'id', decimalDigits: 0)
                                    .format(501500),
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 12)),
                          ],
                        )))),
                new GestureDetector(
                    onTap: () {
                      setState(() {
                        this.press6 = !press6;
                        this.press1 = false;
                        this.press2 = false;
                        this.press3 = false;
                        this.press4 = false;
                        this.press5 = false;
                        this.total = 1001500;
                        this.nominal = "1000000";
                        this.stotal = true;
                      });
                    },
                    child: new Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius:
                                new BorderRadius.all(Radius.circular(10.0)),
                            border: Border.all(
                                color: press6 ? Colors.green : Colors.grey[300],
                                width: 1)),
                        width: 158,
                        padding: const EdgeInsets.all(10.0),
                        child: SingleChildScrollView(
                            child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text("1.000.000",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 18,
                                    color:
                                        press6 ? Colors.green : Colors.black)),
                            new Text(
                                NumberFormat.simpleCurrency(
                                        locale: 'id', decimalDigits: 0)
                                    .format(1001500),
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 12)),
                          ],
                        )))),
              ],
            ),
          ],
        ),
      ),
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
                children: <Widget>[
                  new Text("Total",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 12)),
                  press1 || press2 || press3 || press4 || press5 || press6
                      ? new Text(
                          NumberFormat.simpleCurrency(
                                  locale: 'id', decimalDigits: 0)
                              .format(total),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold))
                      : new Text(
                          NumberFormat.simpleCurrency(
                                  locale: 'id', decimalDigits: 0)
                              .format(0),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                ],
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
                    if (_noMeterController.text.isEmpty && stotal == false) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Transaksi Gagal",
                                  style: TextStyle(color: Colors.green)),
                              content: Text(
                                  "Nomor Meter dan Nominal Token Wajib diisi"),
                              actions: <Widget>[
                                MaterialButton(
                                  elevation: 5.0,
                                  child: Text("OK",
                                      style: TextStyle(color: Colors.green)),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          });
                    } else if (_noMeterController.text.isEmpty) {
                      setState(
                          () => {error = false, errorText = "Wajib diisi"});
                    } else if (press1 == false &&
                        press2 == false &&
                        press3 == false &&
                        press4 == false &&
                        press5 == false &&
                        press6 == false) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Transaksi Gagal",
                                  style: TextStyle(color: Colors.green)),
                              content: Text("Silahkan Pilih Nominal"),
                              actions: <Widget>[
                                MaterialButton(
                                  elevation: 5.0,
                                  child: Text("OK",
                                      style: TextStyle(color: Colors.green)),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          });
                    } else if (_noMeterController.text.length < 12 &&
                        _noMeterController.text.length != null) {
                      return setState(() =>
                          {error = false, errorText = "Format Nomor Salah"});
                    } else {
                      setState(() => _isLoading = true);
                      String noMeter = _noMeterController.text.toString();
                      // String nominal = this.nominal;
                      // String nominal = _nominalController.text.toString();

                      PostPrabayar prabayar =
                          PostPrabayar(noMeter: noMeter, nominal: nominal);

                      _plnServices
                          .postPrabayar(prabayar)
                          .then((response) async {
                        if (response.statusCode == 302) {
                          print("berhasil body: " + response.body);
                          print(response.statusCode);

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
                                  builder: (__) => new ListrikPembayaran(
                                      status: "prabayar", index: 0)));
                          setState(() => _isLoading = false);
                        } else if (response.statusCode == 200) {
                          // print("berhasil body: " + response.body);
                          // print(response.statusCode);

                          // Map data = jsonDecode(response.body);
                          // transactionId = data['id'].toString();
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
                          //             new ListrikPembayaran(status: "prabayar")));
                          // setState(() => _isLoading = false);

                          print("error: " + response.body);
                          print(response.statusCode);

                          // Navigator.push(
                          //     context,
                          //     new MaterialPageRoute(
                          //         builder: (__) => new PembayaranGagal(
                          //             jenis: "prabayar",
                          //             pesan: response.body)));
                          // setState(() => _isLoading = false);

                          return setState(() => {
                                error = false,
                                errorText = "Nomor tidak terdaftar",
                                _isLoading = false
                              });
                        } else {
                          print("error: " + response.body);
                          print(response.statusCode);

                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (__) => new PembayaranGagal(
                                      jenis: "prabayar",
                                      pesan: response.body)));
                          setState(() => _isLoading = false);
                        }
                      });
                    }
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
