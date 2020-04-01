import 'package:ansor_build/src/model/user_model.dart';
import 'package:ansor_build/src/routes/routes.dart';
import 'package:ansor_build/src/screen/login/login.dart';
import 'package:ansor_build/src/service/regist_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegistService _registService = RegistService();
  final _regKey = GlobalKey<FormState>();
  bool _validate = false;
  String registNama = '';
  String registEmail = '';
  String registPsd = '';
  String registNomor = '';
  TextEditingController _controllerNama = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerNomor = TextEditingController();
  TextEditingController _controllerPsd = TextEditingController();

  Future<void> _glDialog(BuildContext context) {
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

  Future<void> _suDialog(BuildContext context) {
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
                  Navigator.of(context).pop(true);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _regKey,
          autovalidate: _validate,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: 100,
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Image.asset('lib/src/assets/lapakSahabat.png'),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Text(
                              "Nama Lengkap",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          nameField(),
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Text(
                              "Nomor Handphone",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          nomorField(),
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Text(
                              "Email",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          emailField(),
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Text(
                              "Kata Sandi",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          passwordField(),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.green,
                                border:
                                    Border.all(width: 1, color: Colors.green),
                                borderRadius: BorderRadius.circular(5)),
                            margin: EdgeInsets.only(top: 30.0, bottom: 30.0),
                            height: 50.0,
                            child: registerButton(),
                          ),
                          Column(
                            children: <Widget>[
                              Divider(),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 20.0),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text('Sudah Punya Akun? '),
                                      GestureDetector(
                                        onTap: () {
                                          _toLanding();
                                        },
                                        child: Text(
                                          'MASUK',
                                          style: TextStyle(color: Colors.green),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(),
                Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget nameField() {
    return TextFormField(
      controller: _controllerNama,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(hintText: 'Masukan Nama Lengkap'),
      validator: validateName,
      onSaved: (String value) {
        registNama = value;
      },
    );
  }

  String validateName(String value) {
    if (value.isEmpty) {
      return 'Nama Lengkap Harus Diisi';
    } else if (value.length < 7)
      return 'Lebih Dari 6';
    else
      return null;
  }

  Widget emailField() {
    return TextFormField(
      controller: _controllerEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Masukan Email',
      ),
      validator: validateEmail,
      onSaved: (String value) {
        registEmail = value;
      },
    );
  }

  String validateEmail(String value) {
    if (!value.contains('@gmail.com')) {
      return 'Silahkan gunakan gmail anda';
    }
    return null;
  }

  Widget nomorField() {
    return TextFormField(
      controller: _controllerNomor,
      keyboardType: TextInputType.phone,
      inputFormatters: [
        LengthLimitingTextInputFormatter(12),
      ],
      decoration: InputDecoration(hintText: 'Masukan Nomor Handphone'),
      validator: validateNomor,
      onSaved: (String value) {
        registNomor = value;
      },
    );
  }

  String validateNomor(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(patttern);
    if (value.isEmpty) {
      return "Tidak Boleh Kosong";
    } else if (value.length != 12) {
      return "Harus 12";
    } else if (!regExp.hasMatch(value)) {
      return "Harus Angka";
    }
    return null;
  }

  Widget passwordField() {
    return TextFormField(
      controller: _controllerPsd,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Buat Kata Sandi',
      ),
      validator: validatePassword,
      onSaved: (String value) {
        registPsd = value;
      },
    );
  }

  String validatePassword(String value) {
    if (value.length < 6) {
      return 'Password Minimal 6 Karakter';
    }
    return null;
  }

  Widget registerButton() {
    return FlatButton(
      onPressed: () {
        if (_regKey.currentState.validate()) {
          _regKey.currentState.save();
          if (registNama != "" ||
              registEmail != "" ||
              registNomor != "" ||
              registPsd != "") {
            Users users = Users(
              namaLengkap: registNama,
              noHp: registNomor,
              email: registEmail,
              password: registPsd,
            );
            _registService.postRegist(users).then((response) async {
              if (response.statusCode == 200) {
                if (response.body == "already existed!") {
                  _glDialog(context);
                  _controllerNama.clear();
                  _controllerEmail.clear();
                  _controllerNomor.clear();
                  _controllerPsd.clear();
                } else {
                  _suDialog(context);
                  _controllerNama.clear();
                  _controllerEmail.clear();
                  _controllerNomor.clear();
                  _controllerPsd.clear();
                }
                print('Daftar SUkses');
                // _statePrabayar.currentState.showSnackBar(SnackBar(
                //     duration: Duration(minutes: 5),
                //     content: Text("SEDANG PROSES")));
                // await new Future.delayed(
                //     const Duration(seconds: 2));
                // setState(() => _isLoading = false);
              } else {
                print("INI STATUS CODE : " + response.statusCode.toString());
              }
            });
          } else {
            print("INI ERROR LOH");
          }
        }
      },
      child: Text(
        'Daftar'.toUpperCase(),
        style: TextStyle(color: Colors.white),
      ),
    );
  }

    _toLanding() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.LandingScreen, (Route<dynamic> route) => false);
  }
}
