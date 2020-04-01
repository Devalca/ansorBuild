import 'dart:convert';

class Bulan{
  List<DataBulan> data;
  final String message;

  Bulan({
    this.data,
    this.message
  });

  factory Bulan.fromJson(Map<String, dynamic> json) => Bulan(
    data: List<DataBulan>.from(json["data"].map((x) => DataBulan.fromJson(x))),
    message: json['message']
  );

  Map<String, dynamic> toJson()=>{
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message
  };
}

class DataBulan{
  int id;
  String tanggal;
  String nama;

  DataBulan({
    this.id,
    this.tanggal,
    this.nama
  });

  factory DataBulan.fromJson(Map<String, dynamic> json) => DataBulan(
    id: json["id"],
    tanggal: json["tanggal"],
    nama: json["nama"]
  );

  Map<String, dynamic> toJson()=>{
    "id": id,
    "tanggal": tanggal,
    "nama": nama,
  };
}

PostKesehatan kesehatanFromJson(String str) => PostKesehatan.fromJson(json.decode(str));
String kesehatanToJson(PostKesehatan data) => json.encode(data.toJson());

class PostKesehatan{
  String noVa;
  String periode;

  PostKesehatan({
    this.noVa,
    this.periode,
  });

  factory PostKesehatan.fromJson(Map<String, dynamic> json) => PostKesehatan(
    noVa: json['noVa'],
    periode: json['periode']
  );

  Map<String, dynamic> toJson()=>{
    "no_va": noVa,
    "periode": periode
  };
}

DetailKesehatan pembayaranFromJson(String str) => DetailKesehatan.fromJson(json.decode(str));
String pembayaranToJson(DetailKesehatan data) => json.encode(data.toJson());

class DetailKesehatan{
  List<DataKesehatan> data;
  String message;

  DetailKesehatan({
    this.data,
    this.message,
  });

  factory DetailKesehatan.fromJson(Map<String, dynamic> json) => DetailKesehatan(
    data: List<DataKesehatan>.from(json["data"].map((x) => DataKesehatan.fromJson(x))),
    message: json['message'],
  );

  Map<String, dynamic> toJson()=>{
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
  };
}

class DataKesehatan{
  int transactionId;
  int noVa;
  String namaPelanggan;
  int jumlahKeluarga;
  int total;
  DateTime periode;
  int jlhBulan;

  DataKesehatan({
    this.transactionId,
    this.noVa,
    this.namaPelanggan,
    this.jumlahKeluarga,
    this.total,
    this.periode,
    this.jlhBulan
  });

  factory DataKesehatan.fromJson(Map<String, dynamic> json) => DataKesehatan(
    transactionId: json['transactionId'],
    noVa: json['noVa'],
    namaPelanggan: json['namaPelanggan'],
    jumlahKeluarga: json['jumlahKeluarga'],
    total: json['total'],
    periode: DateTime.parse(json['periode']),
    jlhBulan: json['jlhBulan']
  );

  Map<String, dynamic> toJson()=>{
    "transactionId": transactionId,
    "no_va": noVa,
    "nama_pelanggan": namaPelanggan,
    "jlh_keluarga": jumlahKeluarga,
    "total": total,
    "periode": periode,
    "jlh_bulan": jlhBulan
  };
}