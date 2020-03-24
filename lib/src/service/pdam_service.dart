 
import 'dart:async' show Future;
import 'package:ansor_build/src/model/pdam_model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

    Future<NamaWilayah> getWilayah() async {
      var response = await rootBundle.loadString('lib/src/assets/apidummy/wilayah.json');
      final jsonResponse = json.decode(response);
      return NamaWilayah.fromJson(jsonResponse);
      // NamaWilayah wilayah= NamaWilayah.fromJson(jsonResponse);
      // print(wilayah.data[1].namaWilayah);
      
    }

    // Future<ProviderCall> getProvider() async {
    //   var response = await http.get(
    //     '$baseUrl/master-data/namaprovider',
    //     headers: {"accept": "application/json"},
    //   );
    //   if (response.statusCode == 200) {
    //     return providerCallFromJson(response.body);
    //   } else {
    //     return null;
    //   }
    // }