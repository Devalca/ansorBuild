import 'package:ansor_build/src/screen/beranda/landing_screen.dart';
import 'package:ansor_build/src/screen/login/login.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class LauncherPage extends StatefulWidget {
  @override
  _LauncherPageState createState() => new _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override
  void initState() {
    super.initState();
    startLaunching();
  }

  startLaunching() async {
    var duration = const Duration(seconds: 3);
    return new Timer(duration, () {
      userLogin();
    });
  }

  Future userLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getBool("isLogin")) {
      Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (_) {
        return LandingPage();
      }));
    } else {
      Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (_) {
        return Login();
      }));
    }
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Center(child: Image.asset('lib/src/assets/lapak_sahabat.png')),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(),
          Container(
            child: Column(
              children: <Widget>[
                Image.asset('lib/src/assets/sahabat_logo.png', height: 150, width: 150,),
                Image.asset('lib/src/assets/sahabat_text.png', height: 50)
              ],
            ),
          ),
          Container()
        ],
      )

      );
  }
}
