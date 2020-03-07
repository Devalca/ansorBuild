import 'dart:convert';

import 'package:ansor_build/src/model/ansor_model.dart';
import 'package:ansor_build/src/screen/ppob/pulsa/pascabayar/detail_screen.dart';
import 'package:ansor_build/src/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final GlobalKey<ScaffoldState> _statePascabayar = GlobalKey<ScaffoldState>();

class PulsaPascaPage extends StatefulWidget {
  @override
  _PulsaPascaPageState createState() => _PulsaPascaPageState();
}

class _PulsaPascaPageState extends State<PulsaPascaPage> {
  var _controller = new TextEditingController();
  bool _isLoading = false;
  ApiService _apiService = ApiService();
  bool _isFieldNomor;
  TextEditingController _controllerNomor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _statePascabayar,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              color: Colors.white,
              height: 730.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top:12.0),
                            child: Text('Nomor Handphone'),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom:  BorderSide(width: 1.0, color: Colors.black),
                              )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 250.0,
                                  child: _buildTextFieldNomor(),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(right: 12.0),
                                        child: Icon(Icons.no_sim),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 12.0),
                                        height: 30.0,
                                        width: 1.0,
                                        color: Colors.black,
                                      ),
                                      Container(
                                        child: Icon(Icons.perm_contact_calendar),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Divider(
                            color: Colors.black
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Total'),
                                    Text('Rp')
                                  ],
                                ),
                              ),
                              Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: RaisedButton(
                              onPressed: () {
                                if (_isFieldNomor == null ||
                                    !_isFieldNomor ) {
                                  _statePascabayar.currentState.showSnackBar(
                                    SnackBar(
                                      content: Text("LENGKAPI DATA"),
                                    ),
                                  );
                                  return;
                                }
                                // setState(() => _isLoading = true);
                                String nomor = _controllerNomor.text.toString();
                                Post post = Post(noHp: nomor, userId: 1, walletId: 1);
                                _apiService.createPostPasca(post).then((response) async {
                                  if (response.statusCode == 200) {
                                    Map blok = jsonDecode(response.body);
                                    var userUid = blok['id'].toString();
                                    var koId = userUid;
                                    print(userUid);
                                    if(userUid == "null"){
                                       _statePascabayar.currentState.showSnackBar(SnackBar(
                                        duration: Duration(milliseconds: 30),
                                        content: Text("Nomor Yang Anda Masukan Tidak Terdaftar!")));
                                    } else {
                                       _apiService
                                        .saveNameId(userUid)
                                        .then((bool committed) {
                                    });
                                    await new Future.delayed(
                                        const Duration(seconds: 5));
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (__) => new DetailPage(koId)));
                                    setState(() => _isLoading = false);
                                    }
                                  } else {
                                    print("INI STATUS CODE: " + response.statusCode.toString());
                                  }
                                });
                              },
                              child: Text(
                                "beli".toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              color: Colors.green,
                            ),
                          ),
                    ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              
            ),
            _isLoading
                ? Stack(
                    children: <Widget>[
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFieldNomor() {
    return TextField(
      controller: _controllerNomor,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
         border: InputBorder.none,
        errorText:
            _isFieldNomor == null || _isFieldNomor ? null : "Tidak Boleh Kosong"
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldNomor) {
          setState(() => _isFieldNomor = isFieldValid);
        }
      },
    );
  }

  // Widget _buildTextFieldNominal() {
  //   return TextField(
  //     controller: _controllerNominal,
  //     keyboardType: TextInputType.number,
  //     decoration: InputDecoration(
  //       labelText: "Nominal",
  //       errorText:
  //           _isFieldNominal == null || _isFieldNominal ? null : "WOYYY 1!1!1!",
  //     ),
  //     onChanged: (value) {
  //       bool isFieldValid = value.trim().isNotEmpty;
  //       if (isFieldValid != _isFieldNominal) {
  //         setState(() => _isFieldNominal = isFieldValid);
  //       }
  //     },
  //   );
  // }
}
