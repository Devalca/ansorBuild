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

LoginPin loginPinFromJson(String str) => LoginPin.fromJson(json.decode(str));
String loginPinToJson(LoginPin data) => json.encode(data.toJson());

class LoginPin{
  String noHp;
  int pin;
  int walletId;
  int userId;

  LoginPin({
    this.noHp,
    this.pin,
    this.walletId,
    this.userId
  });

  factory LoginPin.fromJson(Map<String, dynamic> json) => LoginPin(
    noHp: json["no_hp"],
    pin: json["pin"],
    walletId: json["walletId"],
    userId: json["userId"]
  );

  Map<String, dynamic> toJson() =>{
    "no_hp": noHp,
    "pin": pin,
    "walletId": walletId,
    "userId": userId
  };
}

PostEmail emailFromJson(String str) => PostEmail.fromJson(json.decode(str));
String emailToJson(PostEmail data) => json.encode(data.toJson());

class PostEmail{
  String email;

  PostEmail({
    this.email
  });

  factory PostEmail.fromJson(Map<String, dynamic> json) => PostEmail(
    email: json["email"]
  );

  Map<String, dynamic> toJson() =>{
    "email": email
  };
}