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

  PostKesehatan({this.noVa, this.periode});

  factory PostKesehatan.fromJson(Map<String, dynamic> json) => PostKesehatan(
        noVa: json['noVa'],
        periode: json['periode'],
      );

  Map<String, dynamic> toJson() => {
        "no_va": noVa,
        "periode": periode,
      };
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
  int totalTagihan;
  int adminFee;
  int total;
  DateTime periode;
  int jlhBulan;

  DataKesehatan(
      {this.transactionId,
      this.noVa,
      this.namaPelanggan,
      this.jumlahKeluarga,
      this.totalTagihan,
      this.adminFee,
      this.total,
      this.periode,
      this.jlhBulan});

  factory DataKesehatan.fromJson(Map<String, dynamic> json) => DataKesehatan(
      transactionId: json['transactionId'],
      noVa: json['no_va'],
      namaPelanggan: json['nama_pelanggan'],
      jumlahKeluarga: json['jlh_keluarga'],
      totalTagihan: json['total_tagihan'],
      adminFee: json['admin_fee'],
      total: json['total'],
      periode: DateTime.parse(json['periode']),
      jlhBulan: json['jlh_bulan']);

  Map<String, dynamic> toJson() => {
        "transactionId": transactionId,
        "no_va": noVa,
        "nama_pelanggan": namaPelanggan,
        "jlh_keluarga": jumlahKeluarga,
        "total_tagihan": totalTagihan,
        "admin_fee": adminFee,
        "total": total,
        "periode": periode,
        "jlh_bulan": jlhBulan
      };
}

PostPembayaran pembayaranFromJson(String str) =>
    PostPembayaran.fromJson(json.decode(str));
String pembayaranToJson(PostPembayaran data) => json.encode(data.toJson());

class PostPembayaran {
  String userId;
  String walletId;
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
  int totalTagihan;
  int adminFee;
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
      this.totalTagihan,
      this.adminFee,
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
        totalTagihan: json['total_tagihan'],
        adminFee: json['admin_fee'],
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
        "total_tagihan": totalTagihan,
        "admin_fee": adminFee,
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
  int periodeByr;
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

PostKetenagakerjaan ketenagakerjaanFromJson(String str) =>
    PostKetenagakerjaan.fromJson(json.decode(str));
String ketenagakerjaanToJson(PostKetenagakerjaan data) =>
    json.encode(data.toJson());

class PostKetenagakerjaan {
  int periodeByr;
  String noKtp;

  PostKetenagakerjaan(
      {this.periodeByr, this.noKtp});

  factory PostKetenagakerjaan.fromJson(Map<String, dynamic> json) =>
      PostKetenagakerjaan(
        periodeByr: json['periode_byr'],
        noKtp: json['no_ktp'],
      );

  Map<String, dynamic> toJson() => {
        "periode_byr": periodeByr,
        "no_ktp": noKtp,
      };
}

DetailKetenagakerjaan detailKetenagakerjaanFromJson(String str) =>
    DetailKetenagakerjaan.fromJson(json.decode(str));
String detailKetenagakerjaanToJson(DetailKetenagakerjaan data) =>
    json.encode(data.toJson());

class DetailKetenagakerjaan {
  List<DataKetenagakerjaan> data;
  String message;

  DetailKetenagakerjaan({
    this.data,
    this.message,
  });

