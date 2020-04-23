import 'package:ansor_build/src/routes/routes.dart';
import 'package:flutter/material.dart';

class TransGagalPage extends StatefulWidget {
  @override
  _TransGagalPageState createState() => _TransGagalPageState();
}

class _TransGagalPageState extends State<TransGagalPage> {
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
            leading: Container(
              child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    _toLanding();
                  }),
            ),
          ),
          body: Center(
            child: Text("Transaksi Gagal Silahkan Kembali"),
          )),
    );
  }

  _toLanding() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.LandingScreen, (Route<dynamic> route) => false);
  }
}
