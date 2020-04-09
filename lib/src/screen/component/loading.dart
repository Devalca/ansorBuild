import 'package:ansor_build/src/routes/routes.dart';
import 'package:ansor_build/src/screen/ppob/pdam/detail_screen.dart';
import 'package:ansor_build/src/screen/ppob/pdam/selesai_screen.dart';
import 'package:ansor_build/src/screen/ppob/pulsa/prabayar/detail_screen.dart';
import 'package:ansor_build/src/screen/ppob/pulsa/selseai_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget centerLoading() {
  return Center(
    child: Container(
      color: Colors.white,
      alignment: Alignment(0.0, 0.0),
      child: CircularProgressIndicator(),
    ),
  );
}

Future<void> loadingDialog(BuildContext context) async {
  return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 4), () {
          Navigator.of(context).pop(true);
        });
        return new WillPopScope(
            onWillPop: () async => false,
            child:
                SimpleDialog(backgroundColor: Colors.white, children: <Widget>[
              Center(
                child: Column(children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Mohon Tunggu....",
                    style: TextStyle(color: Colors.green),
                  )
                ]),
              )
            ]));
      });
}

Future<void> saldoMinDialog(BuildContext context) async {
  return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.GagalScreen, (Route<dynamic> route) => false);
        });
        return SimpleDialog(backgroundColor: Colors.white, children: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.all(40.0),
              alignment: Alignment.center,
              child: Text(
                "Maaf Saldo Anda Tidak Mencukupi",
                style: TextStyle(color: Colors.green),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ]);
      });
}

// Register Dialog Fungction

class RegistDialog {
  Future<void> registGagalDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Text('Pendaftaran Gagal'),
            content: const Text(
                'Email atau Nomor anda sudah terdaftar silahkan periksa kembali'),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> registSuksesDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Text('Pendaftaran Berhasil'),
            content: const Text(
                'Silahkan Login Menggunakan Email dan Password yang baru saja anda buat'),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      Routes.LoginScreen, (Route<dynamic> route) => false);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

// Pulsa Dialog Fungction

class PulsaDialog {
  Future<void> nPulsaDialog(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String transIdName = prefs.getString("transIdName");
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: 4), () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (__) => SesPulsaPage(transIdName)));
          });
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  backgroundColor: Colors.white,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Mohon Tunggu....",
                          style: TextStyle(color: Colors.green),
                        )
                      ]),
                    )
                  ]));
        });
  }

  Future<void> pascaGagalDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: 1), () {
            Navigator.of(context).pop(true);
          });
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  backgroundColor: Colors.white,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Nomor Tidak Terdaftar",
                          style: TextStyle(color: Colors.green),
                        ),
                      ]),
                    )
                  ]));
        });
  }

  Future<void> pascaDoneDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.LandingScreen, (Route<dynamic> route) => false);
          });
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  backgroundColor: Colors.white,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Transaksi pembayaran pascabayar telah berhasil",
                          style: TextStyle(color: Colors.green),
                        ),
                      ]),
                    )
                  ]));
        });
  }

  Future<void> praNullNominalDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          Future.delayed(Duration(milliseconds: 450), () {
            Navigator.of(context).pop(true);
          });
          return SimpleDialog(backgroundColor: Colors.white, children: <Widget>[
            Center(
              child: Column(children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Silahkan Pilih Nominal",
                  style: TextStyle(color: Colors.green),
                ),
              ]),
            )
          ]);
        });
  }
}

// PDAM Dialog Fungction

class PdamDialog {
  Future<void> pdamLoadDialog(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String transIdName = prefs.getString("transIdName");
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: 4), () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (__) => DetailPagePdam(transIdName))).then((result) {
                       Navigator.of(context).pop();
                    });
          });
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  backgroundColor: Colors.white,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Mohon Tunggu....",
                          style: TextStyle(color: Colors.green),
                        )
                      ]),
                    )
                  ]));
        });
  }

  Future<void> nPdamDialog(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String transUrlName = prefs.getString("transUrlName");
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: 4), () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (__) => DetailPagePdam(transUrlName)));
          });
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  backgroundColor: Colors.white,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Mohon Tunggu....",
                          style: TextStyle(color: Colors.green),
                        )
                      ]),
                    )
                  ]));
        });
  }

  Future<void> pdamNullDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop(true);
          });
          return SimpleDialog(backgroundColor: Colors.white, children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.all(40.0),
                alignment: Alignment.center,
                child: Text(
                  "Data tidak ditemukan silahkan periksa kembali wilayah dan nomor pelanggan anda",
                  style: TextStyle(color: Colors.green),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ]);
        });
  }

  Future<void> pdamDoneDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop(true);
          });
          return SimpleDialog(backgroundColor: Colors.white, children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.all(40.0),
                alignment: Alignment.center,
                child: Text(
                  "Anda sudah membayar untuk bulan ini",
                  style: TextStyle(color: Colors.green),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ]);
        });
  }
}

// Future<void> nullDialog(BuildContext context) async {
//   return showDialog<void>(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return new WillPopScope(
//             onWillPop: () async => false,
//             child:
//                 SimpleDialog(backgroundColor: Colors.white, children: <Widget>[
//               Center(
//                 child: Column(children: [
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                     "Data harus lengkap!",
//                     style: TextStyle(color: Colors.green),
//                   ),
//                   RaisedButton(
//                       child: Text("Kembali"),
//                       onPressed: () {
//                         Navigator.of(context).pop(true);
//                       })
//                 ]),
//               )
//             ]));
//       });
// }
