import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ansor_build/src/screen/ppob/pln/listrik_pembayaran.dart';
import 'package:ansor_build/src/service/pln_services.dart';
import 'package:ansor_build/src/model/pln_model.dart';

class BpjsKesehatan extends StatefulWidget {
  @override
  _BpjsKesehatanState createState() => _BpjsKesehatanState();
}

class _BpjsKesehatanState extends State<BpjsKesehatan> {
  String url = "";

  bool _isLoading = false;
  bool _fieldNoPelanggan;

  PlnServices _plnServices = PlnServices();

  TextEditingController _noPelangganController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 48.0,
              child: Text("testing")
            )
          ],
        )
      )
    );
  }
}