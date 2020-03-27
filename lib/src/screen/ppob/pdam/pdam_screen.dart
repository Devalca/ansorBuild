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
  final GlobalKey<FormState> _key = GlobalKey();
  LocalService _localService = LocalService();
  PdamService _pdamService = PdamService();
  bool _validate = true;
  bool _isFieldWilayah;
  bool _isFieldNomor;
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
                        loadingDialog(context);
                        String nomor = _controllerNomor.text.toString();
                        String wilayah =
                            _controllerWilayah.text = widget.namaKotaKab;
                        PostPdam postPdam =
                            PostPdam(noPelanggan: nomor, namaWilayah: wilayah);
                        if (nomor != null || wilayah != null) {
                          _pdamService
                              .createPostPdam(postPdam)
                              .then((response) async {
                            if (response.statusCode == 200) {
                              Map blok = jsonDecode(response.body);
                              String userUid = blok['data'][0]['id'].toString();
                              String koId = userUid;
                              print(userUid);
                              if (userUid == null) {
                                print("user id Kosong");
                              } else {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (__)
                                => DetailPagePdam()
                                ));
                              }
                            } else {
                              print("INI STATUS CODE: " +
                                  response.statusCode.toString());
                            }
                          });
                        } else {
                          print("part5");
                        }
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
    if (value.length != 11 && value.length != 12 && value.length != 13) {
      return "Nomor Salah";
    } else if (!regExp.hasMatch(value)) {
      return "Harus Angka";
    }
    return null;
  }

  Widget _buildTextFieldWilayah() {
    return TextFormField(
      enabled: false,
      controller: _controllerWilayah,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        suffixIcon: Icon(
          Icons.expand_more,
          color: Colors.grey,
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.grey)),
        hintText:
            widget.namaKotaKab == "" ? "Pilih Daerah" : widget.namaKotaKab,
        errorText:
            _isFieldWilayah == null || _isFieldWilayah ? null : "Nama Wilayah",
      ),
      onChanged: (String value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldWilayah) {
          setState(() => _isFieldWilayah = isFieldValid);
        }
      },
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
            errorText: _isFieldNomor == null || _isFieldNomor
                ? null
                : "Tidak Boleh Kosong"),
        onChanged: (String value) {
          bool isFieldValid = value.trim().isNotEmpty;
          if (isFieldValid != _isFieldNomor) {
            setState(() => _isFieldNomor = isFieldValid);
          }
        },
      ),
    );
  }
}
