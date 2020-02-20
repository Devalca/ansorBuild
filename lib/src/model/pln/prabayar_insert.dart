import 'package:flutter/foundation.dart';

class PrabayarInsert {
  String noMeter;
  int nominal;

  PrabayarInsert(
    {
      @required this.noMeter,
      @required this.nominal
    }
  );

  Map<String, dynamic> toJson() {
    return{
      "no_meter": noMeter,
      "nominal": nominal
    };
  }
}