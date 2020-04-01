import 'package:ansor_build/src/screen/beranda/landing_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String LandingScreen = '/src/screen/beranda/landing_screen.dart';

  static Map<String, WidgetBuilder> getRoutes() {
    return {      
      Routes.LandingScreen: (context) => LandingPage(),
    };
  }
}