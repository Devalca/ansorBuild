import 'package:ansor_build/src/model/user_model.dart';
import 'package:ansor_build/src/routes/routes.dart';
import 'package:ansor_build/src/screen/component/kontak.dart';
import 'package:ansor_build/src/screen/component/loading.dart';
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
  bool showPsd = true;
  String registNama = '';
  String registEmail = '';
  String registPsd = '';
  String registNomor = '';
  TextEditingController _controllerNama = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerNomor = TextEditingController();
  TextEditingController _controllerPsd = TextEditingController();

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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _regKey,
            autovalidate: _validate,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    height: 100,
                    width: 200,
                    margin: EdgeInsets.only(bottom: 60),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Image.asset('lib/src/assets/lapakSahabat.png'),
                    ),
                  ),
                  Column(
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
                  Container(),
                  Container(),
                ],
              ),
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
      decoration: InputDecoration(hintText: 'Masukkan Nama Lengkap'),
      validator: validateName,
      onSaved: (String value) {
        registNama = value;
      },
    );
  }

  String validateName(String value) {
    String patttern = r'(^[a-zA-Z]*$)';
    RegExp regExp = RegExp(patttern);
    if (value.isEmpty) {
      return 'Nama Lengkap Harus Diisi';
    } else if (value.length < 3) {
      return 'Nama harus lebih dari 3';
    } else if (!regExp.hasMatch(value)) {
      return "Hanya Boleh Huruf atau Alphabet";
    }

    return null;
  }

  Widget emailField() {
    return TextFormField(
      controller: _controllerEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Masukkan Email',
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
      decoration: InputDecoration(hintText: 'Masukkan Nomor Handphone'),
      validator: validateNomor,
      onSaved: (String value) {
        registNomor = value;
      },
    );
  }

  String validateNomor(String value) {
    if (value.isEmpty) {
      return "Tidak Boleh Kosong";
    } else if (value.length != 12) {
      return "Harus 12";
    }
    return null;
  }

  Widget passwordField() {
    return TextFormField(
      controller: _controllerPsd,
      obscureText: showPsd,
      decoration: InputDecoration(
        hintText: 'Buat Kata Sandi',
        suffixIcon: IconButton(
          icon: Icon(
            showPsd ? Icons.visibility_off : Icons.visibility,
            color: Theme.of(context).primaryColorDark,
          ),
          onPressed: () {
            setState(() {
              showPsd = !showPsd;
            });
          },
        ),
      ),
      validator: validatePassword,
      onSaved: (String value) {
        registPsd = value;
      },
    );
  }

  String validatePassword(String value) {
    if (value.length < 6) {
      return 'Kata Sandi Minimal 6 Karakter';
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
                  registGagalDialog(context);
                  _controllerNama.clear();
                  _controllerEmail.clear();
                  _controllerNomor.clear();
                  _controllerPsd.clear();
                } else {
                  registSuksesDialog(context);
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
