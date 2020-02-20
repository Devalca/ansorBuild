import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:ansor_build/src/model/pln/api_response.dart';
import 'package:ansor_build/src/model/pln/pascabayar_insert.dart';
import 'package:ansor_build/src/model/pln/pembayaran.dart';

class PascaBayarServices {

  static const API = 'http://192.168.10.11:3000/';
  static const headers = {
    'Content-Type': 'application/json'
  };

  Future<APIResponse<dynamic>> createPascabayar(PascaBayarInsert item){
    return http.post(API + 'ppob/pln/pascabayar',  headers: headers, body: json.encode(item.toJson()))
    .then((data){
      if(data.statusCode == 200){
        Map id = jsonDecode(data.body);
        final getId = id['transactionId'];
        print("getId");
        print(getId);

        getDetail(getId);
        
        return APIResponse<dynamic>( 
          data: true
        );
      }else{
        return APIResponse<dynamic>(
          error: true,
          errorMessage: 'An error occured api'
        );
      }
    })
    .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured catch'));
  }

  Future<APIResponse<List<Pembayaran>>> getDetail(String getId){
    return http.get(API + 'ppob/pln/' + getId,  headers: headers)
    .then((data){
      if(data.statusCode == 200){
        final jsonData = json.decode(data.body);
        final getData = <Pembayaran>[];
        for (var item in jsonData){
          getData.add(Pembayaran.fromJson(item));
        }
        return APIResponse<List<Pembayaran>>(
          data: getData
        );
      }
      return APIResponse<Pembayaran>(
        error: true,
        errorMessage: 'An error occured'
      );
    })
    .catchError((_) => APIResponse<Pembayaran>(error: true, errorMessage: 'An error occured'));
  }
}