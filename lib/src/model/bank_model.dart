import 'dart:convert';

class Banks {
  List<DataBanks> data;
  final String message;

  Banks({this.data, this.message});

  factory Banks.fromJson(Map<String, dynamic> json) => Banks(
      data:
          List<DataBanks>.from(json["data"].map((x) => DataBanks.fromJson(x))),
      message: json['message']);

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message
      };
}

class DataBanks {
  int id;
  String nama_bank;

  DataBanks({this.id, this.nama_bank});

  factory DataBanks.fromJson(Map<String, dynamic> json) =>
      DataBanks(id: json["id"], nama_bank: json["nama_bank"]);

  Map<String, dynamic> toJson() => {"id": id, "nama_bank": nama_bank};
}
