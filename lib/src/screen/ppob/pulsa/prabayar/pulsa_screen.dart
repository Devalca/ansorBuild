import 'dart:convert';

import 'package:ansor_build/src/model/ansor_model.dart';
import 'package:ansor_build/src/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'detail_screen.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class PulsaPage extends StatefulWidget {
  @override
  _PulsaPageState createState() => _PulsaPageState();
}

class _PulsaPageState extends State<PulsaPage> {
  var _controller = new TextEditingController();
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
      body: Stack(
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
                            content: Text("Please fill all field"),
                          ),
                        );
                        return;
                      }
                      setState(() => _isLoading = true);
                      String nomor = _controllerNomor.text.toString();
                      int nominal =
                          int.parse(_controllerNominal.text.toString());
                      Post post = Post(noHp: nomor, nominal: nominal);
                      _apiService.createPost(post).then((response) async {
                        if (response.statusCode == 200) {
                          _scaffoldState.currentState.showSnackBar(SnackBar(
                              duration: Duration(minutes: 5),
                              content: Text("SEDANG PROSES")));
                          //  saveId();
                          Map blok = jsonDecode(response.body);
                          userUid = blok['id'].toString();
                          _apiService.saveNameId(userUid).then((bool committed) {
                            print(userUid);
                          });
                           await new Future.delayed(const Duration(seconds: 5));
                          Navigator.push(context, new MaterialPageRoute(builder: (__) => new DetailPage()));
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
