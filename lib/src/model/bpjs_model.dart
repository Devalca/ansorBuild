import 'dart:convert';

class Bulan {
  List<DataBulan> data;
  final String message;

  Bulan({this.data, this.message});

  factory Bulan.fromJson(Map<String, dynamic> json) => Bulan(
      data:
          List<DataBulan>.from(json["data"].map((x) => DataBulan.fromJson(x))),
      message: json['message']);

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message
      };
}

class DataBulan {
  int id;
  String tanggal;
  String nama;

  DataBulan({this.id, this.tanggal, this.nama});

  factory DataBulan.fromJson(Map<String, dynamic> json) =>
      DataBulan(id: json["id"], tanggal: json["tanggal"], nama: json["nama"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "tanggal": tanggal,
        "nama": nama,
      };
}

PostKesehatan kesehatanFromJson(String str) =>
    PostKesehatan.fromJson(json.decode(str));
String kesehatanToJson(PostKesehatan data) => json.encode(data.toJson());

class PostKesehatan {
  String noVa;
  String periode;

  PostKesehatan({
    this.noVa,
    this.periode,
  });

  factory PostKesehatan.fromJson(Map<String, dynamic> json) =>
      PostKesehatan(noVa: json['noVa'], periode: json['periode']);

  Map<String, dynamic> toJson() => {"no_va": noVa, "periode": periode};
}

DetailKesehatan detailKesehatanFromJson(String str) =>
    DetailKesehatan.fromJson(json.decode(str));
String detailKesehatanToJson(DetailKesehatan data) =>
    json.encode(data.toJson());

class DetailKesehatan {
  List<DataKesehatan> data;
  String message;

  DetailKesehatan({
    this.data,
    this.message,
  });

  factory DetailKesehatan.fromJson(Map<String, dynamic> json) =>
      DetailKesehatan(
        data: List<DataKesehatan>.from(
            json["data"].map((x) => DataKesehatan.fromJson(x))),
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class DataKesehatan {
  int transactionId;
  int noVa;
  String namaPelanggan;
  int jumlahKeluarga;
  int total;
  DateTime periode;
  int jlhBulan;

  DataKesehatan(
      {this.transactionId,
      this.noVa,
      this.namaPelanggan,
      this.jumlahKeluarga,
      this.total,
      this.periode,
      this.jlhBulan});

  factory DataKesehatan.fromJson(Map<String, dynamic> json) => DataKesehatan(
      transactionId: json['transactionId'],
      noVa: json['no_va'],
      namaPelanggan: json['nama_pelanggan'],
      jumlahKeluarga: json['jlh_keluarga'],
      total: json['total'],
      periode: DateTime.parse(json['periode']),
      jlhBulan: json['jlh_bulan']);

  Map<String, dynamic> toJson() => {
        "transactionId": transactionId,
        "no_va": noVa,
        "nama_pelanggan": namaPelanggan,
        "jlh_keluarga": jumlahKeluarga,
        "total": total,
        "periode": periode,
        "jlh_bulan": jlhBulan
      };
}

PostPembayaran pembayaranFromJson(String str) =>
    PostPembayaran.fromJson(json.decode(str));
String pembayaranToJson(PostPembayaran data) => json.encode(data.toJson());

class PostPembayaran {
  int userId;
  int walletId;
  String transactionId;
  String noVa;
  String periode;

  PostPembayaran({
    this.userId,
    this.walletId,
    this.transactionId,
    this.noVa,
    this.periode,
  });

  factory PostPembayaran.fromJson(Map<String, dynamic> json) => PostPembayaran(
      userId: json['userId'],
      walletId: json['walletId'],
      transactionId: json['transactionId'],
      noVa: json['no_va'],
      periode: json['periode']);

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "walletId": walletId,
        "transactionId": transactionId,
        "no_va": noVa,
        "periode": periode
      };
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
  int userId;
  int walletId;
  int noVa;
  String namaPelanggan;
  int jumlahKeluarga;
  int total;
  DateTime periode;
  int jlhBulan;
  String noTransaksi;
  DateTime createdAt;

  DataBerhasil(
      {this.id,
      this.userId,
      this.walletId,
      this.noVa,
      this.namaPelanggan,
      this.jumlahKeluarga,
      this.total,
      this.periode,
      this.jlhBulan,
      this.noTransaksi,
      this.createdAt});

  factory DataBerhasil.fromJson(Map<String, dynamic> json) => DataBerhasil(
        id: json['id'],
        userId: json['userId'],
        walletId: json['walletId'],
        noVa: json['no_va'],
        namaPelanggan: json['nama_pelanggan'],
        jumlahKeluarga: json['jlh_keluarga'],
        total: json['total'],
        periode: DateTime.parse(json['periode']),
        jlhBulan: json['jlh_bulan'],
        noTransaksi: json['no_transaksi'],
        createdAt: DateTime.parse(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "walletId": walletId,
        "no_va": noVa,
        "nama_pelanggan": namaPelanggan,
        "jlh_keluarga": jumlahKeluarga,
        "total": total,
        "periode": periode,
        "jlh_bulan": jlhBulan,
        "no_transaksi": noTransaksi,
        "createdAt": createdAt
      };
}

class Bayar {
  List<DataBayar> data;
  final String message;

  Bayar({this.data, this.message});

  factory Bayar.fromJson(Map<String, dynamic> json) => Bayar(
      data:
          List<DataBayar>.from(json["data"].map((x) => DataBayar.fromJson(x))),
      message: json['message']);

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message
      };
}

class DataBayar {
  int id;
  String periodeByr;
  String nama;

  DataBayar({this.id, this.periodeByr, this.nama});

  factory DataBayar.fromJson(Map<String, dynamic> json) => DataBayar(
      id: json["id"], periodeByr: json["periode_byr"], nama: json["nama"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "periode_byr": periodeByr,
        "nama": nama,
      };
}
