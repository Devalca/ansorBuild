import 'package:ansor_build/src/screen/beranda/beranda_screen.dart';
import 'package:ansor_build/src/screen/ppob/pulsa/main_pulsa.dart';
import 'package:ansor_build/src/screen/ppob/pulsa/pascabayar/pulsa_screen_pasca.dart';
import 'package:ansor_build/src/screen/ppob/pulsa/prabayar/pulsa_screen.dart';
import 'package:flutter/material.dart';

import 'src/screen/launcher_screen.dart';
import 'src/screen/ppob/pulsa/prabayar/detail_screen.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ansorBuld',
      theme: ThemeData(

      ),
      home: BerandaPage(),   
    );
  }
}