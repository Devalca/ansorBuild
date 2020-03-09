import 'package:ansor_build/src/screen/ppob/pulsa/pascabayar/pulsa_screen_pasca.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String Pascabayar = '/src/screen/ppob/pulsa/pascabayar';
  static const String Detail = '/detail';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      Routes.Pascabayar: (context) => PulsaPascaPage(),
    };
  }
}