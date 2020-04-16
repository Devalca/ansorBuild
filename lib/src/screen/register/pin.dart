import 'package:ansor_build/src/screen/register/pin_konfirm.dart';
import 'package:flutter/material.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';

class PinRegistPage extends StatefulWidget {
  @override
  _PinRegistPageState createState() => _PinRegistPageState();
}

class _PinRegistPageState extends State<PinRegistPage> {
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
      ),
      body: Column(
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
                    margin: EdgeInsets.only(top: 10.0, bottom: 70.0),
                    child: Text(
                        "Silahkan buat PIN untuk menambah keamanan akun Anda")),
                PinEntryTextField(
                  fields: 6,
                  onSubmit: (String pin) {
                    Navigator.push(context, MaterialPageRoute(builder: 
                    (_) => PinKonfirmPage(pin)
                    ));
                  },
                ),
              ],
            ),
          ),
          Container(),
        ],
      ),
    );
  }
}