  factory DetailKetenagakerjaan.fromJson(Map<String, dynamic> json) =>
      DetailKetenagakerjaan(
        data: List<DataKetenagakerjaan>.from(
            json["data"].map((x) => DataKetenagakerjaan.fromJson(x))),
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class DataKetenagakerjaan {
  int transactionId;
  String noKtp;
  String namaPemilik;
  String cabang;
  int jkk;
  int jkm;
  int jht;
  int jp;
  int periodeByr;
  int totalTagihan;
  int adminFee;
  int total;
  DateTime createdAt;

  DataKetenagakerjaan(
      {this.transactionId,
      this.noKtp,
      this.namaPemilik,
      this.cabang,
      this.jkk,
      this.jkm,
      this.jht,
      this.jp,
      this.periodeByr,
      this.totalTagihan,
      this.adminFee,
      this.total,
      this.createdAt});

  factory DataKetenagakerjaan.fromJson(Map<String, dynamic> json) =>
      DataKetenagakerjaan(
        transactionId: json['transactionId'],
        noKtp: json['no_ktp'],
        namaPemilik: json['nama_pemilik'],
        cabang: json['cabang'],
        jkk: json['jkk'],
        jkm: json['jkm'],
        jht: json['jht'],
        jp: json['jp'],
        periodeByr: json['periode_byr'],
        totalTagihan: json['total_tagihan'],
        adminFee: json['admin_fee'],
        total: json['total'],
        createdAt: DateTime.parse(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        "transactionId": transactionId,
        "no_ktp": noKtp,
        "nama_pemilik": namaPemilik,
        "cabang": cabang,
        "jkk": jkk,
        "jkm": jkm,
        "jht": jht,
        "periode_byr": periodeByr,
        "total_tagihan": totalTagihan,
        "admin_fee": adminFee,
        "total": total,
        "createdAt": createdAt
      };
}

PostBayarKerja bayarKerjaFromJson(String str) =>
    PostBayarKerja.fromJson(json.decode(str));
String bayarKerjaToJson(PostBayarKerja data) => json.encode(data.toJson());

class PostBayarKerja {
  String periodeByr;
  String noKtp;
  String userId;
  String walletId;
  String transactionId;

  PostBayarKerja({
    this.periodeByr,
    this.noKtp,
    this.userId,
    this.walletId,
    this.transactionId,
  });

  factory PostBayarKerja.fromJson(Map<String, dynamic> json) => PostBayarKerja(
      periodeByr: json['periode_byr'],
      noKtp: json['no_ktp'],
      userId: json['userId'],
      walletId: json['walletId'],
      transactionId: json['transactionId']);

  Map<String, dynamic> toJson() => {
        "periode_byr": periodeByr,
        "no_ktp": noKtp,
        "userId": userId,
        "walletId": walletId,
        "transactionId": transactionId
      };
}

BerhasilKerja berhasilKerjaFromJson(String str) =>
    BerhasilKerja.fromJson(json.decode(str));
String berhasilKerjaToJson(BerhasilKerja data) => json.encode(data.toJson());

class BerhasilKerja {
  List<DataBerhasilKerja> data;
  String message;

  BerhasilKerja({
    this.data,
    this.message,
  });

  factory BerhasilKerja.fromJson(Map<String, dynamic> json) => BerhasilKerja(
        data: List<DataBerhasilKerja>.from(
            json["data"].map((x) => DataBerhasilKerja.fromJson(x))),
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class DataBerhasilKerja {
  int id;
  int userId;
  int walletId;
  int transactionId;
  String noKtp;
  String namaPemilik;
  int periodeByr;
  int jkm;
  int jkk;
  int jht;
  int jp;
  int adminFee;
  int totalTagihan;
  int total;
  String noTransaksi;
  DateTime createdAt;

  DataBerhasilKerja(
      {this.id,
      this.userId,
      this.walletId,
      this.transactionId,
      this.noKtp,
      this.namaPemilik,
      this.periodeByr,
      this.jkm,
      this.jkk,
      this.jht,
      this.jp,
      this.adminFee,
      this.totalTagihan,
      this.total,
      this.noTransaksi,
      this.createdAt});

  factory DataBerhasilKerja.fromJson(Map<String, dynamic> json) =>
      DataBerhasilKerja(
        id: json['id'],
        userId: json['userId'],
        walletId: json['walletId'],
        transactionId: json['transactionId'],
        noKtp: json['no_ktp'],
        namaPemilik: json['nama_pemilik'],
        periodeByr: json['periode_byr'],
        jkm: json['jkm'],
        jkk: json['jkk'],
        jht: json['jht'],
        jp: json['jp'],
        adminFee: json['admin_fee'],
        totalTagihan: json['total_tagihan'],
        total: json['total'],
        noTransaksi: json['no_transaksi'],
        createdAt: DateTime.parse(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "walletId": walletId,
        "transactionId": transactionId,
        "no_ktp": noKtp,
        "nama_pemilik": namaPemilik,
        "periode_byr": periodeByr,
        "jkm": jkm,
        "jkk": jkk,
        "jht": jht,
        "jp": jp,
        "admin_fee": adminFee,
        "total_tagihan": totalTagihan,
        "total": total,
        "no_transaksi": noTransaksi,
        "createdAt": createdAt
      };
}
