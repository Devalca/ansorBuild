import 'dart:async' show Future;
import 'dart:async';
import 'package:ansor_build/src/model/katalog_model.dart';
import 'package:http/http.dart' as http;


class KatalogService {
  // String baseUrl = "https://afternoon-waters-38775.herokuapp.com";
  // String baseUrl = "http://192.168.10.11:3000";
  String baseUrl = "http://103.9.125.18:3000";

   Future<Katalog> getKatalog() async {
    var response = await http.get(
      '$baseUrl/master-data/katalog-produk',
      headers: {"accept": "application/json"},
    );
    if (response.statusCode == 200) {
      return katalogFromJson(response.body);
    } else {
      return null;
    }
  }
}