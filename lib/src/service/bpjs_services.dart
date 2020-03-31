import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ansor_build/src/model/bpjs_model.dart';

class BpjsServices {
  String url = "http://103.9.125.18:3000";

  Future<Bulan> fetchBulan() async {
    final response = await http.get(
      '$url/master-data/bulanbayar',
      headers: {"accept": "application/json"},
    );

    if (response.statusCode == 200) {
      return Bulan.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Bulan');
    }
  }
}
