import 'package:ansor_build/src/screen/beranda/beranda_screen.dart';
import 'package:ansor_build/src/screen/ppob/pulsa/pascabayar/pulsa_screen_pasca.dart';
import 'package:ansor_build/src/screen/register/register.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String Register = '/src/screen/register/register.dart';

  static const String Home = '/src/screen/beranda/beranda_screen.dart';
  
  static const String Pascabayar = '/src/screen/ppob/pulsa/pascabayar';
  static const String Detail = '/detail';
  

  static Map<String, WidgetBuilder> getRoutes() {
    return {      
      Routes.Pascabayar: (context) => PulsaPascaPage(),
      Routes.Register: (context) => RegisterPage(),
      Routes.Home: (context) => BerandaPage(),
    };
  }
}