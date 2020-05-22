import 'dart:convert';

PostSesama postFromJson(String str) => PostSesama.fromJson(json.decode(str));
String postToJson(PostSesama data) => json.encode(data.toJson());

class PostSesama {
  int nominal_trf;
  String no_penerima;
  String userId;
  String walletId;

  PostSesama({this.nominal_trf, this.no_penerima, this.userId, this.walletId});

  factory PostSesama.fromJson(Map<String, dynamic> item) => PostSesama(
      nominal_trf: item['nominal_trf'],
      no_penerima: item['no_penerima'],
      userId: item['userId'],
      walletId: item['walletId']);

  Map<String, dynamic> toJson() => {
        "nominal_trf": nominal_trf,
        "no_penerima": no_penerima,
        "userId": userId,
        "walletId": walletId
      };
}

PostBank postBankFromJson(String str) => PostBank.fromJson(json.decode(str));
String postBankToJson(PostBank data) => json.encode(data.toJson());

class PostBank {
  String userId;
  String walletId;
  int nominal_trf;
  String no_penerima;
  String label;

  PostBank(
      {this.userId,
      this.walletId,
      this.nominal_trf,
      this.no_penerima,
      this.label});

  factory PostBank.fromJson(Map<String, dynamic> item) => PostBank(
      userId: item['userId'],
      walletId: item['walletId'],
      nominal_trf: item['nominal_trf'],
      no_penerima: item['no_penerima'],
      label: item['label']);

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "walletId": walletId,
        "nominal_trf": nominal_trf,
        "no_penerima": no_penerima,
        "label": label
      };
}

PutTransaksi putTransaksiFromJson(String str) =>
    PutTransaksi.fromJson(json.decode(str));
String putTransaksiToJson(PutTransaksi data) => json.encode(data.toJson());

class PutTransaksi {
  String userId;
  String walletId;
  int pin;

  PutTransaksi({this.userId, this.walletId, this.pin});

  factory PutTransaksi.fromJson(Map<String, dynamic> item) => PutTransaksi(
        userId: item['userId'],
        walletId: item['walletId'],
        pin: item['pin'],
      );

  Map<String, dynamic> toJson() =>
      {"userId": userId, "walletId": walletId, "pin": pin};
}

Berhasil berhasilFromJson(String str) => Berhasil.fromJson(json.decode(str));
String berhasilToJson(Berhasil data) => json.encode(data.toJson());

class Berhasil {
  List<DataBerhasil> data;
  String message;

  Berhasil({
    this.data,
    this.message,
  });

  factory Berhasil.fromJson(Map<String, dynamic> json) => Berhasil(
        data: List<DataBerhasil>.from(
            json["data"].map((x) => DataBerhasil.fromJson(x))),
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class DataBerhasil {
  int id;
  int walletId;
  int userId;
  String nama_penerima;
  String no_penerima;
  int nominal_trf;
  int admin_fee;
  int total;
  String no_transaksi;
  DateTime tgl_trf;
  String sumber_dana;
  String status;
  String label;

  DataBerhasil(
      {this.id,
      this.walletId,
      this.userId,
      this.nama_penerima,
      this.no_penerima,
      this.nominal_trf,
      this.admin_fee,
      this.total,
      this.no_transaksi,
      this.tgl_trf,
      this.sumber_dana,
      this.status,
      this.label});

  factory DataBerhasil.fromJson(Map<String, dynamic> json) => DataBerhasil(
        id: json['id'],
        walletId: json['walletId'],
        userId: json['userId'],
        nama_penerima: json['nama_penerima'],
        no_penerima: json['no_penerima'],
        nominal_trf: json['nominal_trf'],
        admin_fee: json['admin_fee'],
        total: json['total'],
        no_transaksi: json['no_transaksi'],
        tgl_trf: DateTime.parse(json['tgl_trf']),
        sumber_dana: json['sumber_dana'],
        status: json['status'],
        label: json['label'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "walletId": walletId,
        "userId": userId,
        "nama_penerima": nama_penerima,
        "no_penerima": no_penerima,
        "nominal_trf": nominal_trf,
        "admin_fee": admin_fee,
        "total": total,
        "no_transaksi": no_transaksi,
        "tgl_trf": tgl_trf,
        "sumber_dana": sumber_dana,
        "status": status,
        "label": label
      };
}
