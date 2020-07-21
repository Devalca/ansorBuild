import 'dart:convert';
import 'package:ansor_build/src/screen/ppob/bpjs/bpjs_bulan.dart';
import 'package:ansor_build/src/screen/ppob/bpjs/pembayaran_gagal.dart';
import 'package:ansor_build/src/service/bpjs_services.dart';
import 'package:ansor_build/src/service/local_service.dart';
import 'package:flutter/material.dart';
import 'package:ansor_build/src/screen/ppob/bpjs/bpjs_pembayaran.dart';
import 'package:ansor_build/src/model/bpjs_model.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BpjsKetenagakerjaan extends StatefulWidget {
  final String bln;
  final String noKtp;
  final int periode;
  BpjsKetenagakerjaan({this.bln, this.periode, this.noKtp});

  @override
  _BpjsKetenagakerjaanState createState() => _BpjsKetenagakerjaanState();
}

class _BpjsKetenagakerjaanState extends State<BpjsKetenagakerjaan> {
  @override
  void initState() {
    super.initState();

    print(widget.noKtp);

    setState(() {
      _noKTPController.text = widget.noKtp;
    });
  }

  bool _isLoading = false;
  bool _fieldNoKTP;
  bool error = true;
  bool errorBulan = true;

  String url = "";
  String errorText = "";

  TextEditingController _noKTPController = TextEditingController();

  BpjsServices _bpjsServices = BpjsServices();
  LocalService _localServices = LocalService();

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    var _onPressed;

    ket() async {
      if (_noKTPController.text.isEmpty) {
        setState(() => {error = false, errorText = "Wajib diisi"});
      } else if (_noKTPController.text.length < 16) {
        setState(() => {error = false, errorText = "Format Nomor Salah"});
      } else if (widget.bln == null) {
        // setState(() => errorBulan = false);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Transaksi Gagal",
                    style: TextStyle(color: Colors.green)),
                content: Text("Silahkan pilih bulan pembayaran"),
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
      } else {
        setState(() => _isLoading = true);

        if (_noKTPController.text.isEmpty) {
          setState(() {
            _isLoading = false;
            _fieldNoKTP = true;
          });
        } else {
          String noKtp = _noKTPController.text.toString();
          int periodeByr = widget.periode;

          print("periodeByr: " + periodeByr.toString());
          print("noKtp: " + noKtp);

          PostKetenagakerjaan ketenagakerjaan =
              PostKetenagakerjaan(periodeByr: periodeByr, noKtp: noKtp);

          // PostKetenagakerjaan ketenagakerjaan = PostKetenagakerjaan(periodeByr: widget.periode, noKtp: "1234567891011123");

          _bpjsServices
              .postKetenagakerjaan(ketenagakerjaan)
              .then((response) async {
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

              print("periodeByr: " + periodeByr.toString());
              print("noKtp: " + noKtp);

              print("error: " + response.body);
              print(response.statusCode);

              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (__) => new PembayaranGagalBpjs(
                          jenis: "ketenagakerjaan",
                          pesan: response.body,
                          index: 1)));
              setState(() => _isLoading = false);
            } else if (response.statusCode == 302) {
              print("periodeByr: " + periodeByr.toString());
              print("noKtp: " + noKtp);
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
                      builder: (__) => new BpjsPembayaran(
                          jenis: "ketenagakerjaan", urlkerja: url)));
              setState(() => _isLoading = false);
            } else if (response.statusCode == 422) {
              print("periodeByr: " + periodeByr.toString());
              print("noKtp: " + noKtp);

              print("error: " + response.body);
              print(response.statusCode);

              Map data = jsonDecode(response.body);
              message = data['message'].toString();
              print("message: " + message);
              setState(() => {
                    error = false,
                    errorText = "Nomor tidak terdaftar",
                    _isLoading = false
                  });
            } else if (response.statusCode == 406) {
              print("periodeByr: " + periodeByr.toString());
              print("noKtp: " + noKtp);

              print("error: " + response.body);
              print(response.statusCode);

              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Transaksi Gagal",
                          style: TextStyle(color: Colors.green)),
                      content: Text(
                          "Anda tidak dapat membayar untuk periode lebih lama"),
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
            } else {
              print("periodeByr: " + periodeByr.toString());
              print("noKtp: " + noKtp);

              print("error: " + response.body);
              print(response.statusCode);

              Map data = jsonDecode(response.body);
              message = data['message'].toString();
              print("message: " + message);

              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (__) => new PembayaranGagalBpjs(
                          jenis: "ketenagakerjaan", pesan: message, index: 1)));
              setState(() => _isLoading = false);
            }
          });
        }
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
                        child: Text("Nomor KTP",
                            style: new TextStyle(fontSize: 14.0),
                            textAlign: TextAlign.left)),
                    TextField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(16),
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      controller: _noKTPController,
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
                        ket();
                      },
                    ),
                    Container(height: 15),
                    Container(
                        child: Text("Bayar Untuk",
                            style: new TextStyle(fontSize: 14.0),
                            textAlign: TextAlign.left)),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (__) => new BpjsBulan(
                                    jenis: "ketenagakerjaan",
                                    noKtp: _noKTPController.text,
                                    index: 1)));
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
                                    child: widget.bln == null
                                        ? new Text("1 Bulan",
                                            style: new TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.black54))
                                        : new Text(widget.bln,
                                            style:
                                                new TextStyle(fontSize: 14.0)),
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
                    Container(height: 3),
                    Container(
                        child: Text(
                            errorBulan ? "" : "Silahkan pilih bulan pembayaran",
                            style: new TextStyle(
                                fontSize: 12.0, color: Colors.red),
                            textAlign: TextAlign.left)),
                  ]))),
    );

    Widget bottomBanner = new Column(children: <Widget>[
      Divider(
        height: 12,
        color: Colors.black26,
      ),
      Container(height: 5),
      Container(
        height: 35.0,
        width: double.infinity,
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
                width: 150,
                height: 35,
                child: RaisedButton(
                    child:
                        Text('LANJUT', style: TextStyle(color: Colors.white)),
                    color: Colors.green,
                    // onPressed: _onPressed,
                    onPressed: () async {
                      ket();
                    }),
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
