import 'package:ansor_build/src/routes/routes.dart';
import 'package:ansor_build/src/screen/login/login.dart';
import 'package:ansor_build/src/screen/ppob/pdam/detail_screen.dart';
import 'package:ansor_build/src/screen/ppob/pdam/pdam_screen.dart';
import 'package:ansor_build/src/screen/ppob/pulsa/main_pulsa.dart';
import 'package:ansor_build/src/screen/ppob/pulsa/selseai_screen.dart';
import 'package:ansor_build/src/screen/ppob/pdam/selesai_screen.dart';
import 'package:ansor_build/src/screen/ppob/trans_gagal.dart';
import 'package:ansor_build/src/screen/register/pin.dart';
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

// Future<void> loadingDialog(BuildContext context) async {
//   return showDialog<void>(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         Future.delayed(Duration(seconds: 4), () {
//           Navigator.of(context).pop(true);
//         });
//         return new WillPopScope(
//             onWillPop: () async => false,
//             child:
//                 SimpleDialog(backgroundColor: Colors.white, children: <Widget>[
//               Center(
//                 child: Column(children: [
//                   CircularProgressIndicator(),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                     "Mohon Tunggu....",
//                     style: TextStyle(color: Colors.green),
//                   )
//                 ]),
//               )
//             ]));
//       });
// }

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
            content: const Text('Email atau Nomor HP sudah terdaftar'),
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
                "Silahkan login menggunakan No. HP dan kata sandi yang didaftarkan"),
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
  Future<void> saldoMinDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: Text('Transaksi Gagal',
                  style: TextStyle(color: Colors.green)),
              content: const Text(
                  "Saldo Anda tidak cukup. Silahkan melakukan pengisian saldo"),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => MainPulsa("", ""))).then((result) {
                      Navigator.of(context).pop();
                    });
                  },
                ),
              ],
            ),
          );
        });
  }

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
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              // title: Text('Nomor Tidak Terdaftar',
              //     style: TextStyle(color: Colors.green)),
              content: const Text('Nomor tidak terdaftar'),
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
        });
  }

  Future<void> pascaDoneDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: Text(
                'Transkasi pembayaran sedang di proses mohon tunggu',
                style: TextStyle(color: Colors.green),
              ),
              // actions: <Widget>[
              //   FlatButton(
              //     child: Text('Ok'),
              //     onPressed: () {
              //       Navigator.of(context).pop();
              //     },
              //   ),
              // ],
            ),
          );
        });
  }

  Future<void> praNullNominalDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: Text(
                'Pembelian Gagal',
                style: TextStyle(color: Colors.green),
              ),
              content: const Text("Silahkan pilih nominal"),
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
        });
  }
}

// PDAM Dialog Fungction

class PdamDialog {
  Future<void> saldoMinDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: Text('Transaksi Gagal',
                  style: TextStyle(color: Colors.green)),
              content: const Text(
                  "Saldo Anda tidak cukup. Silahkan melakukan pengisian saldo"),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => PdamPage(""))).then((result) {
                      Navigator.of(context).pop();
                    });
                  },
                ),
              ],
            ),
          );
        });
  }

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
                        builder: (__) => DetailPagePdam(transIdName)))
                .then((result) {
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
            Navigator.push(context,
                MaterialPageRoute(builder: (__) => SesPdamPage(transUrlName)));
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
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: Text(
                ' Transaksi Gagal',
                style: TextStyle(color: Colors.green),
              ),
              content: const Text('Nama wilayah atau nomor salah'),
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
        });
  }

  Future<void> pdamDoneDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: Text(
                'Transaksi Gagal',
                style: TextStyle(color: Colors.green),
              ),
              content: const Text('Anda sudah melakukan pembayaran bulan in'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Navigator.of(context).pushNamedAndRemoveUntil(
                    //     Routes.LandingScreen, (Route<dynamic> route) => false);
                  },
                ),
              ],
            ),
          );
        });
  }
}