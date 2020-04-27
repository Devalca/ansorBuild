import 'dart:io';

import 'package:ansor_build/src/routes/routes.dart';
import 'package:ansor_build/src/screen/login/login.dart';
import 'package:ansor_build/src/screen/register/register.dart';
import 'package:ansor_build/src/service/local_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'beranda_screen.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  LocalService _localServices = LocalService();

  Future cekLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getBool("isLogin") == false) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => new Login()));
    }
  }

  int _bottomNavCurrentIndex = 0;
  List<Widget> _container = [
    BerandaPage(),
    BerandaPage(),
    BerandaPage(),
    BerandaPage(),
    BerandaPage(),
  ];

  @override
  void initState() {
    super.initState();
    cekLogin();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _closeDialog,
      child: Scaffold(
          body: _container[_bottomNavCurrentIndex],
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Container(
            height: 80.0,
            width: 80.0,
            child: FittedBox(
              child: FloatingActionButton(
                backgroundColor: Colors.transparent,
                child: Image.asset("lib/src/assets/scan_qr.png"),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Logout",
                              style: TextStyle(color: Colors.green)),
                          content: Text(
                              "Apakah anda yakin keluar dari aplikasi ini?"),
                          actions: <Widget>[
                            MaterialButton(
                              elevation: 5.0,
                              child: Text("TIDAK",
                                  style: TextStyle(color: Colors.green)),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            MaterialButton(
                              elevation: 5.0,
                              child: Text("YA",
                                  style: TextStyle(color: Colors.green)),
                              onPressed: () {
                                walletId = "0";
                                userId = "0";
                                pin = "0";
                                isLogin = false;

                                _localServices
                                    .saveWalletId(walletId)
                                    .then((bool committed) {
                                  print(walletId);
                                });

                                _localServices
                                    .saveUserId(userId)
                                    .then((bool committed) {
                                  print(userId);
                                });

                                _localServices
                                    .savePin(pin)
                                    .then((bool committed) {
                                  print(pin);
                                });

                                _localServices
                                    .isLogin(isLogin)
                                    .then((bool committed) {
                                  print(isLogin);
                                });

                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    Routes.LoginScreen,
                                    (Route<dynamic> route) => false);
                              },
                            )
                          ],
                        );
                      });
                },
              ),
            ),
          ),
          bottomNavigationBar: _buildBottomNavigation()),
    );
  }

  void navigationTapped(int index) {
    if (index == 2) {
      return;
    } else {
      setState(() {
        _bottomNavCurrentIndex = index;
      });
    }
  }

  Widget _buildBottomNavigation() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      onTap: navigationTapped,
      currentIndex: _bottomNavCurrentIndex,
      items: [
        BottomNavigationBarItem(
          activeIcon: Image.asset(
            "lib/src/assets/HOME_GREEN.png",
            height: 25,
            width: 25,
          ),
          icon: Image.asset(
            "lib/src/assets/HOME.png",
            height: 25,
            width: 25,
          ),
          title: Text("Beranda", style: TextStyle(color: Colors.black)),
        ),
        BottomNavigationBarItem(
          activeIcon: Image.asset(
            "lib/src/assets/TRANSFER_GREEN.png",
            height: 25,
            width: 25,
          ),
          icon: Image.asset(
            "lib/src/assets/TRANSFER.png",
            height: 25,
            width: 25,
          ),
          title: Text('Transfer', style: TextStyle(color: Colors.black)),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.close),
          title: Text(
            'Lainnya',
            style: TextStyle(color: Colors.white),
          ),
        ),
        BottomNavigationBarItem(
          activeIcon: Image.asset(
            "lib/src/assets/INBOX_GREEN.png",
            height: 25,
            width: 25,
          ),
          icon: Image.asset(
            "lib/src/assets/INBOX.png",
            height: 25,
            width: 25,
          ),
          title: Text('Histori', style: TextStyle(color: Colors.black)),
        ),
        BottomNavigationBarItem(
          activeIcon: Image.asset(
            "lib/src/assets/ACCOUNT_GREEN.png",
            height: 25,
            width: 25,
          ),
          icon: Image.asset(
            "lib/src/assets/ACCOUNT.png",
            height: 25,
            width: 25,
          ),
          title: Text('Profil', style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }

  Future<bool> _closeDialog() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Peringatan'),
            content: Text('Apakah anda yakin keluar dari aplikasi ini?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Tidak'),
              ),
              FlatButton(
                onPressed: () => exit(0),
                // Navigator.of(context).pop(true)
                child: Text('Ya'),
              ),
            ],
          ),
        ) ??
        false;
  }
}
