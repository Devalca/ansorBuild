import 'package:ansor_build/src/screen/login/login.dart';
import 'package:flutter/material.dart';

import 'src/routes/routes.dart';
import 'src/screen/ppob/pulsa/main_pulsa_new.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ansorBuld',
      theme: ThemeData(

      ),
      home: Login(),
      routes: Routes.getRoutes(),
    );
  }
}