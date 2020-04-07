import 'package:ansor_build/src/routes/routes.dart';
import 'package:flutter/material.dart';

Widget centerLoading() {
  return Center(
    child: Container(
      color: Colors.white,
      alignment: Alignment(0.0, 0.0),
      child: CircularProgressIndicator(),
    ),
  );
}

Future<void> underDialog(BuildContext context) async {
  return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new WillPopScope(
            onWillPop: () async => false,
            child:
                SimpleDialog(backgroundColor: Colors.white, children: <Widget>[
              Center(
                child: Column(children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Fitur Belum Bisa Digunakan!",
                    style: TextStyle(color: Colors.green),
                  ),
                  RaisedButton(
                      child: Text("Kembali"),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      })
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
        Future.delayed(Duration(milliseconds: 450), () {
          Navigator.of(context).pop(true);
        });
        return new WillPopScope(
            onWillPop: () async => false,
            child:
                SimpleDialog(backgroundColor: Colors.white, children: <Widget>[
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

Future<void> nullNominalDialog(BuildContext context) async {
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

Future<void> nullPdamDialog(BuildContext context) async {
  return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 2), () {
          // Navigator.of(context).pop(true);
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

Future<void> nullDialog(BuildContext context) async {
  return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new WillPopScope(
            onWillPop: () async => false,
            child:
                SimpleDialog(backgroundColor: Colors.white, children: <Widget>[
              Center(
                child: Column(children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Data harus lengkap!",
                    style: TextStyle(color: Colors.green),
                  ),
                  RaisedButton(
                      child: Text("Kembali"),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      })
                ]),
              )
            ]));
      });
}

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
                // Navigator.of(context).pop(true);
                // Navigator.pushReplacement(context,
                //     MaterialPageRoute(builder: (context) => Login()));
              },
            ),
          ],
        ),
      );
    },
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
