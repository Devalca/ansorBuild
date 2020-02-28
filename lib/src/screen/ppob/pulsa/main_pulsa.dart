import 'dart:convert';

import 'package:ansor_build/src/model/ansor_model.dart';
import 'package:ansor_build/src/screen/ppob/pulsa/prabayar/detail_screen.dart';
import 'package:ansor_build/src/screen/ppob/pulsa/prabayar/pulsa_screen.dart';
import 'package:ansor_build/src/service/api_service.dart';
import 'package:flutter/material.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> _scaffoldStatePasca = GlobalKey<ScaffoldState>();

class MainPulsaPage extends StatefulWidget {
  @override
  _MainPulsaPageState createState() => _MainPulsaPageState();
}

class _MainPulsaPageState extends State<MainPulsaPage> {
  bool _btnPascaBayar = false;
  bool _btnPraBayar = true;
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
      appBar: AppBar(
        title: Text("Main Pulsa"),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            children: <Widget>[
              Container(
                child: Center(
                  child: Text('INI IKLAN LAGI'),
                ),
                height: 120.0,
                width: 450.0,
                decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Colors.black)),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 200.0,
                      color: Colors.redAccent,
                      child: FlatButton(
                          onPressed: () {
                            setState(() {
                              if (_btnPraBayar == true) {
                                print('Trus');
                              } else if (_btnPascaBayar == true) {
                                _btnPascaBayar = !_btnPascaBayar;
                                _btnPraBayar = !_btnPraBayar;
                              }
                            });
                          },
                          child: Text("data 1")),
                    ),
                    Container(
                      width: 200.0,
                      color: Colors.redAccent,
                      child: FlatButton(
                          onPressed: () {
                            setState(() {
                              if (_btnPascaBayar == false) {
                                _btnPascaBayar = !_btnPascaBayar;
                                _btnPraBayar = !_btnPraBayar;
                              } else {
                                print('Truss');
                              }
                            });
                          },
                          child: Text("data")),
                    ),
                  ],
                ),
              ),
              _btnPraBayar ? Container(
                height: 500.0,
                child: _pulsaPage(),
              ) :SizedBox(),
                _btnPascaBayar ? Container(
                height: 500.0,
                child: _pascaPage(),
              ) :SizedBox(),
              // Container(
              //   height: 500.0,
              //   color: Colors.blueGrey,
              //   child: _btnPraBayar ? _pulsaPage() : SizedBox(),
              // ),
              // Container(
              //   height: 500.0,
              //   color: Colors.blueGrey,
              //   child: _btnPascaBayar ? _pascaPage() : SizedBox(),
              // ),
              // Container(
              //   color: Colors.blueAccent,
              //   height: 450.0,
              //    child: _pulsaPage(),
              // ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _pascaPage() {
    return Scaffold(
      key: _scaffoldStatePasca,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
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
                              _scaffoldStatePasca.currentState.showSnackBar(
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
                                _scaffoldStatePasca.currentState.showSnackBar(SnackBar(
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

  Widget _pulsaPage() {
    return Scaffold(
      key: _scaffoldState,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
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
                          margin: EdgeInsets.only(top: 12.0),
                          child: Text('Nomor Handphone'),
                        ),
                        Container(
                            decoration: BoxDecoration(
                                border: Border(
                              bottom:
                                  BorderSide(width: 1.0, color: Colors.black),
                            )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 250.0,
                                  child: _buildTextFieldNomor(),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                            )),
                        _buildTextFieldNominal(),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(top: 50.0),
                    child: Padding(
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
                              _apiService
                                  .saveNameId(userUid)
                                  .then((bool committed) {
                                print(userUid);
                              });
                              await new Future.delayed(
                                  const Duration(seconds: 2));
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

// import 'package:ansor_build/src/screen/ppob/pulsa/tabbar_pulsa.dart';
// import 'package:flutter/material.dart';

// class MainPulsaPage extends StatefulWidget {
//   @override
//   _MainPulsaPageState createState() => _MainPulsaPageState();
// }

// class _MainPulsaPageState extends State<MainPulsaPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomPadding: false,
//       appBar: AppBar(
//         title: Text('data'),
//       ),
//       body: Container(
//         color: Colors.white,
//         child: Stack(
//           children: <Widget>[
//             Container(
//               padding: EdgeInsets.only(top: 80.0, left: 16.0, right: 16.0),
//               child: Column(
//                 children: <Widget>[
//                   Expanded(child: TabBarPulsa()),
//                 ],
//               ),
//             ),
//             Positioned.fill(
//               child: Padding(
//                 padding: EdgeInsets.only(),
//                 child: new Column(
//                   children: <Widget>[_buildButtonsRow()],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildButtonsRow() {
//     return Container(
//       color: Colors.red,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.black,
//               width: 1.0,
//             ),
//           ),
//           height: 135.0,
//           width: 450.0,
//           child: Center(child: Text('INI IKLAN LAGI`')),
//         ),
//       ),
//     );
//   }
// }
