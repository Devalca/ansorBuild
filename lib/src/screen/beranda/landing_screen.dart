import 'package:flutter/material.dart';

import 'beranda_screen.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _bottomNavCurrentIndex = 0;
  List<Widget> _container = [
    BerandaPage(),
    BerandaPage(),
    BerandaPage(),
    BerandaPage(),
    BerandaPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _container[_bottomNavCurrentIndex],
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          height: 80.0,
          width: 80.0,
          child: FittedBox(
            child: FloatingActionButton(
              backgroundColor: Colors.transparent,
              child: Image.asset("lib/src/assets/scan_qr.png"),
              onPressed: () {},
            ),
          ),
        ),
        bottomNavigationBar: _buildBottomNavigation());
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
}
