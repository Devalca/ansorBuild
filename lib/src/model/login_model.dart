import 'dart:convert';

PostLogin loginFromJson(String str) => PostLogin.fromJson(json.decode(str));
String loginToJson(PostLogin data) => json.encode(data.toJson());

class PostLogin{
  int walletId;
  int userId;
  String no_hp;
  String password;

  PostLogin({
    this.walletId,
    this.userId,
    this.no_hp,
    this.password
  });

  factory PostLogin.fromJson(Map<String, dynamic> json) => PostLogin(
    walletId: json["walletId"],
    userId: json["userId"],
    no_hp: json["no_hp"],
    password: json["password"]
  );

  Map<String, dynamic> toJson() =>{
    "walletId": walletId,
    "userId": userId,
    "no_hp": no_hp,
    "password": password
  };
}

