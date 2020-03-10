import 'dart:convert';

PostLogin loginFromJson(String str) => PostLogin.fromJson(json.decode(str));
String loginToJson(PostLogin data) => json.encode(data.toJson());

class PostLogin{
  String sessionId;
  String no_hp;
  String password;

  PostLogin({
    this.sessionId,
    this.no_hp,
    this.password
  });

  factory PostLogin.fromJson(Map<String, dynamic> json) => PostLogin(
    sessionId: json["sessionId"],
    no_hp: json["no_hp"],
    password: json["password"]
  );

  Map<String, dynamic> toJson() =>{
    "sessionId": sessionId,
    "no_hp": no_hp,
    "password": password
  };
}

