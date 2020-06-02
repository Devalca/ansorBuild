import 'dart:convert';

import 'package:ansor_build/src/model/bank_model.dart';
import 'package:ansor_build/src/screen/transfer/antarbank.dart';
import 'package:ansor_build/src/service/bank_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Bank extends StatefulWidget {
  @override
  _BankState createState() => _BankState();
}

class _BankState extends State<Bank> {
  @override
  bool _isLoading = false;

  List<Banks> _list = [];
  List<Banks> _search = [];

  BankService _bankServices = BankService();
  TextEditingController _searchController = TextEditingController();

  final listbank = [
    {"id": 1, "bank": "BANK BCA"},
    {"id": 2, "bank": "BANK MANDIRI"},
    {"id": 3, "bank": "BANK BRI"},
    {"id": 4, "bank": "BANK BNI"},
    {"id": 5, "bank": "BANK BJB"},
    {"id": 6, "bank": "BANK DKI"},
    {"id": 7, "bank": "BANK CIMB Niaga"},
    {"id": 8, "bank": "BANK MAYBANK"},
    {"id": 9, "bank": "BANK OCBC NISP"},
    {"id": 10, "bank": "BANK PERMATA"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                }),
            backgroundColor: Colors.white,
            title: Text(
              'Bank Tujuan',
              style: TextStyle(color: Colors.black),
            )),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                    child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                      // Container(
                      //   width: double.infinity,
                      //   height: 40,
                      //   decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       shape: BoxShape.rectangle,
                      //       borderRadius:
                      //           BorderRadius.all(Radius.circular(10.0)),
                      //       border:
                      //           Border.all(color: Colors.grey[300], width: 1)),
                      //   child: TextField(
                      //     controller: _searchController,
                      //     decoration: InputDecoration(
                      //       border: InputBorder.none,
                      //       prefixIcon: new Icon(
                      //         Icons.search,
                      //       ),
                      //       hintText: 'Cari Bank',
                      //     ),
                      //     style: new TextStyle(fontSize: 15.0),
                      //     onChanged: (value) {},
                      //     onSubmitted: (value) {},
                      //   ),
                      // ),
                      Expanded(
                          child: FutureBuilder<Banks>(
                              future: _bankServices.fetchBank(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                      itemCount: snapshot.data.data.length,
                                      itemBuilder: (context, i) {
                                        return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: <Widget>[
                                              InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        new MaterialPageRoute(
                                                            builder: (__) =>
                                                                new AntarBank(
                                                                    bank: snapshot
                                                                        .data
                                                                        .data[i]
                                                                        .nama_bank)));
                                                  },
                                                  child: Container(
                                                      child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 5.0,
                                                                  bottom: 5.0),
                                                          child: Container(
                                                              child: Text(
                                                            snapshot
                                                                .data
                                                                .data[i]
                                                                .nama_bank,
                                                            style:
                                                                new TextStyle(
                                                                    fontSize:
                                                                        16.0),
                                                          )),
                                                        ),
                                                        Divider(
                                                          color: Colors.black,
                                                        ),
                                                      ]))),
                                            ]);
                                      });
                                } else if (snapshot.hasError) {
                                  return Text("${snapshot.error}");
                                }
                                return Center(
                                    child: CircularProgressIndicator());
                              })),
                    ])),
              ));
  }
}
