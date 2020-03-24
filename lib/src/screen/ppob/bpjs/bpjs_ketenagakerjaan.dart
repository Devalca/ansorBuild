import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ansor_build/src/screen/ppob/pln/listrik_pembayaran.dart';
import 'package:ansor_build/src/service/pln_services.dart';
import 'package:ansor_build/src/model/pln_model.dart';

class BpjsKetenagakerjaan extends StatefulWidget {
  @override
  _BpjsKetenagakerjaanState createState() => _BpjsKetenagakerjaanState();
}

class _BpjsKetenagakerjaanState extends State<BpjsKetenagakerjaan> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0),
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

            ]
          )
        )
      )
    );
  }
}