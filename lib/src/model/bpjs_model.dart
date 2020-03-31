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