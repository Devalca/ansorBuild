import 'dart:convert';
import 'package:ansor_build/src/screen/ppob/bpjs/bpjs_pembayaran.dart';
import 'package:flutter/material.dart';

class BpjsKesehatan extends StatefulWidget {
  @override
  _BpjsKesehatanState createState() => _BpjsKesehatanState();
}

class _BpjsKesehatanState extends State<BpjsKesehatan> {
  bool _isLoading = false;
  bool _fieldNoVA;

  TextEditingController _noVAController = TextEditingController();

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
                  "Nomor VA", 
                  style: new TextStyle(fontSize: 12.0), 
                  textAlign: TextAlign.left
                )
              ),

              TextField(
                controller: _noVAController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Contoh: 123456789',
                  errorText: _fieldNoVA == null || _fieldNoVA ? null : "Kolom Nomor Meter harus diisi",
                ),
                style: new TextStyle(fontSize:  14.0),
                onChanged: (value) {
                  bool isFieldValid = value.trim().isNotEmpty;
                  if (isFieldValid != _fieldNoVA) {
                    setState(() => _fieldNoVA = isFieldValid);
                  }
                },
              ),

              Container(
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Text("Bayar Hingga", style: new TextStyle(fontSize: 14.0)),
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

                    Divider( height: 12, color: Colors.black ),

                  ]
                ),
              ),

              Divider( height: 12, color: Colors.black ),

              Container(
                height: 50.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: new Column (
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text (""),
                        ],
                      ),
                    ),
                    Container(
                      child: SizedBox(
                        width : 150,
                        height: 35,
                        child: RaisedButton(
                          child: Text('LANJUT', style: TextStyle(color: Colors.white)),
                          color: Colors.green,
                          onPressed: () {
                            Navigator.push(context, new MaterialPageRoute(builder: (__) => new BPJSPembayaran()));
                          }
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            ]
          )
        )
      )
    );
  }
}