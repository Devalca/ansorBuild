import 'dart:convert';

import 'package:ansor_build/src/model/pulsa_model.dart';
import 'package:ansor_build/src/screen/component/kontak.dart';
import 'package:ansor_build/src/screen/component/loading.dart';
import 'package:ansor_build/src/service/local_service.dart';
import 'package:ansor_build/src/service/permissions_service.dart';
import 'package:ansor_build/src/service/pulsa_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class PulsaPascaPage extends StatefulWidget {
  @override
  _PulsaPascaPageState createState() => _PulsaPascaPageState();
}

class _PulsaPascaPageState extends State<PulsaPascaPage> {
  var nono;
  String cekNo;
  String testProv;
  String _idWallet;
  String mobi = "";
  String logoProv = "";
  bool _validate = false;
  String inputNomor, inputNominal, hargaNominal;
  final GlobalKey<FormState> _key = GlobalKey();
  PulsaService _pulsaService = PulsaService();
  LocalService _localService = LocalService();
  List<Provider> _provider = List<Provider>();
  List<Provider> _providerForDisplay = List<Provider>();
  TextEditingController _controllerNomor = TextEditingController();

  @override
  void initState() {
    _localService.getWalletId().then(updateWallet);
    _pulsaService.getProvider().then((value) {
      setState(() {
        _provider.addAll(value.data);
        _providerForDisplay = _provider;
      });
    });
    _controllerNomor.addListener(() {
      nono = _controllerNomor.text;
      for (var i = 0; i < _providerForDisplay.length; i++) {
        if (nono.substring(0, 4) == _providerForDisplay[i].kodeProvider) {
          setState(() {
            logoProv = _providerForDisplay[i].file.toString();
            testProv = "";
          });
        }
      }
    });
    super.initState();
  }

  void updateWallet(String idWallet) {
    setState(() {
      this._idWallet = idWallet;
    });
  }

  void moveToContactPage() async {
    final passNomor = await Navigator.push(
      context,
      CupertinoPageRoute(
          fullscreenDialog: true, builder: (context) => ContactsPage2()),
    );
    updateNomorPasca(passNomor);
  }

  void updateNomorPasca(String passNomor) {
    setState(() {
      if (passNomor != null) {
        _controllerNomor.text = passNomor
            .toString()
            .replaceAll("+62", "0")
            .replaceAll("-", "")
            .replaceAll(" ", "");
        cekNo = _controllerNomor.text;
        testProv = cekNo.substring(0, 4);
      }
    });
  }

  void dispose() {
    _controllerNomor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: Form(key: _key, autovalidate: _validate, child: _formNomorInput()),
    );
  }

  Widget _formNomorInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 300.0,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 12.0),
                  child: Text("Nomor Handphone"),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: _buildTextFieldNomor()),
              ],
            ),
          ),
          _btnNext()
        ],
      ),
    );
  }

  String validateNomor(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(patttern);
    if (value.isEmpty) {
      return "Wajib diisi";
    } else if (value.substring(0, 2) != "08") {
      return "Format nomor salah";
    } else if (value.length < 10) {
      return "Format nomor salah";
    } else if (!regExp.hasMatch(value)) {
      return "Format nomor salah";
    }
    return null;
  }

  Widget _buildTextFieldNomor() {
    return FutureBuilder<ProviderCall>(
        future: _pulsaService.getProvider(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Provider> providers = snapshot.data.data;
            return TextFormField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(13),
              ],
              controller: _controllerNomor,
              keyboardType: TextInputType.phone,
              validator: validateNomor,
              onSaved: (String val) {
                inputNomor = val;
              },
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey)),
                  suffixIcon: Stack(
                    alignment: Alignment.topRight,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 35),
                        child: Container(
                          height: 35.0,
                          width: 1.0,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 44, top: 4),
                        height: 30,
                        child: logoProv == ""
                            ? Container(
                                height: 5,
                                width: 5,
                              )
                            : Image.network(logoProv),
                      ),
                      Container(
                          padding: EdgeInsets.only(
                              top: 6.0, right: 6.0, bottom: 10.0),
                          child: GestureDetector(
                              onTap: () async => launchContacts(),
                              child:
                                  Image.asset("lib/src/assets/XMLID_2.png"))),
                    ],
                  )),
              onChanged: (value) {
                for (var i = 0; i < snapshot.data.data.length; i++) {
                  if (value.length == 4) {
                    if (value.substring(0, 4) == providers[i].kodeProvider) {
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
            return Text("Jaringan Bermasalah");
          }
          return Container(
            height: 200,
            alignment: Alignment.center,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  Widget _btnNext() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          Divider(
            height: 12,
            color: Colors.black,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // children: <Widget>[
                  //   Container(
                  //     child: Text('Total'),
                  //   ),
                  //   Container(
                  //       child: Text(hargaNominal == null ? "" : hargaNominal)),
                  // ],
                ),
              ),
              Expanded(
                child: Container(
                  width: 100.0,
                  child: RaisedButton(
                    color: Colors.green,
                    onPressed: () {
                      _sendToServer();
                    },
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
    );
  }

  void _sendToServer() {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      String nomor = _controllerNomor.text.toString();
      int idWallet = int.parse(_idWallet);
      if (nomor != null) {
        Post post = Post(noHp: nomor, userId: idWallet, walletId: idWallet);
        _pulsaService.createPostPasca(post).then((response) async {
          if (response.statusCode == 200) {
            Map blok = jsonDecode(response.body);
            userUid = blok['id'].toString();
            _localService.saveIdName(userUid).then((bool committed) {
              print("INI USERID :" + userUid);
            });
            PulsaDialog().pascaLoadDialog(context);
          } else if (response.statusCode == 422) {
            PulsaDialog().pascaGagalDialog(context);
          } else {
            print("INI STATUS CODE: " + response.statusCode.toString());
          }
        });
      }
    } else {
      setState(() {
        _validate = true;
      });
    }
  }

  void launchContacts() async {
    final PermissionStatus permissionStatus =
        await PermissionsService().getPermissionContact();
    if (permissionStatus == PermissionStatus.granted) {
      setState(() {
        _validate = false;
      });
      moveToContactPage();
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => ContactsPage2()));
    } else {
      PermissionsService().requestContactsPermission(onPermissionDenied: () {
        print('Permission has been denied');
      });
    }
  }
}
