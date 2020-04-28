import 'package:ansor_build/src/model/pdam_model.dart';
import 'package:ansor_build/src/screen/component/loading.dart';
import 'package:ansor_build/src/service/local_service.dart';
import 'package:ansor_build/src/service/pdam_service.dart';
import 'package:flutter/material.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PinPayLoad extends StatefulWidget {
  @override
  _PinPayLoadState createState() => _PinPayLoadState();
}

class _PinPayLoadState extends State<PinPayLoad> {
  String konfirmPin;
  PdamService _pdamService = PdamService();
  LocalService _localService = LocalService();

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
                      "Silahkan masukkan PIN Anda untuk melanjutkan pembayaran",
                      textAlign: TextAlign.center,
                    )),
                PinEntryTextField(
                  fields: 6,
                  onSubmit: (String pin) async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    int payUserId = prefs.getInt("payUserId");
                    String payPelanggan = prefs.getString("payPelanggan");
                    String payWilayah = prefs.getString("payWilayah");
                    int payTagihan = prefs.getInt("payTagihan");
                    setState(() {
                      konfirmPin = pin;
                    });
                    PostPdam postPdam = PostPdam(
                        userId: payUserId,
                        walletId: payUserId,
                        noPelanggan: payPelanggan,
                        namaWilayah: payWilayah,
                        tagihan: payTagihan,
                         pin: int.parse(konfirmPin)
                        );
                    _pdamService.createPdamPay(postPdam).then((response) async {
                      var headerUrl = response.headers['location'];
                      print("INis attsu code : " + response.body);
                      if (response.headers != null) {
                        if (response.statusCode == 403) {
                          PdamDialog().saldoMinDialog(context);
                        } else if (response.statusCode == 422) {
                          pinDialog(context);
                        } else {
                          _localService
                              .saveUrlName(headerUrl)
                              .then((bool committed) {
                            print("Berhasil");
                          });
                          PdamDialog().nPdamDialog(context);
                        }
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
