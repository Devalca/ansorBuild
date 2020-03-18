import 'dart:convert';
// import 'dart:ffi';
import 'dart:wasm';

PostPascabayar postFromJson(String str) => PostPascabayar.fromJson(json.decode(str));
String postToJson(PostPascabayar data) => json.encode(data.toJson());

class PostPascabayar {
  String transactionId;
  String noMeter;
  String status;
  int userId;
  int walletId;

  PostPascabayar({
    this.transactionId,
    this.noMeter,
    this.status,
    this.userId,
    this.walletId
  });

  factory PostPascabayar.fromJson(Map<String, dynamic> item) => PostPascabayar(
    transactionId: item['transactionId'],
    noMeter: item['no_meter'],
    status: item['status'],
    userId: item['userId'],
    walletId: item['walletId']
  );

  Map<String, dynamic> toJson() => {
    "transactionId": transactionId,
    "no_meter": noMeter,
    "status": status,
    "userId": userId,
    "walletId": walletId
  };
}

Album albumFromJson(String str) => Album.fromJson(json.decode(str));
String albumToJson(Album data) => json.encode(data.toJson());

class Album {
  // List<DataDetail> data;
  // final String message;
  int id;
  String no_meter;
  String nama_pelanggan;
  String status;
  String tarif;
  String daya;
  int nominal;
  int total;
  DateTime createdAt;

  Album({
    // this.data, 
    // this.message,
    this.id,
    this.no_meter,
    this.nama_pelanggan,
    this.status,
    this.tarif,
    this.daya,
    this.nominal,
    this.total,
    this.createdAt
  });

