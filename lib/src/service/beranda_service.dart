import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ansor_build/src/model/branda_model.dart';

class BerandaService {
  // String baseUrl = "http://192.168.10.11:3000";
  String baseUrl = "http://103.9.125.18:3000";

  Future<List<PpobService>> fetchPpobService() async {
    List<PpobService> _ppobServiceList = [];
    _ppobServiceList.add(PpobService(
        image: Image.asset('lib/src/assets/PULSA.png'), title: "PULSA"));
    _ppobServiceList.add(PpobService(
        image: Image.asset('lib/src/assets/LISTRIK.png'),
        title: "Listrik PLN"));
    _ppobServiceList.add(PpobService(
        image: Image.asset('lib/src/assets/PDAM.png'), title: "Air PDAM"));
    _ppobServiceList.add(PpobService(
        image: Image.asset('lib/src/assets/BPJS.png'), title: "BPJS"));
    _ppobServiceList.add(PpobService(
        image: Image.asset('lib/src/assets/LAINNYA.png'), title: "Lainnya"));

    return Future.delayed(Duration(seconds: 1), () {
      return _ppobServiceList;
    });
  }

  Future<List<IslamService>> fetchIslamService() async {
    List<IslamService> _islamServiceList = [];
    _islamServiceList.add(IslamService(
        image: Image.asset('lib/src/assets/KIBLAT.png'), title: "Kiblat"));
    _islamServiceList.add(IslamService(
        image: Image.asset('lib/src/assets/JAM_SOLAT.png'),
        title: "Jam Sholat"));
    _islamServiceList.add(IslamService(
        image: Image.asset('lib/src/assets/CARI_MASJID.png'),
        title: "Cari Masjid"));
    _islamServiceList.add(IslamService(
        image: Image.asset('lib/src/assets/QURAN.png'), title: "Quran & Doa"));
    _islamServiceList.add(IslamService(
        image: Image.asset('lib/src/assets/JADWAL_KAJIAN.png'),
        title: "Jadwal Kajian"));

    return Future.delayed(Duration(seconds: 1), () {
      return _islamServiceList;
    });
  }

  // Future<KatalogService> getKatalog() async {
  //   var response = await http.get(
  //     '$baseUrl/master-data/katalog-produk',
  //     headers: {"accept": "application/json"},
  //   );
  //   if (response.statusCode == 200) {
  //     return katalogServiceFromJson(response.body);
  //   } else {
  //     return null;
  //   }
  // }

  Future<List<BarangService>> fetchBarangService() async {
    List<BarangService> _goBarangServiceFeaturedList = [];
    _goBarangServiceFeaturedList.add(BarangService(
        title: "Steak Andakar", image: "lib/src/assets/produk.jpeg"));
    _goBarangServiceFeaturedList.add(BarangService(
        title: "Mie Ayam Tumini", image: "lib/src/assets/produk.jpeg"));
    _goBarangServiceFeaturedList.add(BarangService(
        title: "Tengkleng Hohah", image: "lib/src/assets/produk.jpeg"));
    _goBarangServiceFeaturedList.add(BarangService(
        title: "Warung Steak", image: "lib/src/assets/produk.jpeg"));
    _goBarangServiceFeaturedList.add(BarangService(
        title: "Kindai Warung Banjar", image: "lib/src/assets/produk.jpeg"));

    return Future.delayed(Duration(seconds: 1), () {
      return _goBarangServiceFeaturedList;
    });
  }
}
