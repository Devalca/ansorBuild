import 'dart:convert';

import 'package:ansor_build/src/model/pulsa_model.dart';
import 'package:ansor_build/src/screen/component/formatIndo.dart';
import 'package:ansor_build/src/screen/component/kontak.dart';
import 'package:ansor_build/src/screen/component/loading.dart';
import 'package:ansor_build/src/service/local_service.dart';
import 'package:ansor_build/src/service/permissions_service.dart';
import 'package:ansor_build/src/service/pulsa_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import 'detail_screen.dart';

class PulsaPage extends StatefulWidget {
  final String noValue;
  PulsaPage(this.noValue);

  @override
  _PulsaPageState createState() => _PulsaPageState();
}

class _PulsaPageState extends State<PulsaPage> {
  var namaProv = "";
  var idProv = "";
  var logoProv = "";
  var testProv;
  var cekNo;
  bool _validate = false;
  int _nominalIndex = -1;
  String inputNomor, inputNominal, hargaNominal;
  GlobalKey<FormState> _key = GlobalKey();
  PulsaService _pulsaService = PulsaService();
  LocalService _localService = LocalService();
  final cF = NumberFormat.currency(locale: 'ID');
  TextEditingController _controllerNomor = TextEditingController();
  List<Nominal> _nominal = List<Nominal>();
  List<Nominal> _nominalForDisplay = List<Nominal>();
  List<Provider> _provider = List<Provider>();
  List<Provider> _providerForDisplay = List<Provider>();
  static const platform =
      const MethodChannel('flutter_contacts/launch_contacts');

  @override
  void initState() {
    _pulsaService.getNominal().then((value) {
      setState(() {
        _nominal.addAll(value.data);
        _nominalForDisplay = _nominal;
      });
    });
    _pulsaService.getProvider().then((value) {
      setState(() {
        _provider.addAll(value.data);
        _providerForDisplay = _provider;
      });
    });
    setState(() {
      if (widget.noValue != "") {
        _controllerNomor.text =
            widget.noValue.toString().replaceAll("+62", "0").replaceAll("-", "");
        if (_controllerNomor.text != null) {
          cekNo = _controllerNomor.text;
          testProv = cekNo.substring(0, 4);
        }
      }
    });
    super.initState();
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
      body: Container(
        child: Form(
            key: _key,
            autovalidate: _validate,
            child: SingleChildScrollView(child: _formPulsaInput())),
      ),
    );
  }

  Widget _formPulsaInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(margin: EdgeInsets.only(top: 16.0), child: Text("NO")),
        Padding(
          padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
          child: TextFormField(
              inputFormatters: [LengthLimitingTextInputFormatter(12)],
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
                        padding:
                            EdgeInsets.only(top: 6.0, right: 6.0, bottom: 10.0),
                        child: GestureDetector(
                            onTap: () async => launchContacts(),
                            child: Image.asset("lib/src/assets/XMLID_2.png"))),
                  ],
                ),
              ),
              controller: _controllerNomor,
              onChanged: (String value) async {
                for (var i = 0; i < _providerForDisplay.length; i++) {
                  if (value.length == 4) {
                    if (value.substring(0, 4) ==
                        _providerForDisplay[i].kodeProvider) {
                      setState(() {
                        namaProv = _providerForDisplay[i].namaProvider;
                        idProv = _providerForDisplay[i].operatorId.toString();
                        logoProv = _providerForDisplay[i].file.toString();
                        testProv = "";
                      });
                    }
                  } else if (value.length == 3) {
                    setState(() {
                      idProv = "";
                      namaProv = "";
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
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          FutureBuilder<NominalList>(
            future: _pulsaService.getNominal(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Center(
                    child: Text("Koneksi Terputus"),
                  );
                case ConnectionState.waiting:
                  return Container(
                    height: 400,
                    child: centerLoading(),
                  );
                default:
                  if (snapshot.hasData) {
                    for (var i = 0; i < snapshot.data.data.length; i++) {
                      for (var i = 0; i < _providerForDisplay.length; i++) {
                        if (testProv == _providerForDisplay[i].kodeProvider) {
                          namaProv = _providerForDisplay[i].namaProvider;
                          idProv = _providerForDisplay[i].operatorId.toString();
                          logoProv = _providerForDisplay[i].file.toString();
                        }
                      }
                      if (idProv == "") {
                        return Container(
                          height: 350,
                          child: centerLoading(),
                        );
                      } else if (idProv ==
                          snapshot.data.data[i].operatorId.toString()) {
                        print(idProv);
                        List<Listharga> hargaList =
                            snapshot.data.data[i].listharga;
                        return Column(
                          children: <Widget>[
                            _btnListView(hargaList),
                            _btnNext()
                          ],
                        );
                      }
                    }
                  } else {
                    return Text('Result: ${snapshot.error}');
                  }
              }
              return Container(
                height: 350,
                child: centerLoading(),
              );
            },
          ),
        ]),
      ],
    );
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
                  children: <Widget>[
                    Container(
                      child: Text('Total'),
                    ),
                    Container(
                        child: Text(hargaNominal == null ? "" : hargaNominal)),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: 100.0,
                  child: RaisedButton(
                    color: Colors.green,
                    onPressed: sendToServer,
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
          var jmh = a + b;
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
                      formatRupiah(hargaList[index].nominalPulsa)
                          .replaceAll("Rp ", "")
                          .toString(),
                      style: TextStyle(
                          fontSize: 20,
                          color: isSelected ? Colors.green : null),
                    ),
                    Text(
                      formatRupiah(jmh).replaceAll("Rp ", "Rp"),
                      style: TextStyle(
                        fontSize: 12,
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
                hargaNominal = formatRupiah(jmh).replaceAll("Rp ", "Rp");
              }
            },
          );
        });
  }

  String validateNomor(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(patttern);
    if (value.length != 11 && value.length != 12 && value.length != 13) {
      return "Nomor Salah";
    } else if (!regExp.hasMatch(value)) {
      return "Harus Angka";
    }
    return null;
  }

  void sendToServer() {
    loadingDialog(context);
    if (_key.currentState.validate()) {
      _key.currentState.save();
      String nomor = inputNomor.toString();
      // int nominal = int.parse(inputNominal.toString());
      String providerNama = namaProv.toString();
      int nominal = inputNominal == ""
          ? int.parse(cekNo.toString())
          : int.parse(inputNominal.toString());
      if (nomor != null && nominal != null && providerNama != null) {
        Post post = Post(
            noHp: nomor,
            nominal: nominal,
            userId: 1,
            walletId: 1,
            provider: providerNama);
        _pulsaService.createPost(post).then((response) async {
          if (response.statusCode == 200) {
            Map blok = jsonDecode(response.body);
            userUid = blok['id'].toString();
            var koId = userUid;
            _localService.saveNameId(userUid).then((bool committed) {
              print(userUid);
            });
            await new Future.delayed(const Duration(seconds: 5));
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
        print("Something Error");
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
          context, MaterialPageRoute(builder: (context) => ContactsPage()));
    } else {
      PermissionsService().requestContactsPermission(onPermissionDenied: () {
        print('Permission has been denied');
      });
    }
  }
}
