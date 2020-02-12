import 'package:flutter/material.dart';

import 'src/screen/launcher_screen.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ansorBuld',
      theme: ThemeData(

      ),
      home: LauncherPage(),   
    );
  }
}