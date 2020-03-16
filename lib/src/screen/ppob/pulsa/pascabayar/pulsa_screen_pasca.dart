import 'dart:convert';

import 'package:ansor_build/src/model/ansor_model.dart';
import 'package:ansor_build/src/screen/ppob/pulsa/pascabayar/detail_screen.dart';
import 'package:ansor_build/src/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final GlobalKey<ScaffoldState> _statePascabayar = GlobalKey<ScaffoldState>();

class PulsaPascaPage extends StatefulWidget {
  @override
  _PulsaPascaPageState createState() => _PulsaPascaPageState();
}

class _PulsaPascaPageState extends State<PulsaPascaPage> {
  var _controller = new TextEditingController();
  bool _isLoading = false;
  String mobi = "";
  String logoProv = "";
  ApiService _apiService = ApiService();
  bool _isFieldNomor;
  TextEditingController _controllerNomor = TextEditingController();

  static Future<void> _showLoadingDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: 5), () {
            Navigator.of(context).pop(true);
          });
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  backgroundColor: Colors.white,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(backgroundColor: Colors.green,),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Mohon Tunggu....",
                          style: TextStyle(color: Colors.green),
                        )
                      ]),
                    )
                  ]));
        });
  }

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
              height: 700.0,
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
                          margin: EdgeInsets.only(top: 12.0),
                          child: Text('Nomor Handphone'),
                        ),
                        Stack(
                            children: <Widget>[
                              Positioned(
                                child: Container(
                                  child: _buildTextFieldNomor(),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(240, 12, 0, 16),
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                          margin: EdgeInsets.only(right: 12.0),
                                          child: Container(
                                            height: 30.0,
                                            width: 30.0,
                                            child: Image.network(logoProv),
                                          )),
                                      Container(
                                        margin: EdgeInsets.only(right: 12.0),
                                        height: 30.0,
                                        width: 1.0,
                                        color: Colors.black,
                                      ),
                                      Container(
                                        child:
                                            Icon(Icons.perm_contact_calendar),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Divider(color: Colors.black),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[Text('Total'), Text('Rp')],
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: RaisedButton(
                                  onPressed: () {
                                    _showLoadingDialog(context);
                                    if (_isFieldNomor == null ||
                                        !_isFieldNomor) {
                                      _statePascabayar.currentState
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text("LENGKAPI DATA"),
                                        ),
                                      );
                                      return;
                                    }
                                    String nomor =
                                        _controllerNomor.text.toString();
                                    Post post = Post(
                                        noHp: nomor, userId: 1, walletId: 1);
                                    _apiService
                                        .createPostPasca(post)
                                        .then((response) async {
                                      if (response.statusCode == 200) {
                                        Map blok = jsonDecode(response.body);
                                        userUid = blok['id'].toString();
                                        var koId = userUid;
                                        print(userUid);
                                        if (userUid == "null") {
                                          _statePascabayar.currentState
                                              .showSnackBar(SnackBar(
                                                  duration: Duration(
                                                      milliseconds: 30),
                                                  content: Text(
                                                      "Nomor Yang Anda Masukan Tidak Terdaftar!")));
                                        } else {
                                          _apiService
                                              .saveNameId(userUid)
                                              .then((bool committed) {});
                                          await new Future.delayed(
                                              const Duration(seconds: 5));
                                          Navigator.push(
                                              context,
                                              new MaterialPageRoute(
                                                  builder: (__) =>
                                                      new DetailPage(koId)));
                                        }
                                      } else {
                                        print("INI STATUS CODE: " +
                                            response.statusCode.toString());
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
    return FutureBuilder<ProviderCall>(
        future: _apiService.getProvider(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Datum> providers = snapshot.data.data;
            return TextFormField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(12),
              ],
              controller: _controllerNomor,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  errorText: _isFieldNomor == null || _isFieldNomor
                      ? null
                      : "Tidak Boleh Kosong"),
              onChanged: (value) {
                bool isFieldValid = value.trim().isNotEmpty;
                for (var i = 0; i < snapshot.data.data.length; i++) {
                  if (value.length == 4) {
                    if (isFieldValid != _isFieldNomor) {
                      setState(() => _isFieldNomor = isFieldValid);
                    } else if (value == providers[i].kodeProvider) {
                      setState(() {
                        mobi = providers[i].namaProvider;
                        logoProv = providers[i].file.toString();
                      });
                    }
                  } else if (value.length == 3) {
                    setState(() {
                      mobi = "";
                      logoProv = "";
                    });
                  }
                }
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Container();
        });
  }
}