  factory Album.fromJson(Map<String, dynamic> json) => Album(
    // data: List<DataDetail>.from(json["data"].map((x) => DataDetail.fromJson(x))),
    // message: json['message']
    id: json["id"],
    no_meter: json["no_meter"],
    nama_pelanggan: json["nama_pelanggan"],
    status: json["status"],
    tarif: json["tarif"],
    daya: json["daya"],
    nominal: json["nominal"],
    total: json["total"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson()=>{
    // "data": List<DataDetail>.from(data.map((x) => x.toJson())),
    // "message": message
    "id": id,
    "no_meter": no_meter,
    "nama_pelanggan": nama_pelanggan,
    "status": status,
    "tarif": tarif,
    "daya": daya,
    "nominal": nominal,
    "total": total,
    "createdAt": createdAt
  };
}

class DataDetail{
  int id;
  String no_meter;
  String nama_pelanggan;
  String status;
  String tarif;
  String daya;
  int nominal;
  int total;
  DateTime createdAt;

  DataDetail({
    this.id,
    this.no_meter,
    this.nama_pelanggan,
    this.status,
    this.tarif,
    this.daya,
    this.nominal,
    this.total,
    this.createdAt
  });

  factory DataDetail.fromJson(Map<String, dynamic> json) => DataDetail(
    id: json["id"],
    no_meter: json["no_meter"],
    nama_pelanggan: json["nama_pelanggan"],
    status: json["status"],
    tarif: json["tarif"],
    daya: json["daya"],
    nominal: json["nominal"],
    total: json["total"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson()=>{
    "id": id,
    "no_meter": no_meter,
    "nama_pelanggan": nama_pelanggan,
    "status": status,
    "tarif": tarif,
    "daya": daya,
    "nominal": nominal,
    "total": total,
    "createdAt": createdAt
  };
}

PostPascaTransaction pascaTransactionFromJson(String str) => PostPascaTransaction.fromJson(json.decode(str));
String pascaTransactionToJson(PostPascaTransaction data) => json.encode(data.toJson());

class PostPascaTransaction{
  String transactionId;
  int id;
  String noMeter;
  String namaPelanggan;
  String status;
  String tarif;
  String daya;
  int nominal;
  int total;
  String noToken;
  String noTransaksi;
  String createdAt;
  int userId;
  int walletId;

  PostPascaTransaction({
    this.transactionId,
    this.id,
    this.noMeter,
    this.namaPelanggan,
    this.status,
    this.tarif,
    this.daya,
    this.nominal,
    this.total,
    this.noToken,
    this.noTransaksi,
    this.createdAt,
    this.userId,
    this.walletId
  });

  factory PostPascaTransaction.fromJson(Map<String, dynamic> json) => PostPascaTransaction(
    transactionId: json["transactionId"],
    id: json["id"],
    noMeter: json["no_meter"],
    namaPelanggan: json["nama_pelanggan"],
    status: json["status"],
    tarif: json["tarif"],
    daya: json["daya"],
    nominal: json["nominal"],
    total: json["total"],
    noToken: json["no_token"],
    noTransaksi: json["no_transaksi"],
    createdAt: json["createdAt"],
    userId: json["userId"],
    walletId: json["walletId"]
  );

  Map<String, dynamic> toJson()=>{
    "transactionId": transactionId,
    "id": id,
    "no_meter": noMeter,
    "nama_pelanggan": namaPelanggan,
    "status": status,
    "tarif": tarif,
    "daya": daya,
    "nominal": nominal,
    "total": total,
    "no_token": noToken,
    "no_transaksi": noTransaksi,
    "createdAt": createdAt,
    "userId": userId,
    "walletId": walletId
  };
}

Detail detailFromJson(String str) => Detail.fromJson(json.decode(str));
String detailToJson(Detail data) => json.encode(data.toJson());

class Detail {
  int id;
  String noMeter;
  String namaPelanggan;
  String status;
  String tarif;
  String daya;
  int nominal;
  int total;
  double totalKwh;
  String noToken;
  String noTransaksi;
  DateTime createdAt;

  Detail({
    this.id,
    this.noMeter,
    this.namaPelanggan,
    this.status,
    this.tarif,
    this.daya,
    this.nominal,
    this.total,
    this.totalKwh,
    this.noToken,
    this.noTransaksi,
    this.createdAt
  });

  factory Detail.fromJson(Map<String, dynamic> item) => Detail(
    id: item['id'],
    noMeter: item['no_meter'],
    namaPelanggan: item['nama_pelanggan'],
    status: item['status'],
    tarif: item['tarif'],
    daya: item['daya'],
    nominal: item['nominal'],
    total: item['total'],
    totalKwh: item['total_kwh'].toDouble(),
    noToken: item['no_token'],
    noTransaksi: item['no_transaksi'],
    createdAt: DateTime.parse(item["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "no_meter": noMeter,
    "nama_pelanggan": namaPelanggan,
    "status": status,
    "tarif": tarif,
    "daya": daya,
    "nominal": nominal,
    "total": total,
    "total_kwh": totalKwh,
    "no_token": noToken,
    "no_transaksi": noTransaksi,
    "createdAt": createdAt
  };
}

PostPrabayar prabayarFromJson(String str) => PostPrabayar.fromJson(json.decode(str));
String prabayarToJson(PostPrabayar data) => json.encode(data.toJson());

class PostPrabayar {
  int id;
  String noMeter;
  String namaPelanggan;
  String status;
  String tarif;
  String daya;
  int nominal;
  int total;
  String createdAt;
  int userId;
  int walletId;

  PostPrabayar({ 
    this.id,
    this.noMeter,
    this.namaPelanggan,
    this.status,
    this.tarif,
    this.daya,
    this.nominal,
    this.total,
    this.createdAt,
    this.userId, 
    this.walletId 
  });

  factory PostPrabayar.fromJson(Map<String, dynamic> json) => PostPrabayar(
    id: json["id"],
    noMeter: json["no_meter"],
    namaPelanggan: json["nama_pelanggan"],
    status: json["status"],
    tarif: json["tarif"],
    daya: json["daya"],
    nominal: json["nominal"],
    total: json["total"],
    createdAt: json["createdAt"],
    userId: json['userId'],
    walletId: json['walletId']
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "no_meter": noMeter,
    "nama_pelanggan": namaPelanggan,
    "status": status,
    "tarif": tarif,
    "daya": daya,
    "nominal": nominal,
    "total": total,
    "createdAt": createdAt,
    "userId": userId,
    "walletId": walletId
  };
}

PostPraTransaction praTransactionFromJson(String str) => PostPraTransaction.fromJson(json.decode(str));
String praTransactionToJson(PostPraTransaction data) => json.encode(data.toJson());

class PostPraTransaction {
  String transactionId;
  int id;
  String noMeter;
  String namaPelanggan;
  String status;
  String tarif;
  String daya;
  int nominal;
  int total;
  String noToken;
  String noTransaksi;
  String createdAt;
  int userId;
  int walletId;

  PostPraTransaction({ 
    this.transactionId,
    this.id,
    this.noMeter,
    this.namaPelanggan,
    this.status,
    this.tarif,
    this.daya,
    this.nominal,
    this.total,
    this.noToken,
    this.noTransaksi,
    this.createdAt,
    this.userId, 
    this.walletId 
  });

  factory PostPraTransaction.fromJson(Map<String, dynamic> json) => PostPraTransaction(
    transactionId: json["transactionId"],
    id: json["id"],
    noMeter: json["no_meter"],
    namaPelanggan: json["nama_pelanggan"],
    status: json["status"],
    tarif: json["tarif"],
    daya: json["daya"],
    nominal: json["nominal"],
    total: json["total"],
    noToken: json["no_token"],
    noTransaksi: json["no_transaksi"],
    createdAt: json["createdAt"],
    userId: json['userId'],
    walletId: json['walletId']
  );

  Map<String, dynamic> toJson() => {
    "transactionId": transactionId,
    "id": id,
    "no_meter": noMeter,
    "nama_pelanggan": namaPelanggan,
    "status": status,
    "tarif": tarif,
    "daya": daya,
    "nominal": nominal,
    "total": total,
    "no_token": noToken,
    "no_transaksi": noTransaksi,
    "createdAt": createdAt,
    "userId": userId,
    "walletId": walletId
  };
}