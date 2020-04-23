import 'package:ansor_build/src/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';

class PinKonfirmPage extends StatefulWidget {
  final String pin;
  PinKonfirmPage(this.pin);

  @override
  _PinKonfirmPageState createState() => _PinKonfirmPageState();
}

class _PinKonfirmPageState extends State<PinKonfirmPage> {
  String konfirmPin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Navigator.pop(context, true);
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
                      "Silahkan masukan kembali PIN yang telah Anda buat untuk konfirmasi PIN Anda",
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
    );
  }

  Widget konfirmButton() {
    return FlatButton(
      onPressed: () {
        if (widget.pin == konfirmPin) {
          _toLogin();
        } else {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("PIN yang Anda Masukan Salah"),
                  content: Text('Silahkan masukan kembali PIN Anda'),
                );
              });
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => PinKonfirmPage(widget.pin)));
        }
      },
      child: Text(
        'Konfirmasi Pin'.toUpperCase(),
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  _toLogin() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.LoginScreen, (Route<dynamic> route) => false);
  }
}
