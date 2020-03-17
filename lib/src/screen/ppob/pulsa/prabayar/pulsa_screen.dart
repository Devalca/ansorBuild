import 'dart:convert';

import 'package:ansor_build/src/model/ansor_model.dart';
import 'package:ansor_build/src/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'detail_screen.dart';

class PulsaPage extends StatefulWidget {
  @override
  _PulsaPageState createState() => _PulsaPageState();
}

class _PulsaPageState extends State<PulsaPage> {
  GlobalKey<FormState> _key = GlobalKey();
  ApiService _apiService = ApiService();
  bool _validate = true;
  String inputNomor, inputNominal, hargaNominal;
  int _nominalIndex = -1;
  var mobi = "";
  var idProv = "";
  var logoProv = "";
  TextEditingController _controllerNomor = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    _controllerNomor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        child:
            Form(key: _key, autovalidate: _validate, child: formInputPulsa()),
      ),
    );
  }

  Widget formInputPulsa() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: FutureBuilder<ProviderCall>(
          future: _apiService.getProvider(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Datum> providers = snapshot.data.data;
              return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(top: 16.0),
                              child: Text('Nomor HandPhone $mobi')),
                          Stack(
                            children: <Widget>[
                              Positioned(
                                child: Container(
                                  child: TextFormField(
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(12)
                                      ],
                                      controller: _controllerNomor,
                                      onChanged: (String value) async {
                                        for (var i = 0;
                                            i < snapshot.data.data.length;
                                            i++) {
                                          if (value.length == 4) {
                                            if (value ==
                                                providers[i].kodeProvider) {
                                              setState(() {
                                                mobi =
                                                    providers[i].namaProvider;
                                                idProv = providers[i]
                                                    .operatorId
                                                    .toString();
                                                logoProv = providers[i]
                                                    .file
                                                    .toString();
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
                                      keyboardType: TextInputType.phone,
                                      validator: validateNomor,
                                      onSaved: (String val) {
                                        inputNomor = val;
                                      }),
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
                          Container(
                            height: 450.0,
                            padding: EdgeInsets.only(top: 15.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  FutureBuilder<NominalList>(
                                    future: _apiService.getNominal(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        for (var i = 0;
                                            i < snapshot.data.data.length;
                                            i++) {
                                          if (idProv == "") {
                                            return Container();
                                          } else if (idProv ==
                                              snapshot.data.data[i].operatorId
                                                  .toString()) {
                                            List<Listharga> hargaList =
                                                snapshot.data.data[i].listharga;
                                            return Container(
                                              height: 430.0,
                                              child: _btnListView(hargaList),
                                            );
                                          }
                                        }
                                      }
                                      return Container();
                                    },
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Divider(
                            height: 12,
                            color: Colors.black,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      child: Text('Total'),
                                    ),
                                    Row(children: <Widget>[
                                      Text('Rp'),
                                      Text(hargaNominal == null
                                          ? ""
                                          : hargaNominal),
                                    ])
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 100.0),
                                  child: RaisedButton(
                                    color: Colors.green,
                                    onPressed: _sendToServer,
                                    child: Text(
                                      'BELI',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Container();
          }),
    );
  }

  Widget _btnListView(List<Listharga> hargaList) {
    return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: hargaList == null ? 0 : hargaList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 2,
        ),
        itemBuilder: (BuildContext context, int index) {
          bool isSelected = _nominalIndex == index;
          int a = hargaList[index].nominalPulsa;
          int b = 1500;
          return GestureDetector(
            child: Container(
              padding: EdgeInsets.all(12.0),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                    color: isSelected
                        ? Colors.green.withOpacity(0.8)
                        : Colors.grey[700].withOpacity(0.5)),
                color: Colors.white,
              ),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      hargaList[index].nominalPulsa.toString(),
                      style: TextStyle(
                          fontSize: 28,
                          color: isSelected ? Colors.green : null),
                    ),
                    Text(
                      "Harga Rp.${a + b}",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              ),
            ),
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
              setState(() {
                _nominalIndex = index;
              });
              if (_nominalIndex == index) {
                inputNominal = hargaList[index].nominalPulsa.toString();
                hargaNominal = 'Rp.${a + b}';
                print(index);
                print(_nominalIndex);
                print(inputNominal);
              }
            },
          );
        });
  }

  String validateNomor(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(patttern);
    // if (value.length == 4) {
    // } else
    if (value.length != 11 && value.length != 12 && value.length != 13) {
      return "Harus 12";
    } else if (!regExp.hasMatch(value)) {
      return "Harus Angka";
    }
    return null;
  }

  String validateNominal(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(patttern);
    if (value.length == 0) {
      return "Tidak Boleh Kosong";
    } else if (!regExp.hasMatch(value)) {
      return "Harus Angka";
    }
    return null;
  }

  _sendToServer() {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      // setState(() => _isLoading = true);
      String nomor = inputNomor.toString();
      int nominal = int.parse(inputNominal.toString());
      String namaProv = mobi.toString();
      if (nomor != null || nominal != null || namaProv != null) {
        Post post = Post(
            noHp: nomor,
            nominal: nominal,
            userId: 1,
            walletId: 1,
            provider: namaProv);
        _apiService.createPost(post).then((response) async {
          if (response.statusCode == 200) {
            Map blok = jsonDecode(response.body);
            userUid = blok['id'].toString();
            var koId = userUid;
            _apiService.saveNameId(userUid).then((bool committed) {
              print(userUid);
            });
            print("INI KOID : " + koId);
            print("INI RESPONSE :" + response.body);
            print("NI PROVIDER : " + namaProv);
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (__) => new DetailPage(koId, namaProv)));
            _key.currentState.reset();
          } else {
            print("INI STATUS CODE : " + response.statusCode.toString());
          }
        });
      } else {
        print("error");
      }
    } else {
      setState(() {
        _validate = true;
      });
    }
  }
}