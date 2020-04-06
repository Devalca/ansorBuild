import 'package:ansor_build/src/screen/beranda/landing_screen.dart';
import 'package:ansor_build/src/screen/login/login.dart';
import 'package:ansor_build/src/screen/register/register.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String LoginScreen = '/src/screen/login/login.dart';
  static const String RegisterScreen = '/src/screen/register/register.dart';
  static const String LandingScreen = '/src/screen/beranda/landing_screen.dart';

  static Map<String, WidgetBuilder> getRoutes() {
    return {      
      Routes.LoginScreen: (context) => Login(), 
      Routes.RegisterScreen: (context) => RegisterPage(),
      Routes.LandingScreen: (context) => LandingPage(),
    };
  }
}