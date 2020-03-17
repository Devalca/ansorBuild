import 'package:ansor_build/src/screen/beranda/beranda_screen.dart';
import 'package:ansor_build/src/screen/login/login.dart';
import 'package:ansor_build/src/screen/ppob/pdam/selesai_screen.dart';
import 'package:ansor_build/src/screen/ppob/pulsa/prabayar/detail_screen.dart';
import 'package:flutter/material.dart';

import 'src/routes/routes.dart';
import 'src/screen/ppob/pulsa/main_pulsa_new.dart';
import 'src/screen/ppob/pulsa/selseai_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ansorBuld',
      theme: ThemeData(

      ),
      home: MainPulsa(),
      routes: Routes.getRoutes(),
    );
  }
}