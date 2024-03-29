import 'package:ansor_build/src/screen/histori/histori_main.dart';
import 'package:ansor_build/src/screen/launcher/launcher_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
