import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ansor_build/src/screen/ppob/bpjs/bpjs_pembayaran.dart';

class BpjsKetenagakerjaan extends StatefulWidget {
  @override
  _BpjsKetenagakerjaanState createState() => _BpjsKetenagakerjaanState();
}

class _BpjsKetenagakerjaanState extends State<BpjsKetenagakerjaan> {
  bool _isLoading = false;
  bool _fieldNoKTP;

  TextEditingController _noKTPController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    onPressed: () {
                      Navigator.push(context, new MaterialPageRoute(builder: (__) => new BpjsPembayaran(jenis: "ketenagakerjaan")));
                    }
                  ),
                ),
              ]
            )
          ),
        
        elevation: 0
      ),
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

              TextField(
                controller: _noKTPController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Contoh: 123456789',
                  errorText: _fieldNoKTP == null || _fieldNoKTP ? null : "Kolom Nomor Meter harus diisi",
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Text("1 Bulan", style: new TextStyle(fontSize: 14.0)),
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

              Divider( height: 12, color: Colors.black ),

            ]
          )
        )
      )
    );
  }
}