import 'dart:convert';

import 'package:ansor_build/src/model/pulsa_model.dart';
import 'package:ansor_build/src/routes/routes.dart';
import 'package:ansor_build/src/screen/component/kontak.dart';
import 'package:ansor_build/src/screen/component/loading.dart';
import 'package:ansor_build/src/screen/ppob/pulsa/pascabayar/detail_screen.dart';
import 'package:ansor_build/src/service/local_service.dart';
import 'package:ansor_build/src/service/permissions_service.dart';
import 'package:ansor_build/src/service/pulsa_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class PulsaPascaPage extends StatefulWidget {
  final String noValue2;
  PulsaPascaPage(this.noValue2);

  @override
  _PulsaPascaPageState createState() => _PulsaPascaPageState();
}

class _PulsaPascaPageState extends State<PulsaPascaPage> {
  String mobi = "";
  String logoProv = "";
  bool _validate = false;
  bool _isHide = false;
  String cekNo;
  String testProv;
  String _idWallet;
  String inputNomor, inputNominal, hargaNominal;
  final GlobalKey<FormState> _key = GlobalKey();
  PulsaService _pulsaService = PulsaService();
  LocalService _localService = LocalService();
  TextEditingController _controllerNomor = TextEditingController();

  @override
  void initState() {
    setState(() {
      if (widget.noValue2 == null) {
        print("noValue2 Kosong");
      } else if (widget.noValue2 != "") {
        _controllerNomor.text = widget.noValue2
            .toString()
            .replaceAll("+62", "0")
            .replaceAll("-", "")
            .replaceAll(" ", "");
        if (_controllerNomor.text != null) {
          cekNo = _controllerNomor.text;
          testProv = cekNo.substring(0, 4);
        }
      }
    });
    _localService.getWalletId().then(updateWallet);
    super.initState();
  }

  void dispose() {
    _controllerNomor.dispose();
    super.dispose();
  }

  void updateWallet(String idWallet) {
    setState(() {
      this._idWallet = idWallet;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: Form(key: _key, autovalidate: _validate, child: _isHideValidasi()),
    );
  }

  String validateNomor(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(patttern);
    if (value.isEmpty) {
      return "Nomor Boleh Kosong";
    } else if (value.length <= 10 && value.length <= 11 && value.length <= 12 && value.length <= 13) {
      return "Format Nomor Salah";
    } else if (!regExp.hasMatch(value)) {
      return "Harus Angka";
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
                LengthLimitingTextInputFormatter(12),
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
                        padding: EdgeInsets.only(right: 50, top: 4),
                        height: 30,
                        child: Image.network(logoProv),
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

  Widget _isHideValidasi() {
    if (_isHide == false) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
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
    } else {
      return centerLoading();
    }
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
                      if (inputNominal == null) {
                        PulsaDialog().praNullNominalDialog(context);
                      } else {
                        _sendToServer();
                      }
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
        setState(() {
          _isHide = true;
        });
        Post post = Post(noHp: nomor, userId: idWallet, walletId: idWallet);
        _pulsaService.createPostPasca(post).then((response) async {
          if (response.statusCode == 200) {
            Map blok = jsonDecode(response.body);
            userUid = blok['id'].toString();
            await Future.delayed(const Duration(seconds: 4));
            Navigator.push(context,
                MaterialPageRoute(builder: (__) => DetailPage(userUid)));
            setState(() {
              _isHide = false;
            });
          } else if (response.statusCode == 422) {
            PulsaDialog().pascaGagalDialog(context);
            setState(() {
              _isHide = false;
            });
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
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ContactsPage2()));
    } else {
      PermissionsService().requestContactsPermission(onPermissionDenied: () {
        print('Permission has been denied');
      });
    }
  }
}
