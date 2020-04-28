import 'package:ansor_build/src/model/user_model.dart';
import 'package:ansor_build/src/screen/component/loading.dart';
import 'package:ansor_build/src/screen/register/pin.dart';
import 'package:ansor_build/src/service/regist_service.dart';
import 'package:flutter/material.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PinKonfirmPage extends StatefulWidget {
  final String pin;
  PinKonfirmPage(this.pin);

  @override
  _PinKonfirmPageState createState() => _PinKonfirmPageState();
}

class _PinKonfirmPageState extends State<PinKonfirmPage> {
  String konfirmPin;
  RegistService _registService = RegistService();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                _toPin();
              }),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 80.0),
              child: Column(
                children: <Widget>[
                  Text(
                    "Silahkan Masukkan PIN",
                    style: TextStyle(fontSize: 24, color: Colors.green),
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          top: 10.0, bottom: 50.0, left: 80, right: 80),
                      child: Text(
                        "Silahkan masukkan kembali PIN yang telah Anda buat untuk konfirmasi PIN Anda",
                        textAlign: TextAlign.center,
                      )),
                  PinEntryTextField(
                    fields: 6,
                    onSubmit: (String pin) {
                      setState(() {
                        konfirmPin = pin;
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.all(16.0),
                color: Colors.green,
                child: konfirmButton()),
          ],
        ),
      ),
    );
  }

  Widget konfirmButton() {
    return FlatButton(
      onPressed: () async {
        if (widget.pin == konfirmPin) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String saveNama = prefs.getString("saveNama");
          String saveNo = prefs.getString("saveNo");
          String saveEmail = prefs.getString("saveEmail");
          String savePass = prefs.getString("savePass");
          if (saveNama != "" ||
              saveNo != "" ||
              saveEmail != "" ||
              savePass != "") {
            Users users = Users(
                namaLengkap: saveNama,
                noHp: saveNo,
                email: saveEmail,
                password: savePass,
                pin: int.parse(konfirmPin));
            _registService.postRegist(users).then((response) async {
              if (response.statusCode == 200) {
                if (response.body == "already existed!") {
                  rmRegist();
                  RegistDialog().registGagalDialog(context);
                } else {
                  rmRegist();
                  RegistDialog().registSuksesDialog(context);
                }
              } else {
                print("INI STATUS CODE : " + response.statusCode.toString());
                print("INI RESPONSE :" + response.body);
              }
            });
          } else {
            print("Null Data");
          }
        } else {
          _gagalPinDialog();
        }
      },
      child: Text(
        'Konfirmasi Pin'.toUpperCase(),
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  rmRegist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("saveNama");
    prefs.remove("saveNo");
    prefs.remove("saveEmail");
    prefs.remove("savePass");
  }

  _toPin() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => PinRegistPage()));
  }

  Future<bool> _gagalPinDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("PIN yang Anda Masukan Salah"),
            content: Text('Silahkan masukkan kembali PIN Anda'),
          );
        });
  }
}
