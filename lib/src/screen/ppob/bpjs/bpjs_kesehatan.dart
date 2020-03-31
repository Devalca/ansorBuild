import 'dart:convert';
import 'package:ansor_build/src/screen/ppob/bpjs/bpjs_bulan.dart';
import 'package:flutter/material.dart';
import 'package:ansor_build/src/screen/ppob/bpjs/bpjs_pembayaran.dart';

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
        bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            child: Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(
                        width: 150,
                        height: 35,
                        child: RaisedButton(
                            child: Text('LANJUT',
                                style: TextStyle(color: Colors.white)),
                            color: Colors.green,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (__) => new BpjsPembayaran(
                                          jenis: "kesehatan")));
                            }),
                      ),
                    ])),
            elevation: 0),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                            Container(
                                child: Text("Nomor VA",
                                    style: new TextStyle(fontSize: 12.0),
                                    textAlign: TextAlign.left)),
                            TextField(
                              controller: _noVAController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                hintText: 'Contoh: 123456789',
                                errorText: _fieldNoVA == null || _fieldNoVA
                                    ? null
                                    : "Kolom Nomor Meter harus diisi",
                              ),
                              style: new TextStyle(fontSize: 14.0),
                              onChanged: (value) {
                                bool isFieldValid = value.trim().isNotEmpty;
                                if (isFieldValid != _fieldNoVA) {
                                  setState(() => _fieldNoVA = isFieldValid);
                                }
                              },
                            ),
                            Container(height: 15),
                            Container(
                                child: Text("Bayar Hingga",
                                    style: new TextStyle(fontSize: 12.0),
                                    textAlign: TextAlign.left)),
                            new GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (__) => new BpjsBulan(jenis: "kesehatan")));
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
                                            child: Text("Januari 2020",
                                                style: new TextStyle(
                                                    fontSize: 14.0)),
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
                          ]))));
  }
}
