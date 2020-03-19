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
              backgroundColor: Colors.green,
              child: Container(
                padding: EdgeInsets.only(top: 12),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 25,
                      width: 25,
                      child: Image.asset('lib/src/assets/qr-code.png'),
                    ),
                    Container(
                      child: Text(
                        'Scan Qr',
                        style: TextStyle(fontSize: 8.0),
                      ),
                    )
                  ],
                ),
              ),
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
          activeIcon: Icon(
            Icons.home,
            color: Colors.green,
          ),
          icon: Icon(
            Icons.home,
            color: Colors.grey,
          ),
          title: Text("Beranda", style: TextStyle(color: Colors.black)),
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(
            Icons.home,
            color: Colors.green,
          ),
          icon: Icon(
            Icons.home,
            color: Colors.grey,
          ),
          title: Text('Transfer', style: TextStyle(color: Colors.black)),
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(
            Icons.close,
          ),
          icon: Icon(
            Icons.close,
            color: Colors.white,
          ),
          title: Text(
            'Lainnya',
            style: TextStyle(color: Colors.white),
          ),
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(
            Icons.assignment,
            color: Colors.green,
          ),
          icon: Icon(
            Icons.assignment,
            color: Colors.grey,
          ),
          title: Text('Histori', style: TextStyle(color: Colors.black)),
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(
            Icons.assignment,
            color: Colors.green,
          ),
          icon: Icon(
            Icons.assignment,
            color: Colors.grey,
          ),
          title: Text('Profil', style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}
