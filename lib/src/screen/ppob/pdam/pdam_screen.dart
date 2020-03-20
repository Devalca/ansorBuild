import 'package:ansor_build/src/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'detail_screen.dart';

class PdamPage extends StatefulWidget {
  @override
  _PdamPageState createState() => _PdamPageState();
}

class _PdamPageState extends State<PdamPage> {
  final GlobalKey<FormState> _key = GlobalKey();
  ApiService _apiService = ApiService();
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
          'PDAM',
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
                    _buildTextFieldWilayah(),
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
                        Navigator.push(context, MaterialPageRoute(builder: 
                        (context) => DetailPage("1")
                        ));
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
    return TextField(
      controller: _controllerWilayah,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: "Pilih Daerah",
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
    return TextFormField(
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
    );
  }
}
