import 'package:ansor_build/src/screen/beranda/landing_screen.dart';
import 'package:flutter/material.dart';

import 'src/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ansorBuld',
      theme: ThemeData(
        primaryColor: Colors.green,
        primarySwatch: Colors.green
      ),
      home: LandingPage(),
      routes: Routes.getRoutes(),
    );
  }
}