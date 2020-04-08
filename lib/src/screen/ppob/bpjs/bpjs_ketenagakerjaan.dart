import 'dart:convert';
import 'package:ansor_build/src/screen/ppob/bpjs/bpjs_bulan.dart';
import 'package:ansor_build/src/screen/ppob/bpjs/pembayaran_gagal.dart';
import 'package:ansor_build/src/service/bpjs_services.dart';
import 'package:ansor_build/src/service/local_service.dart';
import 'package:flutter/material.dart';
import 'package:ansor_build/src/screen/ppob/bpjs/bpjs_pembayaran.dart';
import 'package:ansor_build/src/model/bpjs_model.dart';

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

  String url = "";

  TextEditingController _noKTPController = TextEditingController();

  BpjsServices _bpjsServices = BpjsServices();
  LocalService _localServices = LocalService();

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    var _onPressed;

    if (widget.bln != null) {
      _onPressed = () {
        setState(() => _isLoading = true);

        if (_noKTPController.text.isEmpty) {
          setState(() {
            _isLoading = false;
            _fieldNoKTP = true;
          });
        } else {
          String noKtp = _noKTPController.text.toString();

          PostKetenagakerjaan ketenagakerjaan =
              PostKetenagakerjaan(periodeByr: widget.periode, noKtp: noKtp);

          // PostKetenagakerjaan ketenagakerjaan = PostKetenagakerjaan(periodeByr: widget.periode, noKtp: "1234567891011123");

          _bpjsServices.postKetenagakerjaan(ketenagakerjaan).then((response) async {
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
                      builder: (__) =>
                          new PembayaranGagal(jenis: "ketenagakerjaan", pesan: response.body)));
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
                          new BpjsPembayaran(jenis: "ketenagakerjaan", urlkerja: url)));
              setState(() => _isLoading = false);
            } else {
              print("error: " + response.body);
              print(response.statusCode);

              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (__) =>
                          new PembayaranGagal(jenis: "ketenagakerjaan", pesan: response.body)));
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
                  width : 150,
                  height: 35,
                  child: RaisedButton(
                    child: Text('LANJUT', style: TextStyle(color: Colors.white)),
                    color: Colors.green,
                    onPressed: _onPressed,
                    // onPressed: () {
                    //   Navigator.push(context, new MaterialPageRoute(builder: (__) => new BpjsPembayaran(jenis: "ketenagakerjaan")));
                    // }
                  ),
                ),
              ]
            )
          ),
        
        elevation: 0
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: EdgeInsets.only(top: 12.0, bottom: bottom),
          child: _isLoading ? Center(child: CircularProgressIndicator()) :  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Container(
                child: Text(
                  "Nomor KTP", 
                  style: new TextStyle(fontSize: 12.0), 
                  textAlign: TextAlign.left
                )
              ),

              TextField(
                controller: _noKTPController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Contoh: 123456789',
                  errorText: _fieldNoKTP == null || _fieldNoKTP ? null : "Kolom Nomor KTP harus diisi",
                ),
                style: new TextStyle(fontSize:  14.0),
                onChanged: (value) {
                  bool isFieldValid = value.trim().isNotEmpty;
                  if (isFieldValid != _fieldNoKTP) {
                    setState(() => _fieldNoKTP = isFieldValid);
                  }
                },
              ),

              Container( height: 15 ),

              Container(
                child: Text(
                  "Bayar Untuk", 
                  style: new TextStyle(fontSize: 12.0), 
                  textAlign: TextAlign.left
                )
              ),

              Container(
                padding: const EdgeInsets.only(top: 10.0),
                width: double.infinity,
                height: 40.0,
                child: Column(
                  children: <Widget>[
                    
                    Expanded(
                      child: new GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (__) =>
                                    new BpjsBulan(jenis: "ketenagakerjaan", noKtp: _noKTPController.text)));
                      },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Text(widget.bln == null ? "1 Bulan" : widget.bln, style: new TextStyle(fontSize: 14.0)),
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
                    ),
                  ],
                ),
              ),

              Divider( height: 12, color: Colors.black ),

            ]
          )
        )
      )
    );
  }
}