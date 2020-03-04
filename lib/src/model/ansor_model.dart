import 'dart:convert';


PostTrans postTransFromJson(String str) => PostTrans.fromJson(json.decode(str));

String postTransToJson(PostTrans data) => json.encode(data.toJson());

class PostTrans {
    List<DataTrans> data;
    String message;

    PostTrans({
        this.data,
        this.message,
    });

    factory PostTrans.fromJson(Map<String, dynamic> json) => PostTrans(
        data: List<DataTrans>.from(json["data"].map((x) => DataTrans.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
    };
}

class DataTrans {
    int id;
    int walletId;
    int transactionId;
    String noHp;
    int nominal;
    int adminFee;
    String provider;
    String status;
    int totalHarga;
    DateTime periode;

    DataTrans({
        this.id,
        this.walletId,
        this.transactionId,
        this.noHp,
        this.nominal,
        this.adminFee,
        this.provider,
        this.status,
        this.totalHarga,
        this.periode,
    });

    factory DataTrans.fromJson(Map<String, dynamic> json) => DataTrans(
        id: json["id"],
        walletId: json["walletId"],
        transactionId: json["transactionId"],
        noHp: json["no_hp"],
        nominal: json["nominal"],
        adminFee: json["admin_fee"],
        provider: json["provider"],
        status: json["status"],
        totalHarga: json["total_harga"],
        periode: DateTime.parse(json["periode"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "walletId": walletId,
        "transactionId": transactionId,
        "no_hp": noHp,
        "nominal": nominal,
        "admin_fee": adminFee,
        "provider": provider,
        "status": status,
        "total_harga": totalHarga,
        "periode": periode.toIso8601String(),
    };
}

Album albumFromJson(String str) => Album.fromJson(json.decode(str));

String albumToJson(Album data) => json.encode(data.toJson());

class Album {
  List<DataDetail> data;
  String message;

  Album({
    this.data,
    this.message,
  });

  factory Album.fromJson(Map<String, dynamic> json) => Album(
        data: List<DataDetail>.from(json["data"].map((x) => DataDetail.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class DataDetail {
  int id;
  int walletId;
  String noHp;
  int nominal;
  int adminFee;
  String provider;
  int totalHarga;
  int transactionId;


  DataDetail({
    this.id,
    this.walletId,
    this.noHp,
    this.nominal,
    this.adminFee,
    this.provider,
    this.totalHarga,
    int transactionId

  });

  factory DataDetail.fromJson(Map<String, dynamic> json) => DataDetail(
        id: json["id"],
        walletId: json["walletId"],
        noHp: json["no_hp"],
        nominal: json["nominal"],
        adminFee: json["admin_fee"],
        provider: json["provider"],
        totalHarga: json["total_harga"],
        transactionId: json["transactionId"]
 
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "walletId": walletId,
        "no_hp": noHp,
        "nominal": nominal,
        "admin_fee": adminFee,
        "provider": provider,
        "total_harga": totalHarga,
        "transactionId" : transactionId
 
      };
}

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  int id;
  int walletId;
  String noHp;
  int nominal;
  int adminFee;
  String provider;
  int totalHarga;
  int transactionId;
  int userId;

  Post({
    this.id,
    this.walletId,
    this.noHp,
    this.nominal,
    this.adminFee,
    this.provider,
    this.totalHarga,
    this.transactionId,
    this.userId
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        walletId: json["walletId"],
        noHp: json["no_hp"],
        nominal: json["nominal"],
        adminFee: json["admin_fee"],
        provider: json["provider"],
        totalHarga: json["total_harga"],
        transactionId: json['transactionId'],
        userId: json["userId"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "walletId": walletId,
        "no_hp": noHp,
        "nominal": nominal,
        "admin_fee": adminFee,
        "provider": provider,
        "total_harga": totalHarga,
        "transactionId": transactionId,
        "userId": userId
      };
}

class Profile {
  int id;
  String name;
  String email;
  int age;

  Profile({this.id = 0, this.name, this.email, this.age});

  factory Profile.fromJson(Map<String, dynamic> map) {
    return Profile(
        id: map["id"], name: map["name"], email: map["email"], age: map["age"]);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "email": email, "age": age};
  }

  @override
  String toString() {
    return 'Profile{id: $id, name: $name, email: $email, age: $age}';
  }
}

List<Profile> profileFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Profile>.from(data.map((item) => Profile.fromJson(item)));
}

String profileToJson(Profile data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

class ScPdam {
  int id;
  String namaWilayah;
  int noPelanggan;

  ScPdam({this.id = 0, this.namaWilayah, this.noPelanggan});

  factory ScPdam.fromJson(Map<String, dynamic> map) {
    return ScPdam(
        id: map["id"],
        namaWilayah: map["nama_wilayah"],
        noPelanggan: map["no_pelanggan"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nama_wilayah": namaWilayah,
      "no_pelanggan": noPelanggan
    };
  }

  @override
  String toString() {
    return 'Wilayah{id: $id, nama_wilayah: $namaWilayah, no_pelanggan: $noPelanggan}';
  }
}

List<ScPdam> scPdamFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<ScPdam>.from(data.map((item) => ScPdam.fromJson(item)));
}

String scPdamToJson(ScPdam data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
