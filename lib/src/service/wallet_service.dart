import 'dart:convert';

import 'package:ansor_build/src/model/wallet_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WalletService {
// String baseUrl = "http://192.168.10.11:3000";
// String baseUrl = "https://afternoon-waters-38775.herokuapp.com";
   String baseUrl = "http://103.9.125.18:3000";

    Future<Wallet> getSaldo() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String url = prefs.getString("walletId");

      var response = await http.get(
        '$baseUrl/users/wallet/$url',
        headers: {"accept": "application/json"},
      );
      if (response.statusCode == 200) {
        return Wallet.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load post');
      }
    }
  
}