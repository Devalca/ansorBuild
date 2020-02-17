
import 'dart:convert';
import 'dart:io';

import 'package:ansor_build/src/model/ansor_model.dart';
import 'package:ansor_build/src/response/ansor_response.dart';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart' as http;

class ApiService {

String baseUrl = "http://192.168.10.11:3000/ppob";

Future<List<Post>> getAllPost() async {
  final postResponse = await http.get(baseUrl);
  if(postResponse.statusCode == 200) {
    print(postResponse.body);
  } else {
    print(postResponse.statusCode);
  }
}

Future<Post> getPost() async {
  final postResponse = await http.get('$baseUrl/pulsa/31',
  headers: {"accept": "application/json"},
  );
  return postFromJson(postResponse.body);
}

// Future<bool> createPost(Post post) async{
//   final response = await http.post('$baseUrl/pulsa/prabayar',
//       headers: {
//         HttpHeaders.contentTypeHeader: 'application/json'
//       },
//       body: postToJson(post)
//   );
//   if (response.statusCode == 200) {
//     return true;
//   } else {
//     return false;
//   }
// }

Future<Post> createPost(Post post) async{
  final response = await http.post('$baseUrl/pulsa/prabayar',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json'
      },
      body: postToJson(post)
  );
  return postFromJson(response.body);
}

// Future<http.Response> createPost(Post post) async {
//   final createResponse = await http.post('$baseUrl/pulsa/prabayar',
//   headers: {
//     HttpHeaders.contentTypeHeader: 'application/json',
//     HttpHeaders.authorizationHeader: ''
//   },
//   body: postToJson(post)
//   );
//   return createResponse;
// }

}


// class ApiService {

//   final String baseUrl = "http://192.168.10.31:3000/master-data";
//   final String ppobUrl = "http://192.168.10.31:3000/ppob";
//   Client client = Client();

//   Future<bool> createPdam(ScPdam data) async {
//   final response = await client.post(
//     "$baseUrl/pdam",
//     headers: {"content-type": "application/json"},
//     body: scPdamToJson(data),
//   );
//   if (response.statusCode == 201) {
//     print(response.body);
//     return true;
//   } else {
//     return false;
//   }
// }
// }

// class ApiService {
//   final String baseUrl = "http://192.168.10.11:3000/ppob/";
//   KontakResponse r = new KontakResponse();

//   Future<Kontak> create(Kontak kontak) async {
//     Map<String, dynamic> inputMap = {
//       'no_hp': kontak.no_hp,
//       'nominal': kontak.nominal,
//     };
//     final response = await http.post(
//       baseUrl + "pulsa/prabayar",
//       headers: {
//         "Accept": "application/json",
//       },
//       body: inputMap,
//     );

//     r = KontakResponse.fromJson(json.decode(response.body.toString()));
//     if (response.statusCode == 200) {
//       Kontak data = r.data[0];
//       return data;
//     } else {
//       return null;
//     }
//   }

  //  Future<Kontak> update(Kontak kontak) async {
  //   Map<String, dynamic> inputMap = {
  //     'no_hp': kontak.no_hp,
  //     'nominal': kontak.nominal,
  //     'id': kontak.id
  //   };
  //   final response = await http.post(
  //     baseUrl + "pulsa/prabayar",
  //     headers: {
  //       "Accept": "application/json",
  //       "Content-Type": "application/x-www-form-urlencoded",
  //       "authorization": basicAuth
  //     },
  //     body: inputMap,
  //   );
 
  //   r = KontakResponse.fromJson(json.decode(response.body));
  //   if (response.statusCode == 200) {
  //     Kontak data = r.data[0];
  //     return data;
  //   } else {
  //     return null;
  //   }
  // }