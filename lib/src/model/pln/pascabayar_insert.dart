import 'package:flutter/foundation.dart';

class PascaBayarInsert {
  String noMeter;

  PascaBayarInsert(
    {
      @required this.noMeter,
    }
  );

  Map<String, dynamic> toJson() {
    return{
      "no_meter": noMeter,
    };
  }
}