import 'package:flutter/material.dart';
import 'dart:convert';

class PpobService {
  Image image;
  Color color;
  String title;

  PpobService({this.image, this.title, this.color});
}

class IslamService {
  Image image;
  Color color;
  String title;

  IslamService({this.image, this.title, this.color});
}

class BarangService {
  String title;
  String image;
  BarangService({this.title, this.image});
}

KatalogService katalogServiceFromJson(String str) => KatalogService.fromJson(json.decode(str));

String katalogServiceToJson(KatalogService data) => json.encode(data.toJson());

class KatalogService {
    List<Katalog> data;
    String message;

    KatalogService({
        this.data,
        this.message,
    });

    factory KatalogService.fromJson(Map<String, dynamic> json) => KatalogService(
        data: List<Katalog>.from(json["data"].map((x) => Katalog.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
    };
}

class Katalog {
    int sellerId;
    List<Product> products;

    Katalog({
        this.sellerId,
        this.products,
    });

    factory Katalog.fromJson(Map<String, dynamic> json) => Katalog(
        sellerId: json["sellerId"],
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "sellerId": sellerId,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
    };
}

class Product {
    int produkId;
    String namaProduk;
    int hargaProduk;
    String deskripsiProduk;
    List<Photo> photos;

    Product({
        this.produkId,
        this.namaProduk,
        this.hargaProduk,
        this.deskripsiProduk,
        this.photos,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        produkId: json["produkId"],
        namaProduk: json["nama_produk"],
        hargaProduk: json["harga_produk"],
        deskripsiProduk: json["deskripsi_produk"],
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "produkId": produkId,
        "nama_produk": namaProduk,
        "harga_produk": hargaProduk,
        "deskripsi_produk": deskripsiProduk,
        "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
    };
}

class Photo {
    String photo;

    Photo({
        this.photo,
    });

    factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        photo: json["photo"],
    );

    Map<String, dynamic> toJson() => {
        "photo": photo,
    };
}

