import 'dart:convert';

import 'package:ansor_build/src/model/pdam_model.dart';
import 'package:ansor_build/src/screen/component/loading.dart';
import 'package:ansor_build/src/screen/ppob/pdam/list_screen.dart';
import 'package:ansor_build/src/service/local_service.dart';
import 'package:ansor_build/src/service/pdam_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'detail_screen.dart';

class PdamPage extends StatefulWidget {
  final String namaKotaKab;
  PdamPage(this.namaKotaKab);

  @override
  _PdamPageState createState() => _PdamPageState();
}

class _PdamPageState extends State<PdamPage> {
  bool _validate = true;
  final GlobalKey<FormState> _key = GlobalKey();
  PdamService _pdamService = PdamService();
  LocalService _localService = LocalService();
  String inputNomor, inputWilayah;
  TextEditingController _controllerWilayah = TextEditingController();
  TextEditingController _controllerNomor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: 1,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context, true);
            }),
        backgroundColor: Colors.white,
        title: Text(
          "Air PDAM",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Form(
        key: _key,
        autovalidate: _validate,
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 12.0),
                      child: Text('Nama Wilayah'),
                    ),
                    Stack(
                      children: <Widget>[
                        _buildTextFieldWilayah(),
                        Container(
                          width: 500,
                          height: 50,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ListWilayah()));
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12.0),
                      child: Text('Nomor Pelanggan'),
                    ),
                    _buildTextFieldPelanggan(),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Divider(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.centerRight,
                    child: RaisedButton(
                      onPressed: () {
                        _sendToServer();
                      },
                      child: Text(
                        "LANJUT".toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.green,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  String validateNomor(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(patttern);
    if (value.isEmpty) {
      return "Silahkan Masukan Nomor Pelanggan";
    }
    if (value.length != 11 && value.length != 12 && value.length != 13) {
      return "Nomor Salah";
    } else if (!regExp.hasMatch(value)) {
      return "Harus Angka";
    }
    return null;
  }

  String validateWilayah(String value) {
    if (value == "Pilih Daerah") {
      return "Silahkan Pilih Daerah Anda Yang Terdaftar";
    }
    return null;
  }

  Widget _buildTextFieldWilayah() {
    _controllerWilayah.text =
        widget.namaKotaKab == "" ? "Pilih Daerah" : widget.namaKotaKab;
    return TextFormField(
      // enabled: false,
      controller: _controllerWilayah,
      validator: validateWilayah,
      decoration: InputDecoration(
        suffixIcon: Icon(
          Icons.expand_more,
          color: Colors.grey,
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.grey)),
      ),
    );
  }

  Widget _buildTextFieldPelanggan() {
    return Container(
      child: TextFormField(
        inputFormatters: [
          LengthLimitingTextInputFormatter(12),
        ],
        controller: _controllerNomor,
        keyboardType: TextInputType.phone,
        validator: validateNomor,
        onSaved: (String val) {
          inputNomor = val;
        },
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.grey)),
          hintText: "Contoh : 123456",
        ),
      ),
    );
  }

  void _sendToServer() {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      String nomor = _controllerNomor.text.toString();
      String wilayah = _controllerWilayah.text = widget.namaKotaKab;
      PostPdam postPdam = PostPdam(noPelanggan: nomor, namaWilayah: wilayah);
      if (nomor != null || wilayah != null) {
        _pdamService.createPostPdam(postPdam).then((response) async {
          if (response.statusCode == 200) {
            Map blok = jsonDecode(response.body);
            userUid = blok['id'].toString();
            var blokMsg = blok["message"];
            if (blokMsg == "data tidak ada") {
              PdamDialog().pdamNullDialog(context);
            } else if (blokMsg == "anda sudah bayar untuk bulan ini") {
              PdamDialog().pdamDoneDialog(context);
            } else {
              PdamDialog().pdamLoadDialog(context);
              _localService.saveIdName(userUid).then((bool committed) {
                  print("INI Header :" + userUid);
                });
            }
          } else {
            print("INI STATUS CODE: " + response.statusCode.toString());
          }
        });
      }
    } else {
      setState(() {
        _validate = true;
      });
    }
  }
}
