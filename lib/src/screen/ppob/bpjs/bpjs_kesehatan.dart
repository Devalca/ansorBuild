import 'dart:convert';
import 'package:ansor_build/src/model/bpjs_model.dart';
import 'package:ansor_build/src/routes/routes.dart';
import 'package:ansor_build/src/screen/ppob/bpjs/bpjs_bulan.dart';
import 'package:ansor_build/src/screen/ppob/bpjs/pembayaran_gagal.dart';
import 'package:ansor_build/src/screen/register/register.dart';
import 'package:ansor_build/src/service/bpjs_services.dart';
import 'package:ansor_build/src/service/local_service.dart';
import 'package:flutter/material.dart';
import 'package:ansor_build/src/screen/ppob/bpjs/bpjs_pembayaran.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool error = true;
  bool errorBulan = true;

  String url = "";
  String noVa = "";
  String errorText = "";

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
                          jenis: "kesehatan", pesan: response.body, index: 0)));
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

              Map data = jsonDecode(response.body);
              message = data['message'].toString();
              print("message: " + message);

              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (__) => new PembayaranGagal(
                          jenis: "kesehatan", pesan: message, index: 0)));
              setState(() => _isLoading = false);
            }
          });
        }
      };
    }

    Widget middleSection = new Expanded(
      child: new Container(
        padding: new EdgeInsets.only(top: 8.0),
        child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                  child: Text("Nomor VA",
                      style: new TextStyle(fontSize: 14.0),
                      textAlign: TextAlign.left)),
              TextField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(9),
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                controller: _noVAController,
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
              Container(height: 15),
              Container(
                  child: Text("Bayar Hingga",
                      style: new TextStyle(fontSize: 14.0),
                      textAlign: TextAlign.left)),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (__) => new BpjsBulan(
                              jenis: "kesehatan",
                              noVa: _noVAController.text,
                              index: 0)));
                },
                child: Container(
                  padding: const EdgeInsets.only(top: 10.0),
                  width: double.infinity,
                  height: 40.0,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: widget.nm == null
                                  ? new Text("Januari 2020",
                                      style: new TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black54))
                                  : new Text(widget.nm,
                                      style: new TextStyle(fontSize: 14.0)),
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
              // new GestureDetector(
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         new MaterialPageRoute(
              //             builder: (__) => new BpjsBulan(
              //                 jenis: "kesehatan",
              //                 noVa: _noVAController.text,
              //                 index: 0)));
              //   },
              //   child: Container(
              //     padding: const EdgeInsets.only(top: 10.0),
              //     width: double.infinity,
              //     height: 40.0,
              //     child: Column(
              //       children: <Widget>[
              //         Expanded(
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: <Widget>[
              //               Container(
              //                 child: widget.nm == null
              //                     ? new Text("Januari 2020",
              //                         style: new TextStyle(
              //                             fontSize: 14.0,
              //                             color: Colors.black54))
              //                     : new Text(widget.nm,
              //                         style: new TextStyle(fontSize: 14.0)),
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
              Divider(height: 12, color: Colors.black87),
              Container(height: 3),
              Container(
                  child: Text(
                      errorBulan ? "" : "Silahkan Pilih Bulan Pembayaran",
                      style: new TextStyle(fontSize: 12.0, color: Colors.red),
                      textAlign: TextAlign.left)),
            ]),
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
                children: <Widget>[],
              ),
            ),
            Container(
              child: SizedBox(
                width: 150,
                height: 35,
                child: RaisedButton(
                  child: Text('LANJUT', style: TextStyle(color: Colors.white)),
                  color: Colors.green,
                  // onPressed: _onPressed,
                  onPressed: () async {
                    if (_noVAController.text.isEmpty) {
                      setState(
                          () => {error = false, errorText = "Wajib diisi"});
                    } else if (_noVAController.text.length < 9) {
                      setState(() =>
                          {error = false, errorText = "Format nomor salah"});
                    } else if (widget.nm == null) {
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
                                  child: Text("OK",
                                      style: TextStyle(color: Colors.green)),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          });
                    } else {
                      setState(() => _isLoading = true);

                      if (_noVAController.text.isEmpty) {
                        setState(() {
                          _isLoading = false;
                          _fieldNoVA = true;
                        });
                      } else {
                        String noVa = _noVAController.text.toString();
                        String periode = tgl(widget.tgl);

                        PostKesehatan kesehatan =
                            PostKesehatan(noVa: noVa, periode: periode);

                        // PostKesehatan kesehatan = PostKesehatan(noVa: "123456789", periode: "2020-01-01");

                        _bpjsServices
                            .postKesehatan(kesehatan)
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

                            print("error: " + response.body);
                            print(response.statusCode);

                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (__) => new PembayaranGagal(
                                        jenis: "kesehatan",
                                        pesan: response.body,
                                        index: 0)));
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
                                    builder: (__) => new BpjsPembayaran(
                                        jenis: "kesehatan",
                                        url: url,
                                        index: 0)));
                            setState(() => _isLoading = false);
                          } else if (response.statusCode == 422) {
                            print("va: " + noVa);
                            print("periode: " + periode);

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
                            print("error: " + response.body);
                            print(response.statusCode);

                            print("va: " + noVa);
                            print("periode: " + periode);

                            Map data = jsonDecode(response.body);
                            message = data['message'].toString();
                            print("message: " + message);

                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Transaksi Gagal",
                                        style: TextStyle(color: Colors.green)),
                                    content: Text(message),
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

                            setState(() => _isLoading = false);
                          } else {
                            print("va: " + noVa);
                            print("periode: " + periode);

                            print("error: " + response.body);
                            print(response.statusCode);

                            Map data = jsonDecode(response.body);
                            message = data['message'].toString();
                            print("message: " + message);

                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (__) => new PembayaranGagal(
                                        jenis: "kesehatan",
                                        pesan: message,
                                        index: 0)));
                            setState(() => _isLoading = false);
                          }
                        });
                      }
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
