import 'dart:convert';

import 'package:ansor_build/src/model/ansor_model.dart';
import 'package:ansor_build/src/screen/ppob/pulsa/pascabayar/detail_screen.dart';
import 'package:ansor_build/src/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

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
      key: _scaffoldState,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.white,
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
                                        child: Icon(Icons.personal_video),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 12.0),
                                        height: 30.0,
                                        width: 1.0,
                                        color: Colors.black,
                                      ),
                                      Container(
                                        child: Icon(Icons.phone),
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
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: RaisedButton(
                          onPressed: () {
                            if (_isFieldNomor == null ||
                                !_isFieldNomor ) {
                              _scaffoldState.currentState.showSnackBar(
                                SnackBar(
                                  content: Text("Please fill all field"),
                                ),
                              );
                              return;
                            }
                            setState(() => _isLoading = true);
                            String nomor = _controllerNomor.text.toString();
                            // int nominal =
                            //     int.parse(_controllerNominal.text.toString());
                            Post post = Post(noHp: nomor);
                            _apiService.createPostPasca(post).then((response) async {
                              if (response.statusCode == 200) {
                                print("INI RESPONSE : " + response.body);
                                _scaffoldState.currentState.showSnackBar(SnackBar(
                                    duration: Duration(minutes: 5),
                                    content: Text("SEDANG PROSES")));
                                //  saveId();
                                Map blok = jsonDecode(response.body);
                                userUid = blok['id'].toString();
                                _apiService
                                    .saveNameId(userUid)
                                    .then((bool committed) {
                                  print(userUid);
                                });
                                await new Future.delayed(
                                    const Duration(seconds: 5));
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (__) => new DetailPage()));
                                setState(() => _isLoading = false);
                              } else {
                                print(response.statusCode);
                              }
                            });
                          },
                          child: Text(
                            "Submit".toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          color: Colors.orange[600],
                        ),
                      ),
                    ),
                  ],
                ),
              
            ),
            _isLoading
                ? Stack(
                    children: <Widget>[
                      Opacity(
                        opacity: 0.3,
                        child: ModalBarrier(
                          dismissible: false,
                          color: Colors.grey,
                        ),
                      ),
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
            _isFieldNomor == null || _isFieldNomor ? null : "WOYYY 1!1!1!",
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
