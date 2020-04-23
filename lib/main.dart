import 'package:ansor_build/src/coba.dart';
import 'package:ansor_build/src/screen/beranda/landing_screen.dart';
import 'package:ansor_build/src/screen/launcher/launcher_screen.dart';
import 'package:ansor_build/src/screen/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/routes/routes.dart';
import 'src/service/permissions_service.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
    
  @override
  Widget build(BuildContext context) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    PermissionsService().requestContactsPermission(onPermissionDenied: () {
      print('Permission has been denied');
    });
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ansorBuld',
      theme: ThemeData(
        primaryColor: Colors.green,
        primarySwatch: Colors.green
      ),
      home: LauncherPage(),
      routes: Routes.getRoutes(),
    );
  }
}