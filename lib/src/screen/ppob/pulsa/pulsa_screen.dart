import 'dart:convert';

import 'package:ansor_build/src/model/ansor_model.dart';
import 'package:ansor_build/src/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:ansor_build/src/response/ansor_response.dart';
import 'package:http/http.dart' as http;

import 'detail_screen.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
SakitResponse r = new SakitResponse();

class PulsaPage extends StatefulWidget {
  @override
  _PulsaPageState createState() => _PulsaPageState();
}

class _PulsaPageState extends State<PulsaPage> {
  Post post = null;
  bool _isLoading = false;
  ApiService _apiService = ApiService();
  bool _isFieldNomor;
  bool _isFieldNominal;
  TextEditingController _controllerNomor = TextEditingController();
  TextEditingController _controllerNominal = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldState,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            "Form Add",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: FutureBuilder<Post>(
          future: _apiService.getPost(),
          builder: (context, snapshot) {
            return Container(
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        _buildTextFieldNomor(),
                        _buildTextFieldNominal(),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: RaisedButton(
                            onPressed: () {
                              if (_isFieldNomor == null ||
                                  _isFieldNominal == null ||
                                  !_isFieldNomor ||
                                  !_isFieldNominal) {
                                _scaffoldState.currentState.showSnackBar(
                                  SnackBar(
                                    content: Text("WOYYY 1!1!1!"),
                                  ),
                                );
                                return;
                              }
                              setState(() => _isLoading = true);
                              String no_hp = _controllerNomor.text.toString();
                              int nominal =
                                  int.parse(_controllerNominal.text.toString());
                              Post post = Post(noHp: no_hp, nominal: nominal);
                              _apiService.createPost(post).then((post) {
                                setState(() => _isLoading = false);
                                if (post != null) {
                                    Navigator.push(context, MaterialPageRoute(builder: 
                                    (context) => DetailPage()
                                    ));
                                } else {
                                  _scaffoldState.currentState
                                      .showSnackBar(SnackBar(
                                    content: Text("Submit data failed"),
                                  ));
                                }
                              });
                            },
                            child: Text(
                              (post != null)
                                  ? post.id + post.nominal
                                  : "tidak ADad",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            color: Colors.orange[600],
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
            );
          },
        ));
  }

  Widget _buildTextFieldNomor() {
    return TextField(
      controller: _controllerNomor,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: "Nomor HP",
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

  Widget _buildTextFieldNominal() {
    return TextField(
      controller: _controllerNominal,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Nominal",
        errorText:
            _isFieldNominal == null || _isFieldNominal ? null : "WOYYY 1!1!1!",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldNominal) {
          setState(() => _isFieldNominal = isFieldValid);
        }
      },
    );
  }
}